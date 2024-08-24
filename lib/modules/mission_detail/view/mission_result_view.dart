import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ibaji/model/mission_detail/mission_detail.dart';
import 'package:ibaji/util/app_text_styles.dart';
import 'package:ibaji/util/global_button_widget.dart';
import 'package:ibaji/util/global_variables.dart';
import '../../../resources/resources.dart';
import '../../../util/app_colors.dart';
import '../../../util/routes/routes.dart';

class MissionResultScreen extends StatelessWidget {
  final bool isSuccess;
  final MissionDetail mission;
  final int id;

  const MissionResultScreen(
      {super.key,
      required this.isSuccess,
      required this.mission,
      required this.id});

//TODO: add mission result with mission_detail -> answer
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary6,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 33.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isSuccess ? "축하해요!" : "아쉽지만",
              style: AppTextStyles.heading2Bold
                  .copyWith(color: AppColors.primary1),
              textAlign: TextAlign.center,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isSuccess
                      ? "${mission.missionInfo.rewardPoint} 포인트 얻었어요"
                      : "다음 퀴즈에 또 만나요",
                  style: AppTextStyles.heading2Bold
                      .copyWith(color: AppColors.primary1),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 3.5.w,
                ),
                Image.asset(
                  isSuccess ? Images.icMissionSuccess : Images.icMissionFailure,
                  width: 28.w,
                )
              ],
            ),
            SizedBox(
              height: 36.h,
            ),
            Card(
              color: AppColors.white,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //1.image
                    Image.network(
                      mission.answer.imageUrl,
                      width: 310.w,
                    ),
                    //2. answer
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isSuccess ? "딩동댕!" : "아쉽게도 오답!",
                              style: AppTextStyles.title2Bold.copyWith(
                                  color: isSuccess
                                      ? AppColors.primary6
                                      : AppColors.territory),
                            ),
                            Text("정답은 ${mission.answer.name}에요",
                                style: AppTextStyles.title1SemiBold),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              mission.answer.disposalMethod,
                              style: AppTextStyles.title1SemiBold
                                  .copyWith(color: AppColors.grey7),
                            ),
                          ],
                        ))
                  ]),
            ),
            SizedBox(
              height: 49.h,
            ),
            Row(
              children: [
                Expanded(child: GlobalButton.darkPrimary9(onTap: () async {
                  await Get.toNamed(Routes.main);
                })),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(child: GlobalButton.lightPrimary3(onTap: () async {
                  await Get.offAllNamed(Routes.missionDetail,
                      arguments: {"missionId": id});
                })),
              ],
            )
          ],
        ),
      ),
    );
  }
}
