import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/screen/login_page.dart';
import 'package:flutter_balance_game_client/screen/main_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:uni_links/uni_links.dart';

import 'controller/login_controller.dart';


/// 앱의 기본 로직 처리 App 위젯
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {

  @override
  void initState() {

    /// TODO : FCM 설정, 알림 설정에 의한 앱 실행 로직 처리

    /// 앱 시작 초기 딥링크 처리
    _handleInitialUri();

    /// 스플래시 제거
    FlutterNativeSplash.remove();

    super.initState();
  }

  /// 앱 시작 초기 딥링크 처리 -
  Future<void> _handleInitialUri() async {
    if (Get.find<LoginController>().firstEnter.value) {
      // 초기 진입 시 딥링크 flag 변경
      Get.find<LoginController>().changeDeepLinkState();

      // 딥링크 URL
      final uri = await getInitialUri();
      if (uri == null) {
        print('딥링크 없음');

        /// 로그인 O - 디테일 페이지 생성
      } else if(uri.toString().contains('boardKey=') && Get.find<LoginController>().loginState.value == LoginState.login) {
        print("딥링크 + 로그인 O");
        Get.toNamed('/detail?boardKey=${uri.queryParameters['boardKey']}');
      }else if(uri.toString().contains('boardKey=') && Get.find<LoginController>().loginState.value != LoginState.login) {
        print("딥링크 + 로그인 X");
        Get.snackbar(
          '로그인 필요',
          '로그인이 안되었거나 토큰이 만료된거 같아요!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.mainRedColor,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Get.find<LoginController>().loginState.value == LoginState.login)
        ? const MainPage()
        : const LoginPage();
  }

}
