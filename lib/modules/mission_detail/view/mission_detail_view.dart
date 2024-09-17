import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ibaji/modules/mission_detail/view/mission_result_view.dart';
import 'package:ibaji/resources/resources.dart';
import 'package:ibaji/util/app_text_styles.dart';
import 'package:ibaji/util/widget/global_skeleton.dart';
import '../../../provider/api/mission_api.dart';
import '../../../util/app_colors.dart';
import '../../../util/global_button_widget.dart';
import '../../../util/widget/global_chip.dart';
import '../../mission/widget/mission_widget.dart';
import '../controller/mission_detail_controller.dart';
import '../widget/mission_detail_widget.dart';

class MissionDetailScreen extends GetView<MissionDetailController> {
  const MissionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary6,
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 21.w, vertical: 31.h)
              .copyWith(bottom: 42.h),
          padding:
              EdgeInsets.symmetric(horizontal: 37.w, vertical: 42.h).copyWith(
            bottom: 21.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///1. missionInfo TextChip
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MissionInfoChip(
                        backgroundColor: AppColors.grey9,
                        text:
                            "${controller.missionDetail.value.missionInfo.rewardPoint}",
                        imgDir: Svgs.icMissionMoney,),
                    SizedBox(
                      width: 6.w,
                    ),
                    MissionInfoChip(
                      backgroundColor: AppColors.primary6,
                      text:
                          "${controller.missionDetail.value.missionInfo.personalParticipatingCount}/${controller.missionDetail.value.missionInfo.personalCount} 참여중",
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(controller.missionDetail.value.missionInfo.title,
                    style: AppTextStyles.heading2Bold),
                SizedBox(
                  height: 4.h,
                ),
                Text(controller.missionDetail.value.missionInfo.description,
                    style: AppTextStyles.title2SemiBold.copyWith(
                      color: AppColors.grey5,
                    )),
                SizedBox(
                  height: 36.h,
                ),

                ///*2. missionInfo Image
                SizedBox(
                  width: 260.h,
                  height: 260.h,
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.w,
                    crossAxisSpacing: 16.w,
                    children: controller.missionDetail.value.images
                        .map((img) => img != ""
                            ? Image.network(
                                img,
                                width: 122.w,
                                height: 122.w,
                              )
                            : CommonSkeleton.missionImg())
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),

                ///*2. controller.missionDetail.value answer
                SizedBox(
                  width: 260.h,
                  height: 100.h,
                  child: GridView.builder(
                    itemCount: controller.missionDetail.value.choices.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => GestureDetector(
                            onTap: () {
                              controller.currentChocieId.value = controller
                                  .missionDetail.value.choices[index].id;
                            },
                            child: controller.currentChocieId.value ==
                                    controller
                                        .missionDetail.value.choices[index].id
                                ? AnswerSelectChip(
                                    text: controller.missionDetail.value
                                        .choices[index].name)
                                : AnswerChip(
                                    text: controller.missionDetail.value
                                        .choices[index].name)),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 120.w / 42.h,
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.w,
                      crossAxisSpacing: 16.w,
                    ),
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => GlobalButton.missionSubmit(
                          isActive: controller.currentChocieId.value != -1,
                          onTap: () async {
                            await MissionApi.setMissionResult(
                                missionId: controller.missionId,
                                isSuccess: controller.currentChocieId.value ==
                                    controller.missionDetail.value.answer.id);
                            await Get.to(
                              MissionResultScreen(
                                  mission: controller.missionDetail.value,
                                  isSuccess: controller.currentChocieId.value ==
                                      controller.missionDetail.value.answer.id,
                                  id: controller.missionId),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
