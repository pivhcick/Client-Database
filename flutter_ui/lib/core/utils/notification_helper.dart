import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

/// Local notifications helper
///
/// Manages scheduling and displaying local notifications
/// for reminders
class NotificationHelper {
  static final NotificationHelper _instance = NotificationHelper._internal();
  factory NotificationHelper() => _instance;
  NotificationHelper._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Initialize notifications
  Future<void> init() async {
    if (_initialized) {
      print('⚠️ NotificationHelper already initialized');
      return;
    }

    print('🔔 Initializing timezone data...');
    // Initialize timezone
    tz.initializeTimeZones();

    // ✅ Установить локальную временную зону устройства
    final String timeZoneName = DateTime.now().timeZoneName;
    print('🔔 Device timezone name: $timeZoneName');

    // iOS и некоторые платформы возвращают аббревиатуры (MSK, GMT+3),
    // которые не работают с timezone package.
    // Пробуем несколько способов определить timezone:
    try {
      // Сначала пробуем по имени (работает на Android и некоторых платформах)
      tz.setLocalLocation(tz.getLocation(timeZoneName));
      print('✅ Timezone set to: ${tz.local.name}');
    } catch (e) {
      print('⚠️ Could not set timezone by name "$timeZoneName": $e');

      // Если не получилось, определяем по offset
      final offset = DateTime.now().timeZoneOffset;
      final offsetHours = offset.inHours;
      print('🔔 Device timezone offset: GMT${offsetHours >= 0 ? '+' : ''}$offsetHours');

      // Mapping основных часовых поясов по offset
      // Примечание: это упрощенный mapping, не учитывает DST
      final Map<int, String> timezoneByOffset = {
        -12: 'Etc/GMT+12',
        -11: 'Pacific/Midway',
        -10: 'Pacific/Honolulu',
        -9: 'America/Anchorage',
        -8: 'America/Los_Angeles',
        -7: 'America/Denver',
        -6: 'America/Chicago',
        -5: 'America/New_York',
        -4: 'America/Halifax',
        -3: 'America/Sao_Paulo',
        -2: 'Atlantic/South_Georgia',
        -1: 'Atlantic/Azores',
        0: 'Europe/London',
        1: 'Europe/Paris',
        2: 'Europe/Helsinki',
        3: 'Europe/Moscow',
        4: 'Asia/Dubai',
        5: 'Asia/Karachi',
        6: 'Asia/Dhaka',
        7: 'Asia/Bangkok',
        8: 'Asia/Shanghai',
        9: 'Asia/Tokyo',
        10: 'Australia/Sydney',
        11: 'Pacific/Noumea',
        12: 'Pacific/Auckland',
      };

      final timezoneName = timezoneByOffset[offsetHours];
      if (timezoneName != null) {
        try {
          tz.setLocalLocation(tz.getLocation(timezoneName));
          print('✅ Timezone set to: $timezoneName (by offset)');
        } catch (e2) {
          print('⚠️ Could not set $timezoneName, using UTC: $e2');
        }
      } else {
        print('⚠️ Unknown offset GMT$offsetHours, using UTC');
      }
    }

    print('✅ Timezone initialized: ${tz.local.name}');

    // ✅ CRITICAL: Create Android notification channel BEFORE initialization
    // Without this, notifications won't work on Android 8.0+ (API 26+)
    const AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
      'reminders_channel',
      'Напоминания',
      description: 'Напоминания о контактах с компаниями',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    // Create the channel on Android
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        _notifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(androidChannel);
      print('✅ Android notification channel created: ${androidChannel.id}');
    }

    // Android initialization settings
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // ✅ Показывать уведомления даже когда приложение активно
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );

    // Initialization settings
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    print('🔔 Initializing flutter_local_notifications plugin...');
    // Initialize
    final initialized = await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
    print('✅ Plugin initialized: $initialized');

    _initialized = true;
  }

  /// Request permissions (iOS and Android 13+)
  Future<bool> requestPermissions() async {
    print('🔔 Requesting notification permissions...');

    // Try iOS first
    final iosPlugin = _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();

    if (iosPlugin != null) {
      print('📱 iOS detected, requesting iOS permissions...');
      final result = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      print('✅ iOS permissions result: $result');
      return result ?? true;
    }

    // Try Android (for Android 13+ / API 33+)
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      print('🤖 Android detected, requesting Android 13+ permissions...');
      final result = await androidPlugin.requestNotificationsPermission();
      print('✅ Android permissions result: $result');
      return result ?? true;
    }

    print('⚠️ No platform plugin available');
    return true;
  }

  /// Schedule a notification
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    print('🔔 NotificationHelper.scheduleNotification called:');
    print('  Notification ID: $id');
    print('  Title: $title');
    print('  Body: $body');
    print('  Scheduled date (input): $scheduledDate');
    print('  Current timezone: ${tz.local.name}');
    print('  Current time: ${DateTime.now()}');

    // ✅ Правильная конвертация локального времени в TZDateTime
    // scheduledDate - это локальное время устройства без timezone info
    // Нужно создать TZDateTime с теми же компонентами (год, месяц, день, час, минута)
    // но в правильной timezone
    final tzScheduledDate = tz.TZDateTime(
      tz.local,
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      scheduledDate.hour,
      scheduledDate.minute,
      scheduledDate.second,
    );

    print('  TZ scheduled date: $tzScheduledDate');
    print('  TZ current time: ${tz.TZDateTime.now(tz.local)}');
    print('  Time difference: ${tzScheduledDate.difference(tz.TZDateTime.now(tz.local)).inMinutes} minutes');
    print('  Payload: $payload');

    // Notification details
    const androidDetails = AndroidNotificationDetails(
      'reminders_channel',
      'Напоминания',
      channelDescription: 'Напоминания о контактах с компаниями',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      // Schedule
      await _notifications.zonedSchedule(
        id,
        title,
        body,
        tzScheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );
      print('✅ zonedSchedule completed successfully');
    } catch (e) {
      print('❌ Error scheduling notification: $e');
      rethrow;
    }
  }

  /// Show immediate notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    print('🔔 NotificationHelper.showNotification called:');
    print('  Notification ID: $id');
    print('  Title: $title');
    print('  Body: $body');
    print('  Payload: $payload');
    print('  Initialized: $_initialized');

    if (!_initialized) {
      print('❌ ERROR: NotificationHelper not initialized!');
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'reminders_channel',
      'Напоминания',
      channelDescription: 'Напоминания о контактах с компаниями',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      print('🔔 Calling _notifications.show()...');
      await _notifications.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
      print('✅ _notifications.show() completed successfully');
    } catch (e) {
      print('❌ Error showing notification: $e');
      rethrow;
    }
  }

  /// Cancel a notification
  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  /// Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }

  /// Notification tapped callback
  void _onNotificationTapped(NotificationResponse response) {
    // TODO: Handle notification tap
    // Navigate to reminder details or company details
    // based on payload
    print('Notification tapped: ${response.payload}');
  }
}
