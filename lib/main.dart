import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/controller/login_controller.dart';
import 'package:flutter_balance_game_client/data/repository/auth_repository.dart';
import 'package:flutter_balance_game_client/route/app_pages.dart';
import 'package:flutter_balance_game_client/theme/app_thene.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// 스플래시 생성
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initService();

  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false, // 디버그 배너 제거
        theme: appThemeData, // 앱 테마
        defaultTransition: Transition.fade,
        getPages: AppPages.pages,
        initialRoute: Routes.initial, // 초기 라우트
      )
  );
}

/// 앱 내에서 사용할 로그인 컨트롤러 등록
Future<void> initService() async {
  /// 로그인 컨트롤러 영속성 설정
  Get.put(LoginController(authRepository: AuthRepository()) , permanent: true);
  /// 로그인 컨트롤러 처리를 위한 딜레이
  await Future.delayed(const Duration(seconds: 1));
}