import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:ibaji/modules/detail_method/view/detail_method_view.dart';
import 'package:ibaji/modules/map/view/map_view.dart';
import 'package:ibaji/modules/search/view/search_view.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:ibaji/util/app_text_styles.dart';
import 'package:ibaji/util/global_button_widget.dart';
import 'package:logger/logger.dart';

import '../../../provider/api/trash_api.dart';
import '../../../provider/routes/pages.dart';
import '../../../provider/routes/routes.dart';
import '../controller/home_controller.dart';
import '../widget/home_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h).copyWith(
              bottom: 140.h,
            ),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "asset/image/logo/logo.png",
                        width: 53.w,
                      ),
                      GestureDetector(
                        onTap: (() {
                          Get.to(() => MapScreen());
                        }),
                        child: SvgPicture.asset(
                          "asset/image/icon/ic_map_26.svg",
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  //1. 배출요일 캘린더
                  GestureDetector(
                    onTap: () {
                      //TODO: 추후에 클릭시 캘린더 페이지 이동
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 12.h),
                      decoration: BoxDecoration(
                          color: AppColors.grey1,
                          borderRadius: BorderRadius.circular(1000.r)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "asset/image/icon/ic_home_calendar_28.svg",
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          //TODO: 임시 하드코딩; calendar repo 연결
                          Text(
                            "오늘은 ${controller.trashDay.join(", ")} 버리는 날 ",
                            style: AppTextStyles.body1SemiBold,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 86.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: '동대문구 전농1동',
                                style: AppTextStyles.heading2Bold
                                    .copyWith(color: AppColors.primary7)),
                            TextSpan(
                              text: ' 주민님,\n오늘도 이바지하세요!',
                              style: AppTextStyles.heading2Bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  //2. 검색 section
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SearchScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 13.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.grey1,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "찾으시는 쓰레기가 있으신가요?",
                            style: AppTextStyles.title3Medium
                                .copyWith(color: AppColors.grey7),
                          ),
                          SvgPicture.asset("asset/image/icon/ic_search_24.svg"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: '전농1동 주민',
                            style: AppTextStyles.heading3SemiBold
                                .copyWith(color: AppColors.primary7)),
                        TextSpan(
                          text: '들이 자주 찾는 쓰레기',
                          style: AppTextStyles.heading3SemiBold,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '헷갈리는 쓰레기 배출 정보를 내가 사는 동네에 맞게 알아봐요!',
                    style: AppTextStyles.title3Medium.copyWith(
                      color: AppColors.grey5,
                      letterSpacing: -0.05,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  GridView.count(
                      childAspectRatio: 66 / 95,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      crossAxisSpacing: 24.w,
                      mainAxisSpacing: 36.h,
                      shrinkWrap: true,
                      children: List.generate(
                          controller.frequentTrashText.length,
                          (index) => GestureDetector(
                                onTap: (() {
                                  // Get.toNamed('/home/detail', arguments: {
                                  //   'trash': controller.frequentTrashText.keys
                                  //       .elementAt(index)
                                  // });
                                  // Get.to(() => DetailMethodPetScreen());
                                }),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ImageWithCircle(
                                      size: 66,
                                      imagePath: controller
                                          .frequentTrashText.values
                                          .elementAt(index),
                                      backgroundColor: AppColors.grey1,
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      controller.frequentTrashText.keys
                                          .elementAt(index),
                                      style: AppTextStyles.title3Regular
                                          .copyWith(color: AppColors.grey7),
                                    )
                                  ],
                                ),
                              ))),
                  SizedBox(
                    height: 70.h,
                  ),

                  ///분리 배출 캘린더
                  Text(
                    "전농1동 분리배출 캘린더",
                    style: AppTextStyles.heading3SemiBold,
                  ),
                  Text(
                    "요일별로 우리 동네 배출 쓰레기 정보를 알려드려요",
                    style: AppTextStyles.title3Medium
                        .copyWith(color: AppColors.grey5),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 23.h, horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: AppColors.grey9,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.trashDay.isEmpty
                            ? RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: '버릴 수 있는',
                                        style: AppTextStyles.title1SemiBold),
                                    TextSpan(
                                      text: '쓰레기 품목이 없어요',
                                      style: AppTextStyles.title1SemiBold
                                          .copyWith(color: AppColors.primary7),
                                    ),
                                  ],
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '모든 쓰레기 품목',
                                      style: AppTextStyles.title1SemiBold
                                          .copyWith(color: AppColors.primary7),
                                    ),
                                    TextSpan(
                                        text: '을 버릴 수 있어요',
                                        style: AppTextStyles.title1SemiBold),
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Divider(
                          color: AppColors.grey1,
                          thickness: 1.h,
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        //TODO: 고정값없이 컨텐츠 크기만큼 차지하도록
        height: 92.h,
        margin: EdgeInsets.symmetric(horizontal: 18.w),
        padding: EdgeInsets.symmetric(horizontal: 63.w, vertical: 15.h)
            .copyWith(bottom: 22.h),
        decoration: BoxDecoration(
            color: AppColors.grey1, borderRadius: BorderRadius.circular(36.r)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNaviItem(
              iconText: "home",
              text: "홈",
              isSelected: true,
            ),
            BottomNaviItem(
              iconText: "camera",
              text: "카메라",
              isSelected: false,
              onNavigate: () async {
                await Get.to(() => DetailMethodScreen(), arguments: {"id": 1});
              },
            ),
            BottomNaviItem(
              iconText: "mission",
              text: "미션",
              isSelected: false,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNaviItem extends StatelessWidget {
  final String text;
  final String iconText;
  final bool isSelected;
  final Future<void> Function()? onNavigate;
  const BottomNaviItem(
      {super.key,
      required this.text,
      required this.iconText,
      required this.isSelected,
      this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onNavigate,
      child: Column(children: [
        SvgPicture.asset("asset/image/icon/ic_bottom_${iconText}_32.svg"),
        Text(text,
            style: AppTextStyles.title3Bold.copyWith(
                color: isSelected ? AppColors.black : AppColors.grey3))
      ]),
    );
  }
}
