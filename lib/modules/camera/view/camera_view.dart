import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ibaji/modules/camera/view/camera_result_view.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../provider/api/photo_api.dart';
import '../../../provider/service/camera_service.dart';
import '../../../util/app_text_styles.dart';
import '../../../util/permission_handler.dart';
import '../../../util/routes/routes.dart';
import '../../../util/style/global_logger.dart';
import '../controller/camera_controller.dart';

class CameraScreen extends GetView<CameraScreenController> {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO:임시 라우팅
    Get.put(CameraScreenController());
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.h,
          backgroundColor: AppColors.black,
          centerTitle: true,
          title: Text(
            "쓰레기 촬영",
            style:
                AppTextStyles.title2SemiBold.copyWith(color: AppColors.grey1),
          ),
          leading: IconButton(
            onPressed: (() {
              Get.back();
            }),
            icon: Icon(
              Icons.close,
              size: 24.w,
              color: AppColors.white,
            ),
          ),
        ),
        body: Obx(() => Column(
              children: [
                //카메라 화면
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 510.h,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CameraPreview(
                          CameraService.to.cameraController?.value ??
                              CameraController(
                                CameraService.to.cameras[0],
                                ResolutionPreset.medium,
                                imageFormatGroup: ImageFormatGroup.jpeg,
                              ),
                        ),
                        //TODO: move center

                        cameraOverlay(
                            padding: 65.h,
                            aspectRatio: 1,
                            color: AppColors.black.withOpacity(0.5)),
                        Positioned(
                            top: 84.h,
                            left: 50.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 27.w, vertical: 7.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000.r),
                                  color: AppColors.black.withOpacity(0.3)),
                              child: Text("해당 쓰레기를 사각형안에 위치시켜주세요.",
                                  style: AppTextStyles.title3Medium.copyWith(
                                    color: AppColors.white,
                                  )),
                            )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.black),
                    padding:
                        EdgeInsets.symmetric(vertical: 39.h, horizontal: 52.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              PermissionHandler()
                                  .checkPermission(Permission.storage);
                              var imgPath = await controller.imagePick();
                              await controller.getImgResult(imgPath);
                            },
                            child: Image.asset(
                              "asset/image/icon/ic_gallery_30.png",
                              width: 30.w,
                            )),
                        GestureDetector(
                            onTap: () async {
                              var img = await CameraService.to.takePhoto();
                              await controller.getImgResult(img?.path ?? "");
                            },
                            child: Image.asset(
                              "asset/image/icon/ic_camera_press.png",
                              width: 68.w,
                            )),
                        !controller.isFlash.value
                            ? GestureDetector(
                                onTap: () async {
                                  await CameraService.to.cameraController?.value
                                      .setFlashMode(FlashMode.torch);
                                  controller.isFlash.value = true;
                                },
                                child: Image.asset(
                                  "asset/image/icon/ic_flash_unable_30.png",
                                  width: 30.w,
                                ))
                            : GestureDetector(
                                onTap: () async {
                                  await CameraService.to.cameraController?.value
                                      .setFlashMode(FlashMode.off);
                                  controller.isFlash.value = false;
                                },
                                child: Image.asset(
                                  "asset/image/icon/ic_flash_able_30.png",
                                  width: 30.w,
                                )),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}

Widget cameraOverlay(
    {required double padding,
    required double aspectRatio,
    required Color color}) {
  return LayoutBuilder(builder: (context, constraints) {
    double parentAspectRatio = constraints.maxWidth / constraints.maxHeight;
    double horizontalPadding = 50.w;
    double verticalPadding = 160.h;

    if (parentAspectRatio < aspectRatio) {
      verticalPadding = (constraints.maxHeight -
              ((constraints.maxWidth - 2 * padding) / aspectRatio)) /
          2;
    } else {
      horizontalPadding = (constraints.maxWidth -
              ((constraints.maxHeight - 2 * padding) * aspectRatio)) /
          2;
    }
    return Stack(fit: StackFit.expand, children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Container(width: horizontalPadding, color: color)),
      Align(
          alignment: Alignment.centerRight,
          child: Container(width: horizontalPadding, color: color)),
      Align(
          alignment: Alignment.topCenter,
          child: Container(
              margin: EdgeInsets.only(
                  left: horizontalPadding, right: horizontalPadding),
              height: verticalPadding,
              color: color)),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              margin: EdgeInsets.only(
                  left: horizontalPadding, right: horizontalPadding),
              height: verticalPadding,
              color: color)),
      ShaderMask(
        blendMode: BlendMode.srcOut,
        shaderCallback: ((bounds) {
          return LinearGradient(colors: [color], stops: [0.0])
              .createShader(bounds);
        }),
        //   child: ,
        // ),
        // Container(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.red,
          ),
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset("asset/image/icon/ic_camera_topLeft.svg"),
            ),
            Align(
              alignment: Alignment.topRight,
              child:
                  SvgPicture.asset("asset/image/icon/ic_camera_topRight.svg"),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                  "asset/image/icon/ic_camera_bottomRight.svg"),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child:
                  SvgPicture.asset("asset/image/icon/ic_camera_bottomLeft.svg"),
            ),
          ],
        ),
      ),
    ]);
  });
}
