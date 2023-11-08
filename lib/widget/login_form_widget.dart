import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/controller/login_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

/// 로그인 입력 폼 위젯 - LoginController 연결
class LoginForm extends GetView<LoginController> {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// 회원가입 페이지 이동 글씨 버튼
          Container(
            padding: EdgeInsets.fromLTRB(
                Get.width * 0.1, 0, Get.width * 0.1, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    /// ID, PW 입력창 초기화
                    controller.updateLoginUserId('');
                    controller.updateLoginUserPw('');

                    /// 회원가입 페이지 이동
                    await Get.toNamed('/register');
                  },
                  child: const Text(
                    '회원가입 하러 가기!!',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.mainRedColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(Get.width * 0.1,
                0, Get.width * 0.1, 0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300]!, // 연한 회색 테두리
                ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200], // 연한 회색 배경색
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 15, horizontal: 10),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: null,
                  hintText: '아이디',
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.blackColor,
                  ),
                  prefixIcon:
                  Icon(Icons.person, color: AppColors.mainRedColor),
                ),
                onChanged: (text) {
                  controller.updateLoginUserId(text);
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(Get.width * 0.1,
                Get.height * 0.02, Get.width * 0.1, 0),
            child: Container(
              //height: inputFieldHeight,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300]!, // 연한 회색 테두리
                ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200], // 연한 회색 배경색
              ),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 15, horizontal: 10),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: null,
                  hintText: '비밀번호',
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.blackColor,
                  ),
                  prefixIcon:
                  Icon(Icons.lock, color: AppColors.mainRedColor),
                ),
                style: const TextStyle(
                  fontSize: 15,
                ),
                onChanged: (text) {
                  controller.updateLoginUserPw(text);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.fromLTRB(Get.width * 0.1,
                Get.height * 0.02, Get.width * 0.1, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                surfaceTintColor: Colors.transparent,
                elevation: 5,
                backgroundColor: AppColors.mainRedColor,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0), //버튼 위아래 패딩 크기 늘리기
              ),
              onPressed: () {
                /// 인디케이터 실행 -> 로그인 수행
                Get.showOverlay(
                  asyncFunction: controller.login,
                  loadingWidget: Container(
                    color: Colors.black12,
                    alignment: Alignment.center,
                    child: const SpinKitThreeBounce(
                      color: AppColors.mainRedColor,
                    ),
                  ),
                ).then((value){
                  /// 로그인 성공 - 메인 페이지 이동
                  if(value == true){
                    Get.offAllNamed('/main');
                  }
                });
              },
              child: const Center(
                child: Text(
                  '로그인',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}