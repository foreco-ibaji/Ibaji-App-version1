import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibaji/model/search_detail/search_detail.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:ibaji/util/app_text_styles.dart';

enum SearchType { LATEST, RECOMMEND }

/// 최근 검색어, 추천 검색어 UI가 동일한 구조이기 때문에 하나의 위젯으로 사용
class SearchGroup extends StatelessWidget {
  const SearchGroup(
      {super.key,
      required this.type,
      required this.lists,
      this.onSubTitleClick,
      this.onItemClick});

  final SearchType type;
  final List<SearchDetail> lists;
  final VoidCallback? onSubTitleClick;
  final void Function(int index)? onItemClick;

  Widget _title() {
    if (type == SearchType.LATEST) {
      return Text(
        "최근 검색어",
        style: AppTextStyles.title1Bold,
      );
    }
    return Text(
      "추천 검색어",
      style: AppTextStyles.title1Bold,
    );
  }

  Widget _subTitle() {
    if (type == SearchType.LATEST) {
      return GestureDetector(
        onTap: onSubTitleClick,
        child: Text(
          "전체 삭제",
          style: AppTextStyles.body1Medium.copyWith(color: AppColors.grey4),
        ),
      );
    }
    return const SizedBox();
  }

  Widget _searchItem(int index) {
    if (type == SearchType.LATEST) {
      return LatestSearchItem(
          index: index, label: lists[index].text, onClick: onItemClick);
    }
    return RecommendSearchItem(label: lists[index].text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _title(),
            _subTitle(),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Wrap(
          children: [
            for (int i = 0; i < lists.length; ++i)
              Padding(
                padding: EdgeInsets.only(right: 10.w, bottom: 16.h),
                child: _searchItem(i),
              )
          ],
        )
      ],
    );
  }
}

/// 최근 검색어 결과를 나타내는 요소
class LatestSearchItem extends StatelessWidget {
  const LatestSearchItem(
      {super.key, required this.index, required this.label, this.onClick});

  final int index;
  final String label;
  final void Function(int)? onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 14.w),
      decoration: BoxDecoration(
          color: AppColors.primary1,
          borderRadius: BorderRadius.circular(1000.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.title3SemiBold
                .copyWith(color: AppColors.primary6),
          ),
          GestureDetector(
            onTap: onClick != null ? () => onClick!(index) : null,
            child: SizedBox(
              width: 20.w,
              height: 20.h,
              child: const Icon(
                Icons.close,
                color: AppColors.primary4,
                size: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// 추천 검색어 결과를 나타내는 요소
class RecommendSearchItem extends StatelessWidget {
  const RecommendSearchItem({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6.h, bottom: 6.h, left: 12.w, right: 24.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000.r),
          border: Border.all(color: AppColors.primary4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "asset/image/icon/ic_search_outline.svg",
            color: AppColors.primary4,
            width: 19.w,
            height: 19.h,
          ),
          SizedBox(
            width: 6.w,
          ),
          Text(label,
              style: AppTextStyles.title3SemiBold
                  .copyWith(color: AppColors.grey8)),
        ],
      ),
    );
  }
}
