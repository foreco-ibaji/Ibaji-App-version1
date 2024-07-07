import 'package:get/get.dart';

import 'ai_search_controller.dart';

class AiSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AiSearchController());
  }
}
