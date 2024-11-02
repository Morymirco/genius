import 'package:flutter/material.dart';
import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/util/util.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final bool isRead;

  const NotificationTile({
    Key? key,
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(8)),
      padding: EdgeInsets.all(getProportionateScreenWidth(15)),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : AppColors.colorAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.colorTint400,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.colorTint700,
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  color: AppColors.colorTint500,
                  fontSize: getProportionateScreenWidth(12),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(8)),
          Text(
            message,
            style: TextStyle(
              color: AppColors.colorTint600,
              fontSize: getProportionateScreenWidth(13),
            ),
          ),
        ],
      ),
    );
  }
} 