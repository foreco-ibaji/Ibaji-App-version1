import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ibaji/resources/resources.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:ibaji/util/app_text_styles.dart';
import 'package:ibaji/util/global_variables.dart';

//TODO: 세부 detail UI 수정 필요
class CommonAppBar2 extends AppBar {
  CommonAppBar2({
    Key? key,
    super.leading,
    String? titleText,
    Color? titleColor,
    Widget? action,
    Color? backgroundColor,
  }) : super(
            key: key,
            centerTitle: true,
            title: (titleText != null)
                ? Text(
                    titleText,
                    style: AppTextStyles.title2SemiBold
                        .copyWith(color: AppColors.grey9),
                  )
                : null,
            actions: (action != null) ? [action] : null,
            backgroundColor: backgroundColor ?? Colors.transparent,
            elevation: 0.0,
            leadingWidth: 50.w);

  factory CommonAppBar2.normal({
    Key? key,
    String? title,
    String? leadingIcon,
    Function()? onTabBack,
    Color? backgroundColor,
  }) =>
      CommonAppBar2(
        key: key,
        backgroundColor: backgroundColor,
        leading: GestureDetector(
          onTap: () {
            if (onTabBack == null) {
              Get.back();
              return;
            }
            onTabBack.call();
          },
          child: Container(
            padding: EdgeInsets.all(10.w) + EdgeInsets.only(left: 18.w),
            child: SvgPicture.asset(
              leadingIcon ?? Svgs.icArrowLeft14,
            ),
          ),
        ),
        titleText: title,
      );
}
