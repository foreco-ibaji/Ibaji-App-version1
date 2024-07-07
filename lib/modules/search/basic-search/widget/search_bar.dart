import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibaji/model/search_detail/search_detail.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:ibaji/util/app_text_styles.dart';

/// 서치페이지의 서치바 위젯
class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar(
      {super.key,
      required this.controller,
      required this.focus,
      required this.onChanged,
      required this.onSubmitted,
      required this.onSelected,
      required this.options});

  final TextEditingController controller;
  final FocusNode focus;
  final Iterable<SearchDetail> Function(TextEditingValue) onChanged;
  final void Function(String) onSubmitted;
  final void Function(SearchDetail) onSelected;
  final List<SearchDetail> options;

  // 텍스트 필드 UI
  Widget _fieldViewBuilder(
      BuildContext context,
      TextEditingController controller,
      FocusNode focusNode,
      Function onFieldSubmitted) {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
      controller: controller,
      focusNode: focusNode,
      decoration: BoxDecoration(
        color: AppColors.grey1,
        borderRadius: BorderRadius.circular(8.r),
      ),
      style: AppTextStyles.title3Medium.copyWith(color: AppColors.grey9),
      placeholder: "찾으시는 쓰레기가 있으신가요?",
      placeholderStyle:
          AppTextStyles.title3Medium.copyWith(color: AppColors.grey3),
      suffix: GestureDetector(
        onTap: () => onSubmitted(controller.text),
        child: Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: SvgPicture.asset("asset/image/icon/ic_search_outline.svg")),
      ),
      onSubmitted: onSubmitted,
    );
  }

  // 자동완성 UI
  Widget _optionsViewBuilder(BuildContext context,
      void Function(SearchDetail) onSelected, Iterable<SearchDetail> options) {
    TextStyle highlightStyle =
        AppTextStyles.title3SemiBold.copyWith(color: AppColors.primary6);

    return Material(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 30.h),
            itemBuilder: (context, idx) => ListTile(
              leading: SvgPicture.asset(
                "asset/image/icon/ic_search_outline.svg",
                color: AppColors.grey4,
              ),
              title: Text(
                options.elementAt(idx).text,
                style: (idx == 0) ? highlightStyle : AppTextStyles.title3Medium,
              ),
              onTap: () => onSelected(options.elementAt(idx)),
            ),
            itemCount: options.length,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<SearchDetail>(
        textEditingController: controller,
        focusNode: focus,
        onSelected: onSelected,
        fieldViewBuilder: _fieldViewBuilder,
        optionsViewBuilder: _optionsViewBuilder,
        optionsBuilder: onChanged);
  }
}
