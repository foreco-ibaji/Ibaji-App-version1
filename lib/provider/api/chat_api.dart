import 'package:ibaji/provider/api/util/global_api_field.dart';

import '../../model/chat/chat.dart';
import 'util/dio_services.dart';

class ChatRepository {
  ///배출요일 조회
  ///* home_view
  static Future<Chat> getChat(String msg) async {
    var result = await DioServices()
        .to()
        .post("/search/ai", data: {"searchMessage": msg});

    var data = Chat.fromJson(result.data[DATA]);
    return data;
  }
}
