import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/widget/login_form_widget.dart';
import 'package:get/get.dart';

/// 로그인 페이지
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body : SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                /// 양자택일 로고
                Image.asset(
                  'assets/images/logo.png',
                  width: 800,
                ),
                /// 로그인 입력 폼 위젯
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
