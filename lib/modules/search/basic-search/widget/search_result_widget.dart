import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ibaji/modules/detail_method/binding/detail_method_binding.dart';
import 'package:ibaji/modules/detail_method/view/detail_method_view.dart';
import 'package:ibaji/provider/service/map_service.dart';
import 'package:ibaji/util/app_text_styles.dart';

import '../../../../model/trash/trash.dart';
import '../../../../util/app_colors.dart';


/// 검색 결과를 나타내는 위젯
class SearchResult extends StatelessWidget {
  final Trash trash;
  const SearchResult({super.key, required this.trash});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Get.to(const DetailMethodScreen(),
              binding: DetailMethodBinding(), arguments: {'id': trash.id}),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                    color: AppColors.grey1,
                    borderRadius: BorderRadius.circular(6.r)),
                child: Image.asset("asset/image/icon/ic_paper_bag.png"),
              ),
              SizedBox(
                width: 13.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${MapService.currentAddress[1]} ${MapService.currentAddress[2]} 기준",
                    style: AppTextStyles.body1Medium
                        .copyWith(color: AppColors.grey5),
                  ),
                  Text(
                    trash.name,
                    style: AppTextStyles.title2Bold,
                  ),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
