import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/controller/write_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';

/// 글 작성 입력 폼 위젯 - WriteController 연결
class WriteForm extends GetView<WriteController> {
  const WriteForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// 글쓰기 입력 - 제목
          Container(
            height: Get.height * 0.1,
            padding: EdgeInsets.fromLTRB(Get.width * 0.05, 0, Get.width * 0.05, 0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.mainRedColor, // 연한 회색 테두리
                ),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.mainRedColor, // 연한 회색 배경색
              ),
              child: TextFormField(
                validator: (value) => controller.validateInput(value ?? ''),
                decoration: const InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  border: InputBorder.none,
                  hintText: '글의 제목과 내용을 작성해주세요!',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppColors.cardColor,
                    fontWeight: FontWeight.normal,
                  ),
                  errorStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                maxLines: 3,
                minLines: 3,
                maxLength: 40,
                controller: controller.writeTitle,
                //텍스트 색 변경
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                showCursor: false,
                cursorOpacityAnimates: false,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          /// 글쓰기 입력 - A 보기
          Container(
            height: Get.height * 0.06,
            padding: EdgeInsets.fromLTRB(Get.width * 0.05, 0, Get.width * 0.05, 0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.blackColor, // 연한 회색 테두리
                ),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.blackColor,
              ),
              child: TextFormField(
                validator: (value) => controller.validateInput(value ?? ''),
                decoration: const InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  hintText: 'A',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: AppColors.cardColor,
                    fontWeight: FontWeight.normal,
                  ),
                  border: InputBorder.none,
                ),
                maxLines: 1,
                minLines: 1,
                maxLength: 20,
                controller: controller.writeLeft,
                //텍스트 색 변경
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                showCursor: false,
                // 커서때 밑줄 제거
                cursorOpacityAnimates: false,

              ),
            ),
          ),

          // Text("vs)
          Container(
            height: Get.height * 0.05,
            padding:
            EdgeInsets.fromLTRB(Get.width * 0.05, 0, Get.width * 0.05, 0),
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                'VS',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          /// 글쓰기 입력 - B 보기
          Container(
            height: Get.height * 0.06,
            padding:
            EdgeInsets.fromLTRB(Get.width * 0.05, 0, Get.width * 0.05, 0),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.blackColor, // 연한 회색 테두리
                ),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.blackColor,
              ),
              child: TextFormField(
                validator: (value) => controller.validateInput(value ?? ''),
                decoration: const InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  hintText: 'B',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: AppColors.cardColor,
                    fontWeight: FontWeight.normal,
                  ),
                  border: InputBorder.none,
                ),
                maxLines: 1,
                minLines: 1,
                maxLength: 20,
                controller: controller.writeRight,
                //텍스트 색 변경
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                showCursor: false,
                cursorOpacityAnimates: false,
              ),
            ),
          ),

          const SizedBox(
            height: 80,
          ),
          /// 글쓰기 버튼
          Container(
            padding:
            EdgeInsets.fromLTRB(Get.width * 0.05, 0, Get.width * 0.05, 0),
            child: Container(
              width: Get.width,
              height: Get.height * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.mainPurpleColor, // 연한 회색 배경색
              ),
              child: TextButton(
                onPressed: () async {
                  if (controller.formKey.currentState?.validate() ?? false) {
                    /// TODO : 글작성 로직 연결 및 값처리 + 페이지 이동
                    Get.snackbar(
                      '글쓰기 완료',
                      '글쓰기가 완료되었습니다!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.greenAccent,
                      colorText: Colors.white,
                    );
                  }
                },
                child: const Text(
                  '양자택일 작성하기!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
