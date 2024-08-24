import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:ibaji/util/app_text_styles.dart';

class MessageView extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final double horizontalPadding;
  final double verticalPadding;
  final FontWeight textWeight;
  final String msg;
  final bool isMine;

  const MessageView(
      {super.key,
      required this.bgColor,
      required this.textColor,
      required this.horizontalPadding,
      required this.verticalPadding,
      required this.msg,
      required this.textWeight,
      required this.isMine});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 300.w,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
      margin: EdgeInsets.symmetric(vertical: 12.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8).copyWith(
          bottomRight: isMine ? Radius.circular(0) : Radius.circular(8),
        ),
      ),
      child: Text(
        msg,
        style: AppTextStyles.title3Medium
            .copyWith(color: textColor, fontWeight: textWeight),
      ),
    );
  }

  factory MessageView.mine(String msg) {
    return MessageView(
      bgColor: AppColors.primary6,
      textColor: AppColors.grey1,
      horizontalPadding: 16,
      verticalPadding: 12,
      msg: msg,
      textWeight: FontWeight.w600,
      isMine: true,
    );
  }

  factory MessageView.ai(String msg) {
    return MessageView(
      bgColor: AppColors.grey1,
      textColor: AppColors.grey9,
      horizontalPadding: 16,
      verticalPadding: 20,
      msg: msg,
      textWeight: FontWeight.w600,
      isMine: true,
    );
  }
}
