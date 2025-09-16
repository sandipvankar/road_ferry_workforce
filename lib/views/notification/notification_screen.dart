import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackgroundColor,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.titleTextColor,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read functionality
            },
            child: Text(
              'Read All',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationItem(
            'New Order Request',
            'Exciting opportunity! You\'ve received a new shipment request. Check it out now!',
            '16 days ago',
          ),
          _buildNotificationItem(
            'Shipment Assignment',
            'You\'re assigned! Nishant Thankar (9726166635) has allocated you a new shipment (ID: 7852666).',
            '45 days ago',
          ),
          _buildNotificationItem(
            'New Order Request',
            'Exciting opportunity! You\'ve received a new shipment request. Check it out now!',
            '45 days ago',
          ),
          _buildNotificationItem(
            'New Order Request',
            'Exciting opportunity! You\'ve received a new shipment request. Check it out now!',
            '45 days ago',
          ),
          _buildNotificationItem(
            'New Order Request',
            'Exciting opportunity! You\'ve received a new shipment request. Check it out now!',
            '45 days ago',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String title, String message, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notifications, color: AppColors.primaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(color: AppColors.subTitleTextColor, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(time, style: TextStyle(color: AppColors.greyText, fontSize: 12)),
        ],
      ),
    );
  }
}
