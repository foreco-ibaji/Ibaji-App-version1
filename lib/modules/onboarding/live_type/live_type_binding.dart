import 'package:get/get.dart';

import 'live_type_controller.dart';


class LiveTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LiveTypeController());
  }
}
