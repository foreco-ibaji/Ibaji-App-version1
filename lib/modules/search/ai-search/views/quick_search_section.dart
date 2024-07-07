import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibaji/util/app_text_styles.dart';

import '../../../../util/app_colors.dart';
import '../../../../util/global_variables.dart';

class QuickSearchSection extends StatelessWidget {
  final String keyword;
  final String iconUrl;

  const QuickSearchSection(
      {super.key, required this.keyword, required this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 158.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      decoration: BoxDecoration(
          color: AppColors.grey1, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
                color: AppColors.primary2, shape: BoxShape.circle),
            child: SvgPicture.asset(
              "$iconDir${iconUrl}.svg",
              height: 24.w,
            ),
          ),
          SizedBox(
            height: 8.w,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 120.w),
            child: Text(
              keyword,
              style: AppTextStyles.title3SemiBold,
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
