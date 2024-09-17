import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ibaji/modules/map/view/map_view.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:ibaji/util/app_text_styles.dart';
import '../../../provider/service/map_service.dart';
import '../../../resources/resources.dart';
import '../../../util/global_variables.dart';
import '../../../util/routes/routes.dart';
import '../../search/basic-search/binding/search_binding.dart';
import '../../search/basic-search/view/search_view.dart';
import '../controller/home_controller.dart';

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
                          Get.to(() => const MapScreen());
                        }),
                        child: SvgPicture.asset(
                          "asset/image/icon/ic_map_24.svg",
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
                          //TODO: 데이터가 없을때 예외처리
                          Expanded(
                            child: Text(
                              controller.trashDay.isEmpty
                                  ? "오늘은 버릴 수 있는 쓰레기가 없어요"
                                  : "오늘은 ${controller.trashDay.join(", ")} ",
                              style: AppTextStyles.body1SemiBold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          controller.trashDay.isNotEmpty
                              ? Text(
                                  '버리는 날',
                                  style: AppTextStyles.body1SemiBold,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  //*2. 위치 정보 section
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text:
                                '${MapService.currentAddress[1]} ${MapService.currentAddress[2]} 주민',
                            style: AppTextStyles.heading2Bold
                                .copyWith(color: AppColors.primary7)),
                        TextSpan(
                          text: '님,\n어떤 쓰레기를 찾으시나요?',
                          style: AppTextStyles.heading2Bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "asset/image/icon/ic_location_24.svg",
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(MapService.currentAddress.join(' '),
                          style: AppTextStyles.title3Medium),
                    ],
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  //*3. 검색 section
                  GestureDetector(
                    onTap: () {
                      Get.to(const SearchScreen(),
                          binding: SearchPageBinding());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 23.h, horizontal: 23.w),
                      decoration: BoxDecoration(
                        color: AppColors.grey1,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "궁금한 쓰레기 검색!",
                            style: AppTextStyles.title2Medium
                                .copyWith(color: AppColors.grey3),
                          ),
                          SvgPicture.asset("asset/image/icon/ic_search_24.svg"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.aiSearch);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 23.w, horizontal: 16.w),
                      decoration: BoxDecoration(
                          color: AppColors.cF8F9F9,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("위즈 AI",
                                  style: AppTextStyles.title2Bold
                                      .copyWith(color: AppColors.grey9)),
                              Text(
                                "알기 어려운 특수 쓰레기 배출법을 빠르게",
                                style: AppTextStyles.title3SemiBold.copyWith(
                                  color: AppColors.grey7,
                                ),
                              )
                            ],
                          ),
                          SvgPicture.asset(Svgs.search),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
