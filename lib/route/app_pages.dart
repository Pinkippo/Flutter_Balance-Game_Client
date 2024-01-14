import 'package:flutter_balance_game_client/app.dart';
import 'package:flutter_balance_game_client/screen/detail/board_detail_page.dart';
import 'package:flutter_balance_game_client/screen/login_page.dart';
import 'package:flutter_balance_game_client/screen/main_page.dart';
import 'package:flutter_balance_game_client/screen/mypage/secession_page.dart';
import 'package:flutter_balance_game_client/screen/register_page.dart';
import 'package:get/get.dart';

import '../binding/board_detail_binding.dart';

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
    ),
    /// 게시글 상세 페이지
    GetPage(
      name: Routes.detail, page: () => const BoardDetailPage(), transition: Transition.fade,
        parameters: const {'boardKey': ''}, binding: BoardDetailBinding()
    ),
    /// 회원탈퇴 페이지
    GetPage(
      name: Routes.secession, page: () => const SecessionPage(), transition: Transition.fade
    ),
  ];
}