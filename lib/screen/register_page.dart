import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/widget/register_form_widget.dart';
import 'package:get/get.dart';

/// 회원가입 페이지
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 회원가입 입력 폼 위젯
              RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
