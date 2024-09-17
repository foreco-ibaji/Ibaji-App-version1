import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibaji/provider/service/map_service.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:ibaji/util/app_text_styles.dart';
import 'package:ibaji/util/extension.dart';
import 'package:ibaji/util/global_variables.dart';

import '../../../resources/resources.dart';

class UserInfoCard extends StatelessWidget {
  /// 마이페이지의 유저정보를 나타내는 카드 UI
  const UserInfoCard(
      {super.key,
      required this.profileUrl,
      required this.name,
      required this.point});

  final String profileUrl;
  final String name;
  final int point;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
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
                  backgroundImage: NetworkImage(profileUrl),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.heading3Bold
                          .copyWith(color: AppColors.grey1),
                    ),
                    Text(
                        "서울 ${MapService.currentAddress[1]} ${MapService.currentAddress[2]}",
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
                style:
                    AppTextStyles.title2Bold.copyWith(color: AppColors.grey1)),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("$point".transformMoneyFormat(),
                      style: AppTextStyles.heading2Bold
                          .copyWith(color: AppColors.grey1)),
                  SizedBox(
                    width: 6.w,
                  ),
                  SvgPicture.asset(Svgs.icMissionMoney,),
                ]),
          ],
        ));
  }
}
