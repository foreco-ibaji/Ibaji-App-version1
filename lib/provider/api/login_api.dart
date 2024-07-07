import 'package:dio/dio.dart';
import 'package:ibaji/model/dashboard/dashboard.dart';
import 'package:ibaji/provider/api/util/dio_services.dart';
import 'package:ibaji/provider/api/util/global_api_field.dart';

import '../../model/member/member.dart';
import '../../util/style/global_logger.dart';
import '../service/map_service.dart';

class LoginApi {
  ///## login kakao API
  static Future<Member?> getMemberSignIn({
    required String token,
  }) async {
    try {
      logger.d("api호출 성공");
      Response response = await DioServices()
          .to()
          .get("/account/kakao/result", queryParameters: {
        "token": "Bearer ${token}",
        // "region": "서울특별시 ${MapService.currentAddress[1]} 면목동"
      });
      return Member.fromJson(response.data[DATA]);
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  ///## get Dashboard data
  static Future<Dashboard?> getDashBoard() async {
    try {
      Response response = await DioServices().to().get(
            "/mission/dashboard",
          );
      return Dashboard.fromJson(response.data[DATA]);
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  ///## [GET] jwt 유효성을 검증하는 api
  ///* 온보딩에서 저장된 토큰이 있을경우, 해당 api로 검증및 재발급을 받은 후에 메인으로 진입하고자 함
  static Future<void> getTokenValidity(String token) async {
    Response response = await DioServices()
        .to()
        .get("/jwt/valid", queryParameters: {"token": token});
    // return
  }

  ///## [GET] refreshToken으로부터 accessToken을 재발급 받는 api
  ///* dioInterceptor에서 401에러시, 해당 token으로 재발급
  ///* 만약 refresh도 만료시, 로그인 화면으로 이동해야 함
  static Future<void> getNewToken(String refreshToken) async {
    Response response = await DioServices()
        .to()
        .get("/jwt/refresh", queryParameters: {"refreshToken": refreshToken});
    // return
  }
}
