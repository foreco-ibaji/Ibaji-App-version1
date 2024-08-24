import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ibaji/model/enum/level_type.dart';
import 'package:ibaji/modules/mission/controller/mission_controller.dart';
import 'package:ibaji/modules/mission/widget/mission_widget.dart';
import 'package:ibaji/provider/service/map_service.dart';
import 'package:ibaji/util/app_text_styles.dart';
import '../../../provider/api/mission_api.dart';
import '../../../resources/resources.dart';
import '../../../util/app_colors.dart';
import '../../../util/global_variables.dart';
import '../../../util/widget/global_chip.dart';

class MissionScreen extends GetView<MissionController> {
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w)
                  .copyWith(
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
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
                                backgroundImage: NetworkImage(
                                    controller.mypage.value.profileUrl),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.mypage.value.name,
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
                              style: AppTextStyles.title2Bold
                                  .copyWith(color: AppColors.grey1)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(controller.mypage.value.point.toString(),
                                    style: AppTextStyles.heading2Bold
                                        .copyWith(color: AppColors.grey1)),
                                SizedBox(
                                  width: 6.w,
                                ),
                                SvgPicture.asset(
                                  Svgs.icMissionMoney,
                                )
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
            TabBar(
              controller: controller.missionTabBar.value.controller,
              onTap: (index) async {
                controller.tabIndex.value = index;
              },
              labelColor: AppColors.grey9,
              labelStyle: AppTextStyles.title1Bold,
              unselectedLabelColor: AppColors.grey4,
              indicatorColor: AppColors.grey9,
              tabAlignment: TabAlignment.fill,
              tabs: [
                Tab(
                  text: "위즈 미션",
                ),
                Tab(text: "환경 미션"),
                Tab(text: "쇼핑하기"),
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 24.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          controller.isAll.value = true;
                          controller.wizMissions
                              .assignAll(await MissionApi.getMissionList());
                          controller.socialMissions.assignAll(
                              await MissionApi.getMissionList(kind: "ETC"));
                        },
                        child: SelectTypeChip(
                          value: "전체",
                          isSelect: controller.isAll,
                          isIcon: false,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () async {
                          controller.isAll.value = false;
                          await Get.bottomSheet(LevelSelectSheet(
                            selectLevel: controller.currentLevel ??
                                LevelStatus.MIDDLE.obs,
                          ));
                          await controller.setLevelList(
                              type: controller.tabIndex.value == 0
                                  ? "WIZ"
                                  : "ETC",
                              level:
                                  controller.currentLevel?.value.name ?? "LOW");
                        },
                        child: SelectTypeChip(
                            value:
                                "난이도 ${controller.currentLevel?.value.stateName ?? "순"}",
                            isSelect: controller.currentLevel == null
                                ? false.obs
                                : true.obs,
                            isIcon: true),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "참여가능한 미션만 보기",
                        style: AppTextStyles.title3Bold
                            .copyWith(color: AppColors.grey5),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CupertinoSwitch(
                          activeColor: AppColors.primary8,
                          dragStartBehavior: DragStartBehavior.start,
                          value: controller.isTotal.value,
                          onChanged: (value) {
                            controller.isTotal.value = value;
                          })
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: [
              controller.wizMissions.isEmpty
                  ? Text("해당 하는 미션이 없습니다")
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.wizMissions.length,
                      itemBuilder: (context, index) {
                        return MissionListTile(
                          mission: controller.wizMissions[index],
                          missionType: "WIZ",
                        );
                      }),
              controller.socialMissions.isEmpty
                  ? Text("해당 하는 미션이 없습니다")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.socialMissions.length,
                      itemBuilder: (context, index) {
                        return MissionListTile(
                          mission: controller.socialMissions[index],
                        );
                      }),
              Center(
                  child: Text(
                "준비 중 입니다",
                style: AppTextStyles.heading1Bold,
              ))
            ][controller.tabIndex.value])
          ],
        ),
      ),
    );
  }
}
