import 'package:flutter/material.dart';

import 'package:mobile_sekolah/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  final IconData? icon;

  const CustomButton({
    super.key,

    required this.text,

    required this.onPressed,

    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      height: 55,

      child: ElevatedButton.icon(
        onPressed: onPressed,

        icon: icon != null ? Icon(icon) : const SizedBox(),

        label: Text(text),

        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,

          foregroundColor: AppColors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
