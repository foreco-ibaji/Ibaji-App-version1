import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibaji/modules/mypage/widget/mypage_button.dart';
import 'package:ibaji/util/app_text_styles.dart';
import 'package:ibaji/util/global_variables.dart';

import '../../../resources/resources.dart';

class UseInfo extends StatelessWidget {
  /// 마이페이지의 이용 안내 UI
  const UseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "이용 안내",
          style: AppTextStyles.title1Bold,
        ),
        SizedBox(
          height: 16.h,
        ),
        UseInfoButton(onPressed: () {}, iconUrl: Svgs.icMail, label: "문의하기"),
        UseInfoButton(
            onPressed: () {}, iconUrl: Svgs.icClipboard, label: "약관 및 정책"),
        UseInfoButton(onPressed: () {}, iconUrl: Svgs.icSettings, label: "설정"),
      ],
    );
  }
}
