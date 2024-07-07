import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:ibaji/modules/camera/controller/camera_controller.dart';
import 'package:ibaji/util/permission_handler.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService extends GetxService {
  static CameraService get to => Get.find();
  static RxString imgPath = "".obs;
  List<CameraDescription> cameras = <CameraDescription>[].obs;
  Rx<CameraController>? cameraController;
  Rx<bool> _isImageStreaming = false.obs;

  static void setImagePath(String tmpImgPath) {
    imgPath.value = tmpImgPath;
  }

  Future<void> initCamera() async {
    // if (await PermissionHandler().checkPermission(Permission.camera)) {
    //TODO: 실제 기기로 테스트후, permission 관련 추가
      cameras = await availableCameras();

      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.jpeg,
      ).obs;
      await cameraController?.value.initialize();
    // } else {
    //   PermissionHandler().requestPermission(Permission.camera);
    // }
  }

  Future<XFile?> takePhoto() async {
    final path = 'path/to/save/image.jpg';

    try {
      final XFile imageFile =
          await cameraController?.value.takePicture() ?? XFile(path);
      // 사진 촬영이 완료되면 해당 경로에 이미지가 저장됩니다.
      CameraScreenController.to.imagePath.value = imageFile.path ?? "";
      Logger().d('사진이 저장되었습니다 ${imageFile.path}');
      return imageFile;
    } catch (e) {
      print('사진 촬영 중 오류 발생: $e');
    }
  }

  Future<void> stopImageStream() async {
    if (_isImageStreaming.value) {
      await cameraController?.value.stopImageStream();
      _isImageStreaming.value = false; // 이미지 스트림이 멈춤을 표시
    }
  }
}
