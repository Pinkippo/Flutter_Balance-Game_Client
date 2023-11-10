import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/app.dart';
import 'package:flutter_balance_game_client/binding/login_binding.dart';
import 'package:flutter_balance_game_client/screen/login_page.dart';
import 'package:flutter_balance_game_client/screen/main_page.dart';
import 'package:flutter_balance_game_client/screen/register_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';


/// 앱 내 페이지 경로 설정 클래스
class AppPages {
  static final pages = [
    /// 초기 페이지 - 로그인 확인 + 초기 설정 진행
    GetPage(
      name: Routes.initial, page: () => const App(), transition: Transition.fade
    ),
    /// 로그인 페이지
    GetPage(
      name: Routes.login, page: () => const LoginPage(), transition: Transition.fade
    ),
    /// 회원가입 페이지
    GetPage(
      name: Routes.register, page: () => const RegisterPage(), transition: Transition.fade
    ),
    /// 메인 페이지
    GetPage(
      name: Routes.main, page: () => const MainPage(), transition: Transition.fade
    )
  ];
}