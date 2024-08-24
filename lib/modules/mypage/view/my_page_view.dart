import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ibaji/modules/mypage/controller/my_page_controller.dart';
import 'package:ibaji/modules/mypage/widget/shopping_button.dart';
import 'package:ibaji/modules/mypage/widget/use_info.dart';
import 'package:ibaji/modules/mypage/widget/user_info_card.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:ibaji/util/app_text_styles.dart';
import 'package:ibaji/util/global_variables.dart';

import '../../../resources/resources.dart';

class MyPageScreen extends GetView<MyPageController> {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "미션",
              style:
                  AppTextStyles.heading2Bold.copyWith(color: AppColors.grey9),
            ),
            SizedBox(
              height: 34.h,
            ),
            Obx(
              () => UserInfoCard(
                profileUrl: controller.mypage.value.profileUrl,
                name: controller.mypage.value.name,
                point: controller.mypage.value.point,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            const ShoppingButton(
              iconUrl: Svgs.icBasket,
              title: "쇼핑하기",
              content: "위즈 머니로 원하는 상품을 교환해보세요!",
            ),
            SizedBox(
              height: 40.h,
            ),
            const UseInfo(),
          ],
        ),
      ),
    );
  }
}
