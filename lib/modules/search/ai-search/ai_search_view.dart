import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ibaji/modules/search/ai-search/views/quick_search_section.dart';
import 'package:ibaji/util/app_text_styles.dart';

import '../../../util/app_colors.dart';
import '../../../util/widget/global_appbar.dart';
import '../../../util/widget/global_text_field.dart';
import 'ai_search_controller.dart';
import 'views/chat_message_view.dart';
import 'views/quick_search_chip.dart';

class AiSearchView extends GetView<AiSearchController> {
  const AiSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar2.normal(
          title: 'AI 검색',
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Obx(
            () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  controller.isInitSearch.value
                      ? Expanded(child: aiStartView())
                      : Expanded(child: aiSearchView()),
                  GlobalSearchField.aiSearch(
                    textController: controller.textController,
                    textStatus: controller.searchStatus,
                    onSubmit: controller.onSubmitted,
                    onChange: controller.onChange,
                  ),
                  SizedBox(
                    height: 40.w,
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Widget aiStartView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 60.w,
        ),
        Text(
          '위즈 AI 검색으로\n빠르게 물어보세요',
          style: AppTextStyles.heading2Bold,
        ),
        Text(
          '어떻게 질문해도 위즈가 쓰레기 배출법을 찾아드릴게요',
          style: AppTextStyles.title3Medium.copyWith(color: AppColors.grey5),
        ),
        SizedBox(
          height: 40.w,
        ),
        Wrap(
            runSpacing: 11.w,
            spacing: 11.w,
            children: List.generate(
                AiQuickSearchType.values.length,
                (index) => QuickSearchSection(
                    keyword: AiQuickSearchType.values[index].value,
                    iconUrl: AiQuickSearchType.values[index].iconUrl))),
        const Spacer(),
        Row(
          children: [
            const QuickSearchChip(AiQuickChip.trash),
            SizedBox(
              width: 6.w,
            ),
            const QuickSearchChip(AiQuickChip.link),
          ],
        ),
        SizedBox(
          height: 16.w,
        ),
      ],
    );
  }

  Widget aiSearchView() {
    return ListView.builder(
      controller: controller.scrollController,
      itemCount: controller.chats.length,
      itemBuilder: (context, index) {
        final chat = controller.chats[index];
        if (chat.fromUser == true) {
          return Container(
              alignment: Alignment.centerRight,
              child: MessageView.mine(chat.message));
        } else {
          return Container(
              alignment: Alignment.centerLeft,
              child: MessageView.ai(chat.message));
        }
      },
    );
  }
}
