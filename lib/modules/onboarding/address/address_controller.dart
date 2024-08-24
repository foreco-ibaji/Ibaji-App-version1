import 'package:get/get.dart';

import '../../../util/routes/routes.dart';

class AddressController extends GetxController {
//TODO: 거주 형태 Get.arguments로 받아서 처리하기

  RxString address = ''.obs;

  void goNextOnboardingStep() {
    Get.toNamed(
      Routes.main,
    );
  }
}
