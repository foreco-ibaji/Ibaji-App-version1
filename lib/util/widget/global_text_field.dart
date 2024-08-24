import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ibaji/resources/resources.dart';

import '../app_colors.dart';
import '../app_text_styles.dart';
import '../global_variables.dart';

enum SEARCH_STATUS {
  //진행중
  INIT,
  //시작 전
  EDIT,
  //마감
  SEARCH
}

/// <h2>CupertinoTextField를 이용한 TextField</h2>
///* [SearchScreen], [DonationSearchScreen], [ProjectScreen] (댓글)에서 사용
/// @param textController: 텍스트 컨트롤러
class GlobalSearchField extends StatelessWidget {
  final TextEditingController textController;
  final String placeHolder;
  final bool isSearchScreen;
  final Rx<SEARCH_STATUS> textStatus;
  final bool hasPrefix;
  final bool alwaysSuffix;
  final Future<void> Function(String) onSubmitted;
  final Future<void> Function(String) onChanged;
  final Future<void> Function(String)? suffixOnTap;
  final bool isPlain;
  final String suffixActiveIcon;
  final String suffixUnActiveIcon;

  const GlobalSearchField({
    super.key,
    required this.textController,
    required this.placeHolder,
    this.isSearchScreen = true,
    required this.textStatus,
    this.hasPrefix = true,
    this.alwaysSuffix = false,
    required this.onSubmitted,
    required this.onChanged,
    required this.suffixOnTap,
    this.isPlain = false,
    this.suffixActiveIcon = "search_cancel_22",
    this.suffixUnActiveIcon = "search_cancel_22",
  });

  @override
  Widget build(BuildContext context) {
    return //1. 뒤로가기 아이콘 + 검색 필드
        Row(
      children: [
        isSearchScreen
            ? Container(
                margin: EdgeInsets.only(right: 14.w),
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(
                      Svgs.icArrowLeft14,
                      width: 24.w,
                    )),
              )
            : const SizedBox.shrink(),
        Expanded(
          child: CupertinoTextField(
            controller: textController,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: isPlain ? AppColors.white : AppColors.grey1,
              borderRadius: BorderRadius.circular(8.r),
              border: isPlain
                  ? (textController.text.isNotEmpty &&
                          textController.value.text != null)
                      ? Border.all(color: AppColors.grey8)
                      : Border.all(color: AppColors.grey1)
                  : null,
            ),
            keyboardType: TextInputType.text,
            cursorColor: AppColors.black,
            cursorHeight: 18.h,
            style: AppTextStyles.title3Medium,
            placeholder: placeHolder,
            placeholderStyle: AppTextStyles.title3Medium
                .copyWith(color: AppColors.grey4, height: 1.5),
            prefixMode: OverlayVisibilityMode.notEditing,
            prefix: hasPrefix
                ? Padding(
                    padding: EdgeInsets.only(left: 14.w),
                    child: SvgPicture.asset(
                      Svgs.icSearch24,
                    ),
                  )
                : null,
            // clearButtonMode: OverlayVisibilityMode.editing,
            suffixMode: !alwaysSuffix
                ? OverlayVisibilityMode.editing
                : OverlayVisibilityMode.always,
            suffix: GestureDetector(
              onTap: () async {
                if (suffixOnTap != null) {
                  await suffixOnTap!(textController.text);
                } else {
                  textController.clear();
                  textStatus.value = SEARCH_STATUS.INIT;
                }
              },
              child: Obx(
                () => Padding(
                    padding: EdgeInsets.only(right: 14.w),
                    child: SvgPicture.asset(suffixActiveIcon,
                        color: textStatus.value == SEARCH_STATUS.INIT
                            ? AppColors.grey1
                            : AppColors.primary6)),
              ),
            ),
            //자동 키보드 활성화
            autofocus: isSearchScreen ? true : false,
            onSubmitted: ((value) async {
              textStatus.value = SEARCH_STATUS.SEARCH;
              await onSubmitted(value);
            }),
            onChanged: ((value) async {
              if (value.isEmpty) {
                textStatus.value = SEARCH_STATUS.INIT;
              } else {
                textStatus.value = SEARCH_STATUS.EDIT;
              }
              await onChanged(value);
            }),
          ),
        )
      ],
    );
  }

  factory GlobalSearchField.aiSearch({
    required TextEditingController textController,
    required Rx<SEARCH_STATUS> textStatus,
    required Future<void> Function(String) onSubmit,
    required Future<void> Function(String) onChange,
  }) {
    return GlobalSearchField(
      isSearchScreen: false,
      textController: textController,
      placeHolder: "헷갈리는 쓰레기 배출법을 질문해보세요",
      alwaysSuffix: true,
      hasPrefix: false,
      suffixActiveIcon: Svgs.send,
      onSubmitted: onSubmit,
      onChanged: onChange,
      textStatus: textStatus,
      suffixOnTap: onSubmit,
    );
  }
}
