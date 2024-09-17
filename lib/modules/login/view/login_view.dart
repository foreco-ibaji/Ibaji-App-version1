import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ibaji/modules/login/controller/login_controller.dart';
import 'package:ibaji/resources/resources.dart';
import 'package:ibaji/util/app_text_styles.dart';
import '../../../util/app_colors.dart';
import '../../../util/global_variables.dart';
import '../../../util/routes/routes.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary6,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: SvgPicture.asset(
                  Svgs.icHomeLogo,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await controller.signInWithKakao();
                // Get.toNamed(Routes.main);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                margin: EdgeInsets.symmetric(horizontal: 24.w)
                    .copyWith(bottom: 90.h),
                decoration: BoxDecoration(
                    color: AppColors.kakao,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  children: [
                    SvgPicture.asset(Svgs.icLoginKakao18),
                    Expanded(
                        child: Center(
                            child: Text(
                      '카카오로 로그인하기',
                      style: AppTextStyles.title2Bold,
                    ))),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
