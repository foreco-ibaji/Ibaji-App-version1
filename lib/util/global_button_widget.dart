import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibaji/provider/api/util/secret_key.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:ibaji/util/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final int horizontalPadding;
  final int verticalPadding;
  final Color backgroundColor;
  final Color borderColor;
  final Future<void> Function()? onTap;

  const GlobalButton(
      {super.key,
      required this.text,
      required this.textStyle,
      required this.backgroundColor,
      required this.onTap,
      this.horizontalPadding = 0,
      required this.verticalPadding,
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding.w, vertical: verticalPadding.h),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.r)),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }

  ///지도 navigate button component
  factory GlobalButton.moveMapScreen({onTap}) {
    return GlobalButton(
        text: "근처 수거함 위치 보기",
        textStyle: AppTextStyles.title3Bold.copyWith(color: AppColors.grey1),
        horizontalPadding: 16,
        verticalPadding: 8,
        backgroundColor: AppColors.primary8,
        onTap: onTap);
  }

  ///배출 방법 상세페이지 이동 버튼 component
  factory GlobalButton.moveDetailScreenDetail({onTap}) {
    return GlobalButton(
        text: "배출 방법 보기",
        textStyle:
            AppTextStyles.title3SemiBold.copyWith(color: AppColors.white),
        horizontalPadding: 30,
        verticalPadding: 6,
        backgroundColor: AppColors.primary6,
        onTap: onTap);
  }

  ///대형폐기물 신고 페이지 이동
  factory GlobalButton.moveReportBigTrash() {
    //Get.toNamed(parameter)
    return GlobalButton(
        text: "지자체에 신고하러 가기",
        textStyle: AppTextStyles.title3Bold.copyWith(color: AppColors.primary6),
        horizontalPadding: 80,
        verticalPadding: 14,
        backgroundColor: Colors.white,
        borderColor: AppColors.primary6,
        onTap: () async {
          if (!await launchUrl(
            Uri.parse(Secrets.bigTrashReport),
            mode: LaunchMode.externalApplication,
          )) {
            throw Exception('Could not launch url');
          }
        });
  }

  factory GlobalButton.missionSubmit(
      {required Function() onTap, bool isActive = false}) {
    return GlobalButton(
        text: "선택하기",
        textStyle: AppTextStyles.title2Bold.copyWith(color: AppColors.grey1),
        verticalPadding: 14,
        backgroundColor: isActive ? AppColors.primary6 : AppColors.grey3,
        onTap: () async {
          onTap();
        });
  }

  factory GlobalButton.darkPrimary9(
      {required Function() onTap, String text = "미션 홈 가기"}) {
    return GlobalButton(
        text: text,
        textStyle: AppTextStyles.title2Bold.copyWith(color: AppColors.grey1),
        verticalPadding: 14,
        backgroundColor: AppColors.primary9,
        onTap: () async {
          onTap();
        });
  }

  factory GlobalButton.lightPrimary3(
      {required Function() onTap, String text = "한번 더 도전"}) {
    return GlobalButton(
        text: text,
        textStyle: AppTextStyles.title2Bold.copyWith(color: AppColors.primary8),
        verticalPadding: 14,
        backgroundColor: AppColors.primary3,
        onTap: () async {
          onTap();
        });
  }

  factory GlobalButton.lightGrey6({required Function() onTap}) {
    return GlobalButton(
      text: "닫기",
      textStyle: AppTextStyles.title2Bold.copyWith(color: AppColors.grey9),
      verticalPadding: 14,
      backgroundColor: AppColors.white,
      borderColor: AppColors.grey6,
      onTap: () async {
        onTap();
      },
    );
  }

  factory GlobalButton.primary6(
      {required bool isActive, required VoidCallback onTap}) {
    return GlobalButton(
        text: "다음",
        textStyle: AppTextStyles.title2Bold.copyWith(color: AppColors.white),
        horizontalPadding: 30,
        verticalPadding: 14,
        backgroundColor: isActive ? AppColors.primary6 : AppColors.grey3,
        onTap: () async => onTap);
  }
}
