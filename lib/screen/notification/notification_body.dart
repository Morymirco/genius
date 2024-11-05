import 'package:flutter/material.dart';
import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/util/util.dart';
import 'widgets/notification_tile.dart';

class NotificationBody extends StatefulWidget {
  const NotificationBody({Key? key}) : super(key: key);

  @override
  State<NotificationBody> createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  List<Map<String, dynamic>> notifications = [
    {
      "title": "Nouveau cours disponible",
      "message": "Le cours 'Flutter Avancé' est maintenant disponible !",
      "time": "Il y a 2h",
      "isRead": false,
      "type": "course",
    },
    {
      "title": "Promotion",
      "message": "50% de réduction sur tous les cours cette semaine!",
      "time": "Il y a 2j",
      "isRead": true,
      "type": "promo",
    },
    {
      "title": "Rappel",
      "message": "N'oubliez pas de terminer votre cours de UI/UX Design",
      "time": "Il y a 3j",
      "isRead": true,
      "type": "reminder",
    },
  ];

  void _dismissNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification['isRead'] = true;
      }
    });
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'course':
        return Icons.school;
      case 'promo':
        return Icons.local_offer;
      case 'reminder':
        return Icons.alarm;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'course':
        return const Color(0xFF43BCCD);
      case 'promo':
        return Colors.orange;
      case 'reminder':
        return const Color(0xFF6A3085);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return notifications.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_none,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Aucune notification',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${notifications.length} Notifications',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorTint700,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _markAllAsRead,
                      icon: const Icon(
                        Icons.done_all,
                        color: Color(0xFF43BCCD),
                        size: 20,
                      ),
                      label: const Text(
                        'Tout marquer comme lu',
                        style: TextStyle(
                          color: Color(0xFF43BCCD),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return Dismissible(
                      key: Key(notification['title']),
                      background: Container(
                        color: Colors.red.shade100,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) => _dismissNotification(index),
                      child: NotificationTile(
                        title: notification['title'],
                        message: notification['message'],
                        time: notification['time'],
                        isRead: notification['isRead'],
                        icon: _getNotificationIcon(notification['type']),
                        iconColor: _getNotificationColor(notification['type']),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
} 