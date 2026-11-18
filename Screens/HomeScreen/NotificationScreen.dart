// Screens/NotificationScreen/NotificationScreen.dart
import 'package:flutter/material.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Widgets/HomeScreenWidget/NotificationItemWidget.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String timeAgo;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timeAgo,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<NotificationModel> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = [
      NotificationModel(
        id: '1',
        title: 'New Notification',
        message: 'Lorem ipsum Lorem ipsum Lorem ipsum',
        timeAgo: '3 Hours ago',
      ),
      NotificationModel(
        id: '2',
        title: 'New Notification',
        message: 'Lorem ipsum Lorem ipsum Loum',
        timeAgo: '3 Hours ago',
      ),
    ];
  }

  void _dismissNotification(String id) {
    setState(() {
      _notifications.removeWhere((n) => n.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: _notifications.isEmpty
          ? Center(
        child: Text(
          'No notifications',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      )
          : SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: 12,
        ),
        child: Column(
          children: _notifications
              .map((notification) => NotificationItemWidget(
            title: notification.title,
            message: notification.message,
            timeAgo: notification.timeAgo,
            onDismiss: () => _dismissNotification(notification.id),
          ))
              .toList(),
        ),
      ),
    );
  }
}