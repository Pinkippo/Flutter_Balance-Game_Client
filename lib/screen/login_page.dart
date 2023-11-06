import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    print("로그인 페이지 --------${controller.jwtToken.value}");

    return const Placeholder();
  }
}
