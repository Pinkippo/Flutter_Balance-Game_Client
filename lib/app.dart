import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/controller/login_controller.dart';
import 'package:flutter_balance_game_client/screen/login_page.dart';
import 'package:flutter_balance_game_client/screen/main_page.dart';
import 'package:get/get.dart';

/// 앱의 기본 로직 처리 App 위젯
class App extends GetView<LoginController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    /// 자동로그인 v1 - 2023.11.11
    return controller.isLogin ? const MainPage() : const LoginPage();
  }
}
