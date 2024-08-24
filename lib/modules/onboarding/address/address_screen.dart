import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../util/app_colors.dart';
import '../../../util/app_text_styles.dart';
import '../../../util/global_button_widget.dart';
import 'address_controller.dart';

class AddressScreen extends GetView<AddressController> {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(
          () => Container(
            height: 52.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GlobalButton.primary6(
              onTap: controller.goNextOnboardingStep,
              isActive: controller.address.value.isNotEmpty,
              text: "선택하고 시작하기",
            ),
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
                '어느 동네에\n거주하고 계시나요?',
                style: AppTextStyles.heading2Bold,
              ),
              SizedBox(
                height: 10.w,
              ),
              Text(
                '거주하고계신 동네에 맞는 배출법을 알려드릴게요',
                style: AppTextStyles.title2Medium.copyWith(
                  color: AppColors.grey5,
                ),
              ),
              SizedBox(
                height: 40.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
