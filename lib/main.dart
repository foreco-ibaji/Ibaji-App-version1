import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ibaji/modules/login/binding/login_binding.dart';
import 'package:ibaji/modules/main/binding/main_binding.dart';
import 'package:ibaji/modules/onboarding/live_type/live_type_binding.dart';
import 'package:ibaji/util/app_colors.dart';
import 'package:ibaji/util/routes/routes.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:logger/logger.dart';
import 'modules/onboarding/live_type/live_type_screen.dart';
import 'util/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = NoCheckCertificateHttpOverrides();
  await dotenv.load(fileName: ".env");
  await NaverMapSdk.instance.initialize(
      clientId: dotenv.env['NAVER_CLIENT_ID'].toString(),
      onAuthFailed: (error) {
        Logger().d('Auth failed: $error');
      });

  /// * GetStorage 초기화
  await GetStorage.init();

  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_API_KEY'].toString(),
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: ((context, child) {
        return GetMaterialApp(
          getPages: Pages.routes,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.white,
            fontFamily: 'Pretendard',
          ),
          supportedLocales: const [
            Locale('ko', 'KR'),
          ],
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          initialRoute: Routes.liveType,
          initialBinding: LiveTypeBinding(),
          smartManagement: SmartManagement.full,
          navigatorKey: Get.key,
        );
      }),
    );
  }
}

class NoCheckCertificateHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
