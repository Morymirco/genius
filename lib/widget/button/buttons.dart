import 'package:flutter/material.dart';
import 'package:coursenligne/config/theme/theme.dart';

class GeneralButton extends StatelessWidget {

  const GeneralButton({
    Key ? key,
    required this.text,
    required this.onPressed,
    this.activeButton = false,
    this.icon,
    this.iconSize,
    this.iconSpacing,
    this.child
  }): super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final bool activeButton;
  final IconData? icon;
  final double? iconSize;
  final double? iconSpacing;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: activeButton ? const Color(0xFF6A3085) : AppColors.colorTint200,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: child ?? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: iconSize ?? 24,
              color: activeButton ? Colors.white : AppColors.colorTint500,
            ),
            SizedBox(width: iconSpacing ?? 8),
          ],
          Text(
            text,
            style: TextStyle(
              color: activeButton ? Colors.white : AppColors.colorTint500,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}