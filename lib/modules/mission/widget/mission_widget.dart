import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ibaji/provider/api/util/global_mock_data.dart';
import 'package:ibaji/util/app_text_styles.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../model/enum/level_type.dart';
import '../../../model/mission/mission.dart';
import '../../../resources/resources.dart';
import '../../../util/app_colors.dart';
import '../../../util/global_button_widget.dart';
import '../../../util/global_variables.dart';
import '../../../util/routes/routes.dart';
import '../../../util/widget/global_chip.dart';

class MissionListTile extends StatelessWidget {
  final Mission mission;
  final String missionType;

  const MissionListTile(
      {super.key, this.mission = tmpMission, this.missionType = "ETC"});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (missionType == "ETC") {
          if (Platform.isAndroid) {
            launchUrlString(
                    mode: LaunchMode.externalApplication,
                    mission.missionUrl ?? "")
                .catchError((err) {
              launchUrlString(mode: LaunchMode.externalApplication, '');
              return true;
            });
          }
          //IOS
          else if (Platform.isIOS) {
            launchUrlString(mission.missionUrl ?? "").catchError((err) {
              launchUrlString('');
              return true;
            });
          }
        } else {
          await Get.toNamed(Routes.missionDetail,
              arguments: {"missionId": mission.id});
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 30.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 64.h,
              width: 64.h,
              decoration: const BoxDecoration(
                  color: AppColors.grey1, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Image.network(
                mission.iconUrl,
                height: 24.h,
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 185.w,
                      child: Text(
                        mission.title,
                        style: AppTextStyles.title2SemiBold.copyWith(
                          color: AppColors.grey9,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    TextChip.missionLevel(
                        level: levelStatusMap[mission.difficulty] ??
                            LevelStatus.MIDDLE)
                  ],
                ),
                SizedBox(
                  width: 230.w,
                  child: Text(
                    mission.description,
                    style: AppTextStyles.body1SemiBold.copyWith(
                      color: AppColors.grey7,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  children: [
                    MissionInfo(
                      icon: Svgs.icMissionMoney,
                      value: "${mission.rewardPoint}",
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    MissionInfo(
                      icon: Svgs.icMissionCount,
                      value:
                          "${mission.totalNumberOfParticipating}/${mission.totalCount} 참여중",
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextChip.missionCount(
                    count: mission.personalParticipatingCount,
                    total: mission.personalCount)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget MissionInfo({
  required String icon,
  required String value,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgPicture.asset(
        icon,
        width: 15.w,
      ),
      SizedBox(
        width: 4.w,
      ),
      Text(
        value,
        style: AppTextStyles.title3SemiBold.copyWith(
          color: AppColors.grey8,
        ),
      ),
    ],
  );
}

Widget SelectTypeChip({
  String value = "순",
  required RxBool isSelect,
  bool isIcon = false,
}) {
  return Obx(
    () => Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
          color: isSelect.value ? AppColors.grey9 : AppColors.grey1,
          borderRadius: BorderRadius.circular(32.r),
          border: !isSelect.value ? Border.all(color: AppColors.grey2) : null),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppTextStyles.title3SemiBold.copyWith(
                color: isSelect.value ? AppColors.grey1 : AppColors.grey8),
          ),
          SizedBox(
            width: 4.w,
          ),
          isIcon
              ? SvgPicture.asset(
                  Svgs.icArrowDown,
                  width: 14.w,
                  // height: 21.h,
                  color: AppColors.grey9,
                )
              : const SizedBox.shrink(),
        ],
      ),
    ),
  );
}

///* bottomSheeet
class LevelSelectSheet extends StatelessWidget {
  final Rx<LevelStatus> selectLevel;

  const LevelSelectSheet({super.key, required this.selectLevel});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
        ),
        child: Obx(
          () => Column(children: [
            for (final level in LevelStatus.values)
              LevelSelectTile(
                  levelStatus: level,
                  isSelect: selectLevel.value == level ? true.obs : false.obs),
            SizedBox(
              height: 37.h,
            ),
            Row(
              children: [
                Expanded(
                  child: GlobalButton.lightGrey6(onTap: () {
                    Get.back();
                  }),
                )
              ],
            ),
            SizedBox(
              height: 29.h,
            ),
            Container(
              width: 135.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(2.5.r),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget LevelSelectTile(
      {required LevelStatus levelStatus, required RxBool isSelect}) {
    return GestureDetector(
      onTap: () {
        selectLevel.value = levelStatus;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "난이도 ${levelStatus.stateName}",
              style: AppTextStyles.title2Bold.copyWith(
                color: AppColors.grey8,
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            SvgPicture.asset(
              isSelect.value ? Svgs.icCheckAble : Svgs.icCheckUnable,
              width: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}
