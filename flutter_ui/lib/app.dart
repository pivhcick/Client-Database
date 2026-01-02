import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'core/config/theme.dart';
import 'core/utils/notification_helper.dart';
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

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    // Setup notification tap handler
    final notificationHelper = NotificationHelper();
    notificationHelper.onNotificationTapped = _handleNotificationTap;
  }

  void _handleNotificationTap(String? payload) {
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
          try {
            final notification = notificationProvider.notifications.firstWhere(
              (n) => n.reminderId == reminderId,
            );

            if (!notification.isRead) {
              notificationProvider.markAsRead(notification.id);
            }
          } catch (e) {
            print('⚠️ Notification not found for reminderId: $reminderId');
          }
        }

        // Navigate to notifications page
        context.go('/notifications');
      }
    } catch (e) {
      print('Error handling notification tap: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        // Create router with auth provider
        final router = AppRouter(authProvider: authProvider).router;

        return MaterialApp.router(
          title: 'Комплексное обеспечение',
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
