import 'dart:io';

import 'package:ibaji/util/style/global_logger.dart';
import 'package:permission_handler/permission_handler.dart';

///## 권한 설정 관리
class PermissionHandler {
  static final PermissionHandler _instance = PermissionHandler._internal();

  factory PermissionHandler() => _instance;

  PermissionHandler._internal();

  /// 위즈에서 사용중인 권한 목록들
  var permissions = [
    Permission.location,
    Permission.camera,
    Permission.storage
  ];

  void initPermission() async {
    for (var perm in permissions) {
      requestPermission(perm);
    }
  }

  Future<bool> checkPermission(Permission permission) async {
    final status = await permission.status;
    logger.d('현재 $permission : $status');
    return Platform.isAndroid
        ? _androidPermCheck(status)
        : _iosPermCheck(status); //Platform.isIOS
  }

  /// 권한 요청 함수
  /// @param [context]: dialog를 띄워줄 context, [permission] : 요청할 권한
  Future<bool> requestPermission(Permission permission) async {
    final permissionStatus = await permission.status;
    logger.d('CURRENT $permission STATUS : $permissionStatus');
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    }
    PermissionStatus status = await permission.request();
    if (!status.isGranted) {
      // 허용이 안된 경우
      openAppSettings();
      return false;
    } else {
      return true;
    }
  }

  bool _androidPermCheck(PermissionStatus status) {
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.permanentlyDenied) {
      return false;
    }

    return true;
  }

  bool _iosPermCheck(PermissionStatus status) {
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.permanentlyDenied ||
        status == PermissionStatus.restricted) {
      return false;
    }
    return true;
  }
}
