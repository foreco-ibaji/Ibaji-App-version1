import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ibaji/model/search_detail/search_detail.dart';
import '../../../../util/app_colors.dart';
import '../../../../util/app_text_styles.dart';
import '../controller/search_controller.dart';
import '../widget/search_bar.dart';
import '../widget/search_group_widget.dart';
import '../widget/search_result_widget.dart';

class SearchScreen extends GetView<SearchViewController> {
  const SearchScreen({super.key});

  Widget _buildSearchBody() {
    if (controller.isSearch.value) {
      return _buildSearchResult();
    }
    return Column(
      children: [
        _buildLatestSearch(),
        SizedBox(
          height: 40.h,
        ),
        _buildRecommnedSearch()
      ],
    );
  }

  Widget _buildSearchResult() {
    print("isSearch = ${controller.isSearch.value}");
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return SearchResult(trash: controller.searchResults[index]);
        }),
        separatorBuilder: ((context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Divider(
              thickness: 1.h,
              color: AppColors.grey1,
            ),
          );
        }),
        itemCount: controller.searchResults.length);
  }

  Widget _buildLatestSearch() {
    return SearchGroup(
        type: SearchType.LATEST,
        lists: controller.latestSearches.toList(),
        onSubTitleClick: controller.onLatestClear,
        onItemClick: controller.onRemoveLatestItem);
  }

  Widget _buildRecommnedSearch() {
    //TODO API 적용 전 하드 코딩. 이후 수정 필요!
    return SearchGroup(
        type: SearchType.RECOMMEND,
        lists: [
          SearchDetail(text: "계란", dateTime: DateTime.now()),
          SearchDetail(text: "비닐", dateTime: DateTime.now()),
          SearchDetail(text: "자전거", dateTime: DateTime.now()),
          SearchDetail(text: "밀대걸레", dateTime: DateTime.now()),
          SearchDetail(text: "폐건전지", dateTime: DateTime.now()),
        ],
        onSubTitleClick: controller.onLatestClear,
        onItemClick: controller.onRemoveLatestItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80.h,
        backgroundColor: AppColors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: Get.back,
          color: AppColors.grey9,
        ),
        title: Text(
          "검색",
          style: AppTextStyles.title1SemiBold.copyWith(color: AppColors.grey9),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Obx(
              () => CustomSearchBar(
                options: controller.searchHints,
                focus: controller.focus.value,
                controller: controller.searchTextController.value,
                onChanged: controller.onAutoCompleteChanged,
                onSubmitted: (str) {
                  controller.onSearch();
                },
                onSelected: controller.onAutoCompleteSelected,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Obx(_buildSearchBody),
          ],
        ),
      ),
    );
  }
}
