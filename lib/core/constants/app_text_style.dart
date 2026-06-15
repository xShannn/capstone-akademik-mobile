import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  static const heading = TextStyle(
    fontSize: 24,

    fontWeight: FontWeight.bold,

    color: AppColors.black,
  );

  static const subHeading = TextStyle(
    fontSize: 20,

    fontWeight: FontWeight.w600,

    color: AppColors.black,
  );

  static const title = TextStyle(
    fontSize: 18,

    fontWeight: FontWeight.w600,

    color: AppColors.black,
  );

  static const body = TextStyle(fontSize: 14, color: AppColors.black);

  static const caption = TextStyle(fontSize: 12, color: AppColors.grey);
}
