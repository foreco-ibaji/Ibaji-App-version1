import 'package:dotted_border/dotted_border.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibaji/util/app_text_styles.dart';

import '../../../util/app_colors.dart';
import '../../../util/global_variables.dart';

Widget AnswerChip({required String text}) {
  return FDottedLine(
    height: 42.h,
    color: AppColors.grey3,
    strokeWidth: 1,
    corner: FDottedLineCorner.all(20),

    /// add widget
    child: IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.h),
        decoration: BoxDecoration(
          color: AppColors.grey1,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTextStyles.title3Bold.copyWith(color: AppColors.grey4),
          textHeightBehavior:
              TextHeightBehavior(applyHeightToFirstAscent: false),
        ),
      ),
    ),
  );
}

Widget AnswerSelectChip({required String text}) {
  return IntrinsicHeight(
    child: Container(
      height: 42.h,
      padding: EdgeInsets.symmetric(vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primary6, width: 1.w),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: AppTextStyles.title3Bold.copyWith(color: AppColors.primary6),
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
      ),
    ),
  );
}

Widget MissionInfoChip(
    {required Color backgroundColor, required String text, String? imgDir}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
    decoration: BoxDecoration(
        color: backgroundColor, borderRadius: BorderRadius.circular(32.r)),
    child: Row(
      children: [
        imgDir != null
            ? SizedBox(
                width: 18.h,
                child: SvgPicture.asset(
                  imgDir,
                  height: 14.h,
                ))
            : const SizedBox.shrink(),
        Text(
          text,
          style: AppTextStyles.body2SemiBold.copyWith(color: AppColors.grey1),
        ),
      ],
    ),
  );
}
