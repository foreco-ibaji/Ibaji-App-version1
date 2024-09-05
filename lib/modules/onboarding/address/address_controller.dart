import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../../model/member/member.dart';
import '../../../provider/api/login_api.dart';
import '../../../util/routes/routes.dart';
import '../../../util/widget/global_text_field.dart';

class AddressController extends GetxController {
//TODO: 거주 형태 Get.arguments로 받아서 처리하기

  RxString address = ''.obs;
  final TextEditingController searchController = TextEditingController();
  Rx<SEARCH_STATUS> searchStatus = SEARCH_STATUS.INIT.obs;

  void goNextOnboardingStep() {
    Get.toNamed(
      Routes.main,
    );
  }

  ///*  카카오 로그인
  Future<void> signInWithKakao() async {
    // 카카오 설치여부 확인
    bool install = await isKakaoTalkInstalled();
    try {
      // 카카오 로그인 내부 메소드 호출
      OAuthToken token = install
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      var result = LoginApi.setKakaoLogin(kakaoToken: token.accessToken, type: "multiple");
      // GetStorageUtil.setToken(StorageKey.JWT_TOKEN, tmpResult.accessToken);
      // GetStorageUtil.setToken(StorageKey.REFRESH_TOKEN, tmpResult.refreshToken);
      // DioServices().setToken(tmpResult.accessToken);

      ///* 임시 라우팅
      await Get.toNamed(Routes.main);
    } catch (error) {
      // logger.e(error.toString());
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
    }
  }

  Future<void> onSearch(String text) async {}

  Future<void> onClear(String text) async {
    searchController.clear();
  }
}
