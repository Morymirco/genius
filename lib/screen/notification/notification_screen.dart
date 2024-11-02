import 'package:flutter/material.dart';
import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/util/util.dart';
import 'notification_body.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = '/notifications';
  
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.colorTint700,
            fontSize: getProportionateScreenWidth(17)
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: _back(context),
      ),
      body: const NotificationBody(),
    );
  }

  Widget _back(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      margin: EdgeInsets.only(left: getProportionateScreenWidth(15)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.colorTint400)
      ),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.colorTint600,
          size: 18,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
} 