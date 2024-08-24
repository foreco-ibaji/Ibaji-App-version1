import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ibaji/modules/onboarding/onboarding_controller.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:ibaji/util/app_text_styles.dart';
import 'package:ibaji/util/global_variables.dart';

import '../../util/global_button_widget.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 52.w,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GlobalButton.primary6(
            onTap: controller.goNextOnboardingStep,
            isActive: controller.selectType.value != null,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 106.w,
              ),
              Text(
                '거주형태가\n어떻게 되시나요?',
                style: AppTextStyles.heading2Bold,
              ),
              SizedBox(
                height: 10.w,
              ),
              Text(
                '거주 형태에 따른 맞춤별 배출법을 알 수 있어요',
                style: AppTextStyles.title2Medium.copyWith(
                  color: AppColors.grey5,
                ),
              ),
              SizedBox(
                height: 40.w,
              ),
              Row(
                children: [
                  Expanded(
                      child: Obx(() => _residentTypeItem(ResidentType.single))),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Obx(
                      () => _residentTypeItem(
                        ResidentType.multiple,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _residentTypeItem(ResidentType type) {
    return GestureDetector(
      onTap: () => controller.setResidentType(type),
      child: Container(
          height: 250.w,
          padding: EdgeInsets.symmetric(horizontal: 16.w)
              .copyWith(top: 24.w, bottom: 12.w),
          decoration: BoxDecoration(
            color: AppColors.grey1,
            borderRadius: BorderRadius.circular(8),
            border: controller.selectType.value == type
                ? Border.all(color: AppColors.primary6, width: 2.w)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type.title,
                  style: AppTextStyles.heading3Bold
                      .copyWith(color: AppColors.grey9)),
              SizedBox(height: 8.w),
              SizedBox(
                width: 128.w,
                child: Text(type.subtitle,
                    style: AppTextStyles.title3Medium
                        .copyWith(color: AppColors.grey7)),
              ),
              SizedBox(
                height: 28.w,
              ),
              Container(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    type.imgUrl,
                    height: 70.w,
                  )),
            ],
          )),
    );
  }
}
