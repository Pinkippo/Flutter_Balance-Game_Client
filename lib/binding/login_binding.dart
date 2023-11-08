import 'package:flutter_balance_game_client/controller/login_controller.dart';
import 'package:flutter_balance_game_client/data/provider/api.dart';
import 'package:flutter_balance_game_client/data/repository/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

/// 로그인 페이지의 컨트롤러 바인딩 클래스
class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() {
      return LoginController(
          authRepository:
          AuthRepository());
    });
  }
}