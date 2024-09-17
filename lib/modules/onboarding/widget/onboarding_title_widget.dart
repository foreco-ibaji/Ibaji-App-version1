import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../util/app_colors.dart';
import '../../../util/app_text_styles.dart';

class OnboardingTitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const OnboardingTitleWidget(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 106.w,
        ),
        Text(
          title,
          style: AppTextStyles.heading2Bold,
        ),
        SizedBox(
          height: 10.w,
        ),
        Text(
          subtitle,
          style: AppTextStyles.title2Medium.copyWith(
            color: AppColors.grey5,
          ),
        ),
        SizedBox(
          height: 40.w,
        ),
      ],
    );
  }
}
