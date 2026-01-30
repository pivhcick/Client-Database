import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';
import 'dart:convert';
import 'core/config/theme.dart';
import 'core/utils/notification_helper.dart';
import 'core/utils/logger.dart';
import 'core/widgets/splash_screen.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/notifications/presentation/providers/notification_provider.dart';
import 'routes/app_router.dart';

/// Root application widget
///
/// Sets up theme, providers, and routing.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Setup notification tap handler
    final notificationHelper = NotificationHelper();
    notificationHelper.onNotificationTapped = _handleNotificationTap;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      // Refresh notification count when app returns to foreground
      final notificationProvider = Provider.of<NotificationProvider>(
        context,
        listen: false,
      );
      notificationProvider.refreshUnreadCount();
    }
  }

  Future<void> _handleNotificationTap(String? payload) async {
    if (payload == null) return;

    try {
      final data = jsonDecode(payload);
      final companyId = data['companyId'] as String?;
      final reminderId = data['reminderId'] as String?;

      if (companyId != null && mounted) {
        // Find and mark notification as read if it exists
        // The notification record is created when reminder is delivered
        final notificationProvider = Provider.of<NotificationProvider>(
          context,
          listen: false,
        );

        // Try to find the notification by reminderId and mark as read
        if (reminderId != null && notificationProvider.notifications.isNotEmpty) {
          final notification = notificationProvider.notifications.firstWhereOrNull(
            (n) => n.reminderId == reminderId,
          );

          if (notification != null && !notification.isRead) {
            await notificationProvider.markAsRead(notification.id);
          } else if (notification == null) {
            AppLogger.warning('Notification not found for reminderId: $reminderId', 'App');
          }
        }

        // Navigate to notifications page
        context.go('/notifications');
      }
    } catch (e) {
      AppLogger.error('Error handling notification tap', e, null, 'App');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        // Show splash screen while auth is initializing
        if (authProvider.state == AuthState.initial ||
            authProvider.state == AuthState.loading) {
          return MaterialApp(
            title: 'Just CRM',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: const SplashScreen(),
          );
        }

        // Create router with auth provider
        final router = AppRouter(authProvider: authProvider).router;

        return MaterialApp.router(
          title: 'Just CRM',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: router,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ru', 'RU'),
            Locale('en', 'US'),
          ],
          locale: const Locale('ru', 'RU'),
        );
      },
    );
  }
}
