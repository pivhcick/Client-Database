import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/notification_provider.dart';
import '../../domain/entities/notification_record.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

/// Notifications page
///
/// Displays all notifications with read/unread status.
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();

    // Load notifications on first open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<NotificationProvider>(context, listen: false);
      provider.loadNotifications();
    });
  }

  Future<void> _handleRefresh() async {
    final provider = Provider.of<NotificationProvider>(context, listen: false);
    await provider.refreshNotifications();
  }

  Future<void> _handleMarkAllAsRead() async {
    final provider = Provider.of<NotificationProvider>(context, listen: false);

    try {
      await provider.markAllAsRead();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Все уведомления отмечены как прочитанные')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: ${e.toString().replaceAll('Exception: ', '')}'),
            backgroundColor: const Color(0xFFF53178),
          ),
        );
      }
    }
  }

  Future<void> _handleDeleteAllRead() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить прочитанные?'),
        content: const Text(
          'Вы действительно хотите удалить все прочитанные уведомления?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFF53178),
            ),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final provider = Provider.of<NotificationProvider>(context, listen: false);

    try {
      await provider.deleteAllRead();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Прочитанные уведомления удалены')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: ${e.toString().replaceAll('Exception: ', '')}'),
            backgroundColor: const Color(0xFFF53178),
          ),
        );
      }
    }
  }

  Future<void> _handleNotificationTap(NotificationRecord notification) async {
    final provider = Provider.of<NotificationProvider>(context, listen: false);

    // Mark as read if not already read
    if (!notification.isRead) {
      try {
        await provider.markAsRead(notification.id);
      } catch (e) {
        // Ignore error - notification will still be navigated to
      }
    }

    // Navigate to company detail
    if (mounted) {
      context.go('/companies/${notification.companyId}');
    }
  }

  Future<void> _handleDeleteNotification(NotificationRecord notification) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить уведомление?'),
        content: const Text(
          'Вы действительно хотите удалить это уведомление?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFF53178),
            ),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final provider = Provider.of<NotificationProvider>(context, listen: false);

    try {
      await provider.deleteNotification(notification.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Уведомление удалено')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: ${e.toString().replaceAll('Exception: ', '')}'),
            backgroundColor: const Color(0xFFF53178),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Уведомления',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF006FFD),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Unread count badge
          Consumer<NotificationProvider>(
            builder: (context, provider, _) {
              final unreadCount = provider.unreadCount;
              if (unreadCount == 0) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF53178),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$unreadCount',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // Menu
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'mark_all_read') {
                _handleMarkAllAsRead();
              } else if (value == 'delete_read') {
                _handleDeleteAllRead();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'mark_all_read',
                child: Row(
                  children: [
                    Icon(Icons.done_all, size: 20),
                    SizedBox(width: 8),
                    Text('Отметить все как прочитанные'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete_read',
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep, size: 20, color: Color(0xFFF53178)),
                    SizedBox(width: 8),
                    Text('Удалить прочитанные', style: TextStyle(color: Color(0xFFF53178))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.notifications.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.hasError && provider.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Color(0xFFF53178),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    provider.errorMessage ?? 'Ошибка загрузки',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8F9098),
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => provider.loadNotifications(),
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }

          if (provider.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: const Color(0xFF8F9098).withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Нет уведомлений',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sora',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Здесь будут отображаться ваши напоминания',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8F9098),
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _handleRefresh,
            child: ListView.builder(
              itemCount: provider.notifications.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final notification = provider.notifications[index];
                return _buildNotificationCard(notification);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationRecord notification) {
    final dateFormatter = DateFormat('d MMMM, HH:mm', 'ru_RU');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: notification.isRead ? Colors.white : const Color(0xFFF0F7FF),
      elevation: notification.isRead ? 1 : 2,
      child: InkWell(
        onTap: () => _handleNotificationTap(notification),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Unread indicator
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 6, right: 12),
                decoration: BoxDecoration(
                  color: notification.isRead
                      ? Colors.transparent
                      : const Color(0xFF006FFD),
                  shape: BoxShape.circle,
                ),
              ),

              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF006FFD).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications,
                  color: Color(0xFF006FFD),
                  size: 20,
                ),
              ),

              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Title (заголовок)
                    Text(
                      notification.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: notification.isRead
                            ? FontWeight.w500
                            : FontWeight.w600,
                        fontFamily: 'Inter',
                        color: const Color(0xFF2F3036),
                      ),
                    ),

                    // 2. Description (описание напоминания)
                    // Body contains "CompanyName\nDescription", extract only description part
                    if (notification.body != null && notification.body!.contains('\n')) ...[
                      const SizedBox(height: 4),
                      Text(
                        notification.body!.split('\n').skip(1).join('\n').trim(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8F9098),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],

                    // 3. Company name (компания)
                    if (notification.companyName != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        notification.companyName!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF006FFD),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],

                    // 4. Time (время с учетом часового пояса)
                    const SizedBox(height: 8),
                    Text(
                      dateFormatter.format(notification.deliveredAt),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8F9098),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),

              // Delete button
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                color: const Color(0xFF8F9098),
                onPressed: () => _handleDeleteNotification(notification),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
