import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibaji/model/search_detail/search_detail.dart';
import 'package:ibaji/provider/api/home_api.dart';
import 'package:ibaji/provider/storage/get_storage_util.dart';
import 'package:ibaji/util/style/global_logger.dart';

import '../../../../model/trash/trash.dart';


class SearchViewController extends GetxController {
  Rx<TextEditingController> searchTextController = TextEditingController().obs;
  RxBool isSearch = false.obs;
  List<String> itemList = ['음식물이 묻은 쓰레기'];
  RxList<Trash> searchResults = <Trash>[
    const Trash(
        id: 10,
        name: "TV",
        iconUrl:
            "https://postfiles.pstatic.net/MjAyMzAzMDlfMTU1/MDAxNjc4MzQ0OTk4MTMx.bsYYQx3KsbEmFEKxhmXXvH1Vk-dyLjn2-ECxIaKyJdMg.j_V4Zxtoi8ZDVfmORtO7pzshskoycWx3TFwf9zCeeAkg.JPEG.mha0715/IMG%EF%BC%BF20230309%EF%BC%BF122138%EF%BC%BF513.jpg?type=w966"),
    const Trash(
        id: 10,
        name: "TV",
        iconUrl:
            "https://postfiles.pstatic.net/MjAyMzAzMDlfMTU1/MDAxNjc4MzQ0OTk4MTMx.bsYYQx3KsbEmFEKxhmXXvH1Vk-dyLjn2-ECxIaKyJdMg.j_V4Zxtoi8ZDVfmORtO7pzshskoycWx3TFwf9zCeeAkg.JPEG.mha0715/IMG%EF%BC%BF20230309%EF%BC%BF122138%EF%BC%BF513.jpg?type=w966")
  ].obs;
  RxList<SearchDetail> latestSearches = <SearchDetail>[].obs;
  RxList<SearchDetail> searchHints = <SearchDetail>[].obs;
  Rx<FocusNode> focus = FocusNode().obs;

  Future<void> _getSearchResult(String keyword) async {
    var tmpList = await HomeRepository.getSearch(keyword);

    searchResults.assignAll(tmpList);
  }

  void onLatestClear() {
    logger.d("onLatestClear Called");
    latestSearches.clear();
    GetStorageUtil.delAllLatestSearches();
  }

  void onSearch() {
    logger.d("onSearch Called");

    final String searchText = searchTextController.value.text;
    _getSearchResult(searchText);
    latestSearches.value = _changeLatestSearch(searchText).obs;
    GetStorageUtil.setLatestSearches(latestSearches);
    focus.value.unfocus();
  }

  List<SearchDetail> _changeLatestSearch(String text) {
    List<SearchDetail> current = List.from(latestSearches);
    bool isSearchedBefore = current.any((element) => element.text == text);

    if (isSearchedBefore) {
      int target = current.indexWhere((element) => element.text == text);

      current[target] =
          SearchDetail(text: current[target].text, dateTime: DateTime.now());
    } else {
      current.add(SearchDetail(text: text, dateTime: DateTime.now()));
    }

    current.sort((e1, e2) => -e1.dateTime.compareTo(e2.dateTime));
    return current.toList();
  }

  void onRemoveLatestItem(int index) {
    logger.d("onRemove($index) Called");
    List<SearchDetail> current = latestSearches;

    current.removeAt(index);

    latestSearches.value = current.obs;
    GetStorageUtil.setLatestSearches(current);
  }

  //TODO 검색어 자동완성 하드코딩
  List<SearchDetail> onAutoCompleteChanged(TextEditingValue value) {
    if (value.text.isEmpty) {
      return List.empty();
    }

    return <SearchDetail>[
      SearchDetail(text: "음식물", dateTime: DateTime.now()),
      SearchDetail(text: "비닐", dateTime: DateTime.now()),
      SearchDetail(text: "비닐포장재", dateTime: DateTime.now()),
      SearchDetail(text: "비닐랩", dateTime: DateTime.now())
    ];
  }

  void onAutoCompleteSelected(SearchDetail detail) {
    searchTextController.value.text = detail.text;
  }

  @override
  void onInit() async {
    super.onInit();
    latestSearches.value = await GetStorageUtil.getLatestSearches();
  }

  @override
  void onClose() {
    searchTextController.value.dispose();
  }
}
