import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ibaji/model/member/member.dart';
import 'package:ibaji/provider/api/login_api.dart';
import 'package:ibaji/provider/api/util/dio_services.dart';
import 'package:ibaji/provider/api/util/global_mock_data.dart';
import 'package:ibaji/provider/storage/get_storage_util.dart';
import 'package:ibaji/util/permission_handler.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../provider/api/util/map_api.dart';
import '../../../provider/service/map_service.dart';
import '../../../util/routes/routes.dart';
import '../../../util/style/global_logger.dart';

class LoginController extends GetxController {
  ///*  카카오 로그인
  Future<void> signInWithKakao() async {
    // 카카오 설치여부 확인
    bool install = await isKakaoTalkInstalled();
    try {
      // 카카오 로그인 내부 메소드 호출
      OAuthToken token = install
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      Member tmpResult =
          await LoginApi.getMemberSignIn(token: token.accessToken) ?? tmpMember;

      GetStorageUtil.setToken(StorageKey.JWT_TOKEN, tmpResult.accessToken);
      GetStorageUtil.setToken(StorageKey.REFRESH_TOKEN, tmpResult.refreshToken);
      DioServices().setToken(tmpResult.accessToken);

      ///* 임시 라우팅
      await Get.toNamed(Routes.main);
    } catch (error) {
      logger.e(error.toString());
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();
    // 권한 요청
    PermissionHandler().initPermission();

    // //api 속도때문에 map service로 이동
    MapService.currentLatLng.value = await MapRepository.getCurrentLocation();
    MapService.currentAddress.assignAll(
        await MapRepository.getAddressFromLatLng(
            MapService.currentLatLng.value));

    // //자동 로그인
    // var token = await GetStorageUtil.getToken(StorageKey.JWT_TOKEN);
    // if (token != null) {
    //   // LoginApi.getTokenValidity(token);<-response model 알고나서 작업..
    //   Get.offAllNamed(Routes.main);
    // }
  }
}
