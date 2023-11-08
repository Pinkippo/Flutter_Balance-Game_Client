import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/app.dart';
import 'package:flutter_balance_game_client/binding/login_binding.dart';
import 'package:flutter_balance_game_client/screen/login_page.dart';
import 'package:flutter_balance_game_client/screen/register_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';


/// 앱 내 페이지 경로 설정 클래스
class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial, page: () => const App(), transition: Transition.fade
    ),
    GetPage(
      name: Routes.login, page: () => const LoginPage(), transition: Transition.fade
    ),
    GetPage(
      name: Routes.register, page: () => const RegisterPage(), transition: Transition.fade
    )
  ];
}