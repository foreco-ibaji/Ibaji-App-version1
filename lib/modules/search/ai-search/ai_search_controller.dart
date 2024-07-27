import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ibaji/provider/api/chat_api.dart';
import 'package:ibaji/util/widget/global_text_field.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/chat/chat.dart';
import '../../../provider/api/util/secret_key.dart';

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
  // trash('오늘의 배출 쓰레기', "Trash"),
  link('동대문 대형 폐기물 신고하러가기', 'Link');

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
  final RxList<GlobalKey> chatKeys = <GlobalKey>[].obs;
  final AutoScrollController scrollController = AutoScrollController(
    axis: Axis.vertical,
  );

  Future<void> onSubmitted(String value) async {
    isLoading.value = true;
    var chat = Chat(
      id: '1',
      message: value,
      fromUser: true,
    );
    addChat(chat);
    textController.clear();

    getChat(value);
    isLoading.value = false;
  }

  void addChat(Chat chat) {
    chatKeys.add(GlobalKey());
    chats.add(chat);
  }

  void getChat(String msg) async {
    var chat = await ChatRepository.getChat(msg);
    addChat(chat);
    moveScroll();
  }

  void moveScroll() {
    scrollController.scrollToIndex(chatKeys.length - 1);
    // var currentPos = scrollController.position.pixels;
    // if (chatKeys.lastOrNull?.currentContext != null) {
    //   Scrollable.ensureVisible(
    //     chatKeys[chatKeys.length - 1].currentContext!,
    //     duration: const Duration(milliseconds: 100),
    //     curve: Curves.easeInOut,
    //     alignment: 1.0,
    //     // alignmentPolicy: ScrollPositionAlignmentPolicy.values[1],
    //   );
    //   if (scrollController.keepScrollOffset) {
    //     scrollController.jumpTo(currentPos);
    //   }
    // }
  }

  Future<void> onChange(String value) async {
    searchStatus.value = SEARCH_STATUS.EDIT;
  }

  void onTapQuickSearch(String type) {
    textController.text = type;
    onSubmitted(type);
  }

  void onTapQuickChip(AiQuickChip type) async {
    switch (type) {
      case AiQuickChip.link:
        if (!await launchUrl(
          Uri.parse(Secrets.bigTrashReport),
          mode: LaunchMode.externalApplication,
        )) {
          throw Exception('Could not launch url');
        }
        break;
    }
    // onSubmitted(type);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // scrollController.addListener(() {
    //   if (!scrollController.position.atEdge) {
    //     scrollController.animateTo(scrollController.position.maxScrollExtent,
    //         duration: Duration(seconds: 2), curve: Curves.easeIn);
    //   }
    // });
  }
}
