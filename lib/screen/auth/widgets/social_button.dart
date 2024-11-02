import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coursenligne/config/theme/theme.dart';

class SocialButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onPressed;
  final bool isApple;

  const SocialButton({
    Key? key,
    required this.iconPath,
    required this.label,
    required this.onPressed,
    this.isApple = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: isApple ? Colors.black : Colors.white,
          side: BorderSide(
            color: isApple ? Colors.black : AppColors.colorTint300,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 24,
              width: 24,
              colorFilter: isApple 
                ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                : null,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isApple ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 