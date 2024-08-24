abstract class Routes {
  Routes._();

  /// 스플래시 화면(onboarding)
  static const login = _Paths.login;

  /// 메인 화면
  static const main = _Paths.main;

  /// 홈 화면
  static const home = _Paths.home;

  /// 재활용방법
  static const detail = _Paths.detail;

  /// 동기부여화면
  static const recycleMotivation = _Paths.recycleMotivation;

  /// 카메라
  static const camera = _Paths.camera;

  /// 지도
  static const map = _Paths.map;
  static const aiSearch = _Paths.aiSearch;

  /// 미션 화면
  static const mission = _Paths.mission;

  /// 미션 상세화면
  static const missionDetail = _Paths.missionDetail;

  /// 마이페이지
  static const mypage = _Paths.mypage;
}

abstract class _Paths {
  _Paths._();

  /// 로그인 화면
  static const login = "/login";

  /// 홈 화면
  static const main = "/main";

  /// 홈 화면
  static const home = "/home";

  /// 재활용방법
  static const detail = "/detail";

  /// 동기부여화면
  static const recycleMotivation = "/motivation";

  /// 카메라
  static const camera = "/camera";

  /// 지도
  static const map = "/map";

  /// 미션 화면
  static const mission = "/mission";

  /// 미션 상세화면
  static const missionDetail = "/mission_detail";

  /// 마이페이지
  static const mypage = "/mypage";
  static const aiSearch = "/ai_search";
}
