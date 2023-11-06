import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/app.dart';
import 'package:get/get.dart';

part 'app_routes.dart';


/// 앱 내 페이지 경로 설정 클래스
class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial, page: () => const App(), transition: Transition.native
    ),
  ];
}