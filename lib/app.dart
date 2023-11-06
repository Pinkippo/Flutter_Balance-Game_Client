import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/screen/login_page.dart';

/// 앱의 기본 로직 처리 App 위젯
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // 로그인 페이지 이동
      body: LoginPage(),
    );
  }
}
