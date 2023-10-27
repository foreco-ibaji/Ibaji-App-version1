import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ibaji/modules/mission/controller/mission_controller.dart';
import 'package:ibaji/util/app_text_styles.dart';
import '../../../util/app_colors.dart';
import '../../../util/global_variables.dart';

class MissionScreen extends GetView<MissionController> {
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w).copyWith(
              bottom: 40.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "미션",
                  style: AppTextStyles.heading2Bold
                      .copyWith(color: AppColors.grey9),
                ),
                SizedBox(
                  height: 34.h,
                ),
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary5,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30.r,
                              backgroundImage: NetworkImage("fdssdf"),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "이름",
                                  style: AppTextStyles.heading3Bold
                                      .copyWith(color: AppColors.grey1),
                                ),
                                Text("지역",
                                    style: AppTextStyles.title3Medium
                                        .copyWith(color: AppColors.grey1))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: AppColors.primary6,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text("위즈 머니",
                            style: AppTextStyles.title2Bold
                                .copyWith(color: AppColors.grey1)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("11213",
                                  style: AppTextStyles.heading2Bold
                                      .copyWith(color: AppColors.grey1)),
                              SizedBox(
                                width: 6.w,
                              ),
                              SvgPicture.asset(iconDir + "ic_mission_money.svg")
                            ]),
                      ],
                    )),
              ],
            ),
          ),
          Container(
            color: AppColors.grey1,
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
