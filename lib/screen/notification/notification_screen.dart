import 'package:flutter/material.dart';
import 'package:coursenligne/config/theme/theme.dart';
import 'notification_body.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = '/notifications';
  
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.colorTint700,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(color: AppColors.colorTint700),
        ),
      ),
      body: const NotificationBody(),
    );
  }
} 