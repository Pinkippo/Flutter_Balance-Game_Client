import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/controller/login_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

/// 회원가입 입력 폼 위젯
class RegisterForm extends GetView<LoginController> {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                Get.width * 0.1, Get.height * 0.02, Get.width * 0.1, 0),
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: null,
                  hintText: '아이디',
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.blackColor,
                  ),
                  prefixIcon: Icon(Icons.person, color: AppColors.mainRedColor),
                ),
                onChanged: (text) {
                  controller.updateId(text);
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                Get.width * 0.1, Get.height * 0.02, Get.width * 0.1, 0),
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: null,
                  hintText: '이메일',
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.blackColor,
                  ),
                  prefixIcon: Icon(Icons.email, color: AppColors.mainRedColor),
                ),
                onChanged: (text) {
                  controller.updateEmail(text);
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                Get.width * 0.1, Get.height * 0.02, Get.width * 0.1, 0),
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: null,
                  hintText: '이름',
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.blackColor,
                  ),
                  prefixIcon: Icon(Icons.person, color: AppColors.mainRedColor),
                ),
                onChanged: (text) {
                  controller.updateName(text);
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                Get.width * 0.1, Get.height * 0.02, Get.width * 0.1, 0),
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: null,
                  hintText: '비밀번호',
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.blackColor,
                  ),
                  prefixIcon: Icon(Icons.lock, color: AppColors.mainRedColor),
                ),
                obscureText: true,
                onChanged: (text) {
                  controller.updatePw(text);
                },
              ),
            ),
          ),
          /// 비밀번호 확인
          Container(
            padding: EdgeInsets.fromLTRB(
                Get.width * 0.1, Get.height * 0.02, Get.width * 0.1, 0),
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
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: null,
                  hintText: '비밀번호 확인',
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.blackColor,
                  ),
                  prefixIcon: Icon(Icons.lock, color: AppColors.mainRedColor),
                ),
                obscureText: true,
                onChanged: (text) {
                  controller.updatePwCheck(text);
                },
              ),
            ),
          ),
          /// 비밀번호 일치 / 불일치 표시
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(
                Get.width * 0.1, Get.height * 0.02, Get.width * 0.1, Get.height * 0.05),
            child: Obx(() {
              return controller.comparePassword()
                  ? const Text(
                      '비밀번호가 일치합니다.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: AppColors.mainPurpleColor,
                      ),
                    )
                  : const Text(
                      '비밀번호가 일치하지 않습니다.',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.mainRedColor,
                      ),
                    );
            }),
          ),
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
              onPressed: () async {
                /// 인디케이터 실행 -> 회원가입 수행
                Get.showOverlay(
                  asyncFunction: controller.register,
                  loadingWidget: Container(
                    color: Colors.black12,
                    alignment: Alignment.center,
                    child: const SpinKitThreeBounce(
                      color: AppColors.mainRedColor,
                    ),
                  ),
                ).then((value){
                  if(value == true){
                    /// 회원가입 성공 시, 입력 정보 초기화 후, 로그인 페이지 이동
                    controller.clearUserInput();
                    Get.back();
                    Get.snackbar(
                      '회원가입 완료!',
                      '양자택일 회원가입에 성공했습니다.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.mainOrangeColor,
                      colorText: Colors.white,
                    );
                  }
                });
              },
              child: const Center(
                child: Text(
                  '회원가입',
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
