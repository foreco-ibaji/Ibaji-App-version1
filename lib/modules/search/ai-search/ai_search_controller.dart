import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ibaji/provider/api/chat_api.dart';
import 'package:ibaji/util/widget/global_text_field.dart';

import '../../../model/chat/chat.dart';

enum AiQuickSearchType {
  food('음식물이 묻은 비닐은 어떻게 버려야해?', "Clam"),
  tape('카세트 테이프 배출법 알려줘', 'Tape'),
  bowl('도자기는 어떻게 버려?', 'Bowl'),
  bigTrash('우리 동네 대형폐기물 수거 업체 알려줘', 'taxi');

  final String value;
  final String iconUrl;

  const AiQuickSearchType(this.value, this.iconUrl);
}

enum AiQuickChip {
  trash('오늘의 배출 쓰레기', "Trash"),
  link('동대문구청 바로가기', 'Link');

  final String value;
  final String iconUrl;

  const AiQuickChip(this.value, this.iconUrl);
}

class AiSearchController extends GetxController {
  final Rx<SEARCH_STATUS> searchStatus = SEARCH_STATUS.INIT.obs;
  final TextEditingController textController = TextEditingController();

  RxBool get isInitSearch => chats.value.isEmpty.obs;
  final RxBool isLoading = false.obs;
  final RxList<Chat> chats = <Chat>[].obs;
  final ScrollController scrollController = ScrollController();

  Future<void> onSubmitted(String value) async {
    isLoading.value = true;
    var chat = Chat(
      id: '1',
      message: value,
      fromUser: true,
    );
    chats.add(chat);
    getChat(value);
    isLoading.value = false;
  }

  void getChat(String msg) async {
    var chat = await ChatRepository.getChat(msg);
    chats.add(chat);
  }

  Future<void> onChange(String value) async {
    searchStatus.value = SEARCH_STATUS.EDIT;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    scrollController.addListener(() {
      if (!scrollController.position.atEdge) {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(seconds: 2), curve: Curves.easeIn);
      }
    });
  }
}
