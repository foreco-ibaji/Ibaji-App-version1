import 'package:get/get.dart';
import 'package:ibaji/model/dashboard/dashboard.dart';
import 'package:ibaji/provider/api/login_api.dart';
import 'package:ibaji/provider/api/util/global_mock_data.dart';
import 'package:ibaji/provider/storage/get_storage_util.dart';

class MyPageController extends GetxController {
  Rx<Dashboard> mypage = tmpDashBoard.obs;

  //TODO: logout 기능을 수행할 UI가 제작전이여서 메소드만 미리 추가; 화면 추가후 해당 메소드 사용
  void logout()async{
    //내부 저장소에서 삭제
    await GetStorageUtil.removeToken(StorageKey.JWT_TOKEN);
    //interceptor에서 삭제
  }

  @override
  void onInit() async {
    super.onInit();

    mypage.value = await LoginApi.getDashBoard() ?? tmpDashBoard;
  }
}
