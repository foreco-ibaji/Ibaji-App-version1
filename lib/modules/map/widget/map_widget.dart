import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:ibaji/util/app_text_styles.dart';

import '../../../resources/resources.dart';

class MapBottomContainer extends StatelessWidget {
  final String type;
  final String iconUrl;
  final String address;
  final int distance;
  final int duration;

  const MapBottomContainer(
      {super.key,
      required this.type,
      required this.iconUrl,
      required this.address,
      required this.distance,
      required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205.h,
      width: 330.w,
      margin: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w)
          .copyWith(bottom: 32.h),
      decoration: BoxDecoration(
          color: AppColors.primary7, borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 38.w,
            height: 5.h,
            decoration: BoxDecoration(
                color: AppColors.grey1,
                borderRadius: BorderRadius.circular(2.5.r)),
          ),
          SizedBox(
            height: 35.h,
          ),
          Row(
            children: [
              SvgPicture.asset(iconUrl),
              SizedBox(
                width: 12.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${type}수거함",
                    style: AppTextStyles.body1SemiBold.copyWith(
                      color: AppColors.primary3,
                    ),
                  ),
                  Text(
                    address,
                    style: AppTextStyles.title3SemiBold.copyWith(
                      color: AppColors.grey1,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 18.h,
          ),
          Row(
            children: [
              InformChip.location(disatnce: distance),
              SizedBox(
                width: 9.w,
              ),
              InformChip.walk(duration: duration)
            ],
          )
        ],
      ),
    );
  }
}

class InformChip extends StatelessWidget {
  final String iconUrl;
  final String text;
  final double maxWidth;

  const InformChip(
      {super.key,
      required this.iconUrl,
      required this.text,
      required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth // 최대 너비 설정
          ),
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.primary9,
        borderRadius: BorderRadius.circular(1000.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(iconUrl),
          SizedBox(
            width: 5.5.w,
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body1Medium.copyWith(
                color: AppColors.grey1,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  factory InformChip.location({required int disatnce}) {
    return InformChip(
      iconUrl: Svgs.icLocationPin16,
      text: "현재 위치에서 ${disatnce}m",
      maxWidth: 158.w,
    );
  }

  factory InformChip.walk({required int duration}) {
    return InformChip(
      iconUrl: Svgs.icWalk16,
      text: "걸어서 ${duration}분",
      maxWidth: 120.w,
    );
  }
}

class MapTypeChip extends StatelessWidget {
  final bool isSelected;
  final String text;

  const MapTypeChip({super.key, required this.isSelected, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? AppColors.primary6 : AppColors.grey1,
          border: !isSelected ? Border.all(color: AppColors.grey2) : null,
          borderRadius: BorderRadius.circular(1000.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: Offset(0, 2.h),
                      blurRadius: 4.r,
                      spreadRadius: 0.r),
                ]
              : null),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      child: Text(
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        text,
        style: isSelected
            ? AppTextStyles.title3Bold.copyWith(color: AppColors.grey1)
            : AppTextStyles.title3SemiBold.copyWith(color: AppColors.grey7),
      ),
    );
  }
}
