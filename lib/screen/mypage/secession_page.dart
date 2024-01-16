import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/common/database/app_game_dao.dart';
import 'package:flutter_balance_game_client/common/database/app_like_dao.dart';
import 'package:flutter_balance_game_client/controller/login_controller.dart';
import 'package:flutter_balance_game_client/controller/secession_controller.dart';
import 'package:get/get.dart';

class SecessionPage extends GetView<SecessionController> {
  const SecessionPage({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(SecessionController());

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          leading: Row(
            children: [
              const Spacer(),
              // 뒤로가기 버튼
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                  color: AppColors.mainRedColor,
                ),
              ),
            ],
          ),
          title: const Text(
            "회원 탈퇴",
            style:TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor
            ),
          ),
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: Get.height * 0.1),
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: 30,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "양자택일을 탈퇴하시겠어요?",
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "회원 탈퇴를 진행하시려면 비밀번호를 입력해 주세요.",
                    style: TextStyle(fontSize: 14, color: Colors.red),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.fromLTRB(40, 25, 40, 0),
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: '비밀번호',
                          prefixIcon:
                          Icon(Icons.lock, color: AppColors.mainRedColor),
                        ),
                        onChanged: (text) {
                          controller.secessionUserPw.value = text;
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(Get.width * 0.1,
                        Get.height * 0.02, Get.width * 0.1, 0),
                    child: Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          surfaceTintColor: Colors.transparent,
                          elevation: 5,
                          backgroundColor: controller.secessionUserPw.value == ''
                              ? Colors.grey
                              : AppColors.mainRedColor,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0), //버튼 위아래 패딩 크기 늘리기
                        ),
                        onPressed: () async {
                          if(controller.secessionUserPw.value == ''){
                            Get.snackbar(
                              '비밀번호 입력!',
                              '비밀번호를 입력 후 다시 시도해주세요.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppColors.mainOrangeColor,
                              colorText: Colors.white,
                            );
                            return;
                          }

                          /// 바텀 시트
                          Get.bottomSheet(
                            backgroundColor: Colors.transparent,
                            enableDrag: true,
                            barrierColor: Colors.black.withOpacity(0.3),
                            elevation: 0,
                            Container(
                              height: Get.height * 0.35,
                              color: AppColors.backgroundColor,
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    'assets/images/long_logo.png',
                                    height: Get.height * 0.1,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(Get.width * 0.1,
                                        Get.height * 0.02, Get.width * 0.1, 0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        surfaceTintColor: Colors.transparent,
                                        elevation: 5,
                                        backgroundColor: AppColors.mainPurpleColor,
                                        shape: ContinuousRectangleBorder(
                                            borderRadius: BorderRadius.circular(16.0)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0), //버튼 위아래 패딩 크기 늘리기
                                      ),
                                      onPressed: () async {
                                        await controller.secession().then((value){
                                          if(value){
                                            // 메인 이동 + 로컬 디비 삭제 + 스낵바
                                            Get.offAllNamed('/login');

                                            /// TODO : UserId에 해당하는 데이터만 삭제하기
                                            GameDao().deleteAll();
                                            LikeDao().deleteAll();
                                            Get.snackbar(
                                              '회원 탈퇴 완료',
                                              '언제든지 다시 찾아오세요!',
                                              snackPosition: SnackPosition.BOTTOM,
                                              backgroundColor: AppColors.mainOrangeColor,
                                              colorText: Colors.white,
                                            );
                                          }else{
                                            // 바텀시트 닫기 + 스낵바
                                            Get.back();
                                            Get.snackbar(
                                              '회원 탈퇴 실패',
                                              '비밀번호가 일치하지 않습니다.',
                                              snackPosition: SnackPosition.BOTTOM,
                                              backgroundColor: AppColors.mainRedColor,
                                              colorText: Colors.white,
                                            );
                                          }
                                        });
                                      },
                                      child: const Center(
                                        child: Text(
                                          '정말로 탈퇴하기',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(Get.width * 0.1,
                                        Get.height * 0.02, Get.width * 0.1, 0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        surfaceTintColor: Colors.transparent,
                                        elevation: 5,
                                        backgroundColor: AppColors.mainOrangeColor,
                                        shape: ContinuousRectangleBorder(
                                            borderRadius: BorderRadius.circular(16.0)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0), //버튼 위아래 패딩 크기 늘리기
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Center(
                                        child: Text(
                                          '취소하기',
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
                            ),
                          );
                        },
                        child: const Center(
                          child: Text(
                            '탈퇴하기',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
