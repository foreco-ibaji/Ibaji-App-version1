import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ibaji/modules/detail_method/binding/detail_method_binding.dart';
import 'package:ibaji/modules/login/binding/login_binding.dart';
import 'package:ibaji/modules/login/view/login_view.dart';
import 'package:ibaji/modules/main/binding/main_binding.dart';
import 'package:ibaji/modules/main/view/main_view.dart';
import 'package:ibaji/modules/mission/binding/mission_binding.dart';
import 'package:ibaji/modules/mission/view/mission_view.dart';
import 'package:ibaji/modules/mission_detail/binding/mission_detail_binding.dart';
import 'package:ibaji/modules/mission_detail/view/mission_detail_view.dart';
import 'package:ibaji/modules/mypage/binding/my_page_binding.dart';
import 'package:ibaji/modules/mypage/view/my_page_view.dart';
import 'package:ibaji/modules/search/ai-search/ai_search_binding.dart';
import 'package:ibaji/modules/search/ai-search/ai_search_view.dart';
import 'package:ibaji/util/routes/routes.dart';
import '../../modules/detail_method/view/detail_method_view.dart';
import '../../modules/camera/binding/camera_binding.dart';
import '../../modules/camera/view/camera_view.dart';
import '../../modules/home/binding/home_binding.dart';
import '../../modules/home/view/home_view.dart';
import '../../modules/map/binding/map_binding.dart';
import '../../modules/map/view/map_view.dart';

class Pages {
  static final routes = [
    GetPage(
      title: "로그인 화면",
      name: Routes.login,
      page: () => const LoginScreen(),
      transition: Transition.noTransition,
      binding: LoginBinding(),
      curve: Curves.easeIn,
      popGesture: false,
    ),
    GetPage(
      title: "메인 화면",
      name: Routes.main,
      page: () => const MainScreen(),
      transition: Transition.noTransition,
      binding: MainBinding(),
      curve: Curves.easeIn,
      popGesture: false,
    ),
    GetPage(
      title: "검색 화면",
      name: Routes.aiSearch,
      page: () => const AiSearchView(),
      transition: Transition.noTransition,
      binding: AiSearchBinding(),
      curve: Curves.easeIn,
      popGesture: false,
    ),
    GetPage(
      title: "홈 화면",
      name: Routes.home,
      page: () => const HomeScreen(),
      transition: Transition.noTransition,
      binding: HomeBinding(),
      curve: Curves.easeIn,
      popGesture: false,
    ),
    GetPage(
      title: "세부 품목 화면",
      name: Routes.detail,
      page: () => const DetailMethodScreen(),
      transition: Transition.native,
      binding: DetailMethodBinding(),
      curve: Curves.easeIn,
      popGesture: false,
      children: [],
    ),
    GetPage(
      title: "카메라 화면",
      name: Routes.camera,
      page: () => const CameraScreen(),
      transition: Transition.noTransition,
      binding: CameraBinding(),
      curve: Curves.easeIn,
      popGesture: false,
    ),
    GetPage(
      title: "지도 화면",
      name: Routes.map,
      page: () => const MapScreen(),
      transition: Transition.noTransition,
      binding: MapBinding(),
      curve: Curves.easeIn,
      popGesture: false,
    ),
    GetPage(
      title: "미션 화면",
      name: Routes.mission,
      page: () => const MissionScreen(),
      transition: Transition.noTransition,
      binding: MissionBinding(),
      curve: Curves.easeIn,
      popGesture: false,
    ),
    GetPage(
      title: "미션 상세 화면",
      name: Routes.missionDetail,
      page: () => const MissionDetailScreen(),
      transition: Transition.noTransition,
      binding: MissionDetailBinding(),
      curve: Curves.easeIn,
      popGesture: false,
    ),
    GetPage(
      title: "마이 페이지 화면",
      name: Routes.mypage,
      page: () => const MyPageScreen(),
      binding: MyPageBinding(),
      curve: Curves.easeIn,
      popGesture: false,
    )
  ];
}
