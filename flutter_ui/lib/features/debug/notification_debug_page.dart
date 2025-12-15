import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../core/utils/notification_helper.dart';
import 'package:intl/intl.dart';

/// Debug page for testing notifications
///
/// Helps diagnose notification issues on different devices
class NotificationDebugPage extends StatefulWidget {
  const NotificationDebugPage({super.key});

  @override
  State<NotificationDebugPage> createState() => _NotificationDebugPageState();
}

class _NotificationDebugPageState extends State<NotificationDebugPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  List<PendingNotificationRequest> _pendingNotifications = [];
  String _debugLog = '';
  bool _permissionsGranted = false;

  @override
  void initState() {
    super.initState();
    _loadPendingNotifications();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    _addLog('Проверка разрешений...');
    try {
      final granted = await _notificationHelper.requestPermissions();
      setState(() {
        _permissionsGranted = granted;
      });
      _addLog('Разрешения: ${granted ? "✅ ПРЕДОСТАВЛЕНЫ" : "❌ ОТКЛОНЕНЫ"}');
    } catch (e) {
      _addLog('❌ Ошибка проверки разрешений: $e');
    }
  }

  Future<void> _loadPendingNotifications() async {
    _addLog('Загрузка запланированных уведомлений...');
    try {
      final pending = await _notificationHelper.getPendingNotifications();
      setState(() {
        _pendingNotifications = pending;
      });
      _addLog('Найдено ${pending.length} запланированных уведомлений');
      for (final notification in pending) {
        _addLog('  - ID: ${notification.id}, Title: ${notification.title}');
      }
    } catch (e) {
      _addLog('❌ Ошибка загрузки: $e');
    }
  }

  void _addLog(String message) {
    final timestamp = DateFormat('HH:mm:ss').format(DateTime.now());
    setState(() {
      _debugLog = '[$timestamp] $message\n$_debugLog';
    });
    print(message);
  }

  Future<void> _testImmediateNotification() async {
    _addLog('🔔 Тест немедленного уведомления...');
    try {
      await _notificationHelper.showNotification(
        id: 999,
        title: 'Тестовое уведомление',
        body: 'Это немедленное тестовое уведомление в ${DateFormat('HH:mm:ss').format(DateTime.now())}',
      );
      _addLog('✅ Немедленное уведомление отправлено');
    } catch (e) {
      _addLog('❌ Ошибка отправки: $e');
    }
  }

  Future<void> _testScheduledNotification(int seconds) async {
    final scheduledTime = DateTime.now().add(Duration(seconds: seconds));
    _addLog('🔔 Планирование уведомления на ${DateFormat('HH:mm:ss').format(scheduledTime)} (+$seconds сек)...');

    try {
      await _notificationHelper.scheduleNotification(
        id: 998,
        title: 'Запланированное уведомление',
        body: 'Это уведомление было запланировано на $seconds секунд',
        scheduledDate: scheduledTime,
      );
      _addLog('✅ Уведомление запланировано на ${DateFormat('HH:mm:ss').format(scheduledTime)}');
      await _loadPendingNotifications();
    } catch (e) {
      _addLog('❌ Ошибка планирования: $e');
    }
  }

  Future<void> _cancelAllNotifications() async {
    _addLog('🗑️ Отмена всех уведомлений...');
    try {
      await _notificationHelper.cancelAllNotifications();
      _addLog('✅ Все уведомления отменены');
      await _loadPendingNotifications();
    } catch (e) {
      _addLog('❌ Ошибка отмены: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Диагностика уведомлений'),
        backgroundColor: const Color(0xFF006FFD),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Status card
          Card(
            margin: const EdgeInsets.all(16),
            color: _permissionsGranted ? Colors.green.shade50 : Colors.red.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _permissionsGranted ? Icons.check_circle : Icons.error,
                        color: _permissionsGranted ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Статус разрешений',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _permissionsGranted ? Colors.green.shade900 : Colors.red.shade900,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _permissionsGranted
                        ? 'Разрешения предоставлены'
                        : 'Разрешения НЕ предоставлены',
                    style: const TextStyle(fontFamily: 'Inter'),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Запланировано уведомлений: ${_pendingNotifications.length}',
                    style: const TextStyle(fontFamily: 'Inter'),
                  ),
                ],
              ),
            ),
          ),

          // Test buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _testImmediateNotification,
                    icon: const Icon(Icons.notifications_active),
                    label: const Text('Тест немедленного уведомления'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006FFD),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _testScheduledNotification(10),
                    icon: const Icon(Icons.schedule),
                    label: const Text('Запланировать через 10 сек'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C48C),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _testScheduledNotification(30),
                    icon: const Icon(Icons.schedule),
                    label: const Text('Запланировать через 30 сек'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C48C),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _loadPendingNotifications,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Обновить список'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _cancelAllNotifications,
                    icon: const Icon(Icons.delete_sweep),
                    label: const Text('Отменить все уведомления'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF53178),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Debug log
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Лог отладки:',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        _debugLog.isEmpty ? 'Нет записей' : _debugLog,
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
