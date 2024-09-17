import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibaji/util/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();
  static const _defaultTextColor = AppColors.grey9;
  static const _defaultFontFamily = 'Pretendard';
  static const _defaultLetterSpacing = -0.5;
  static const _heading1Height = 45.0 / 30.0;
  static const _heading2Height = 36.0 / 24.0;
  static const _heading3Height = 30.0 / 20.0;
  static const _title1Height = 28.0 / 18.0;
  static const _title2Height = 24.0 / 16.0;
  static const _title3Height = 22.0 / 14.0;
  static const _body1Height = 20.0 / 13.0;
  static const _body2Height = 18.0 / 12.0;

  static var heading1Bold = TextStyle(
    color: _defaultTextColor,
    fontFamily: _defaultFontFamily,
    fontSize: 30.sp,
    fontWeight: FontWeight.w700,
    height: _heading1Height,
  );

  static var heading2Bold = TextStyle(
    color: _defaultTextColor,
    fontFamily: _defaultFontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: _heading2Height,
    letterSpacing: _defaultLetterSpacing,
  );

  static var heading3Bold = TextStyle(
    color: _defaultTextColor,
    fontFamily: _defaultFontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    height: _heading3Height,
  );
  static var heading3SemiBold =
      heading3Bold.copyWith(fontWeight: FontWeight.w600);

  static var title1Bold = TextStyle(
    color: _defaultTextColor,
    fontFamily: _defaultFontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    height: _title1Height,
    letterSpacing: _defaultLetterSpacing,
  );
  static var title1SemiBold = title1Bold.copyWith(fontWeight: FontWeight.w600);
  static var title1Medium = title1Bold.copyWith(fontWeight: FontWeight.w500);
  static var title1Regular = title1Bold.copyWith(fontWeight: FontWeight.w400);
  static var title2Bold = TextStyle(
    color: _defaultTextColor,
    fontFamily: _defaultFontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    height: _title2Height,
    letterSpacing: _defaultLetterSpacing,

  );
  static var title2SemiBold = title2Bold.copyWith(fontWeight: FontWeight.w600);
  static var title2Medium = title2Bold.copyWith(fontWeight: FontWeight.w500);
  static var title2Regular = title2Bold.copyWith(fontWeight: FontWeight.w400);

  static var title3Bold = TextStyle(
    color: _defaultTextColor,
    fontFamily: _defaultFontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    height: _title3Height,
    letterSpacing: _defaultLetterSpacing,

  );
  static var title3SemiBold = title3Bold.copyWith(fontWeight: FontWeight.w600);
  static var title3Medium = title3Bold.copyWith(fontWeight: FontWeight.w500);
  static var title3Regular = title3Bold.copyWith(fontWeight: FontWeight.w400);

  static var body1Bold = TextStyle(
    color: _defaultTextColor,
    fontFamily: _defaultFontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    height: _body1Height,
  );
  static var body1SemiBold = body1Bold.copyWith(fontWeight: FontWeight.w600);
  static var body1Medium = body1Bold.copyWith(fontWeight: FontWeight.w500);
  static var body1Regular = body1Bold.copyWith(fontWeight: FontWeight.w400);

  static var body2Bold = TextStyle(
    color: _defaultTextColor,
    fontFamily: _defaultFontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    height: _body2Height,
  );
  static var body2SemiBold = body2Bold.copyWith(fontWeight: FontWeight.w600);
  static var body2Medium = body2Bold.copyWith(fontWeight: FontWeight.w500);
  static var body2Regular = body2Bold.copyWith(fontWeight: FontWeight.w400);
}
