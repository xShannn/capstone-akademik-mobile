import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../widgets/admin_notification_card.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = AdminService.getNotifications();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        title: const Text('Notification'),
        backgroundColor: const Color(0xFF093FB4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: notifications
              .map(
                (item) => AdminNotificationCard(
                  title: item['title'] ?? '',
                  message: item['message'] ?? '',
                  date: item['date'] ?? '',
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
