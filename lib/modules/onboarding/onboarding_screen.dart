import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ibaji/modules/onboarding/onboarding_controller.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:ibaji/util/app_text_styles.dart';
import 'package:ibaji/util/global_variables.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('거주형태가\n어떻게 되시나요?'),
          Text('거주 형태에 따른 맞춤별 배출법을 알 수 있어요'),
        ],
      ),
    );
  }

  Widget _residentTypeItem(ResidentType type) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w) + EdgeInsets.only(top: 12.w),
        child: Column(
      children: [
        Text(type.title,
            style: AppTextStyles.heading3Bold.copyWith(color: AppColors.grey9)),
        Text(type.subtitle,
            style: AppTextStyles.title3Medium.copyWith(color: AppColors.grey7)),
        Image.asset(imgDir + type.imgUrl),
      ],
    ));
  }
}
