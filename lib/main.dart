import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/app.dart';
import 'package:flutter_balance_game_client/controller/login_controller.dart';
import 'package:flutter_balance_game_client/route/app_pages.dart';
import 'package:flutter_balance_game_client/theme/app_thene.dart';
import 'package:get/get.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  initService();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    initialRoute: Routes.initial,
  ));
}

/// 앱 내에서 사용할 로그인 컨트롤러 등록
void initService() {
  Get.put(LoginController() , permanent: true);
}