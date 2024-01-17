import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/screen/login_page.dart';
import 'package:flutter_balance_game_client/screen/main_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
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
    _handleInitialUri();

    FlutterNativeSplash.remove();

    super.initState();
  }

  /// Handle the initial Uri - the one the app was started with
  ///
  /// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
  /// ONLY ONCE in your app's lifetime, since it is not meant to change
  /// throughout your app's life.
  ///
  /// We handle all exceptions, since it is called from initState.
  Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (Get.find<LoginController>().firstEnter.value) {

      Get.find<LoginController>().changeLoginState();

      final uri = await getInitialUri();

      if (uri == null) {
        print('no initial uri');
      } else if(uri.toString().contains('detail?boardKey=') && Get.find<LoginController>().isLogin) {
        print('got initial uri: $uri');
        Get.toNamed('/detail?boardKey=${uri.queryParameters['boardKey']}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Get.find<LoginController>().isLogin) ? const MainPage() : const LoginPage();
  }

}
