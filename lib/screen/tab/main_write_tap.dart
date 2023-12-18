import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/controller/write_controller.dart';
import 'package:get/get.dart';

/// 메인 글쓰기 탭
class MainWriteTab extends GetView<WriteController> {
  const MainWriteTab({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(WriteController() , permanent: true);

    /// TODO : 폼 분리 및 파일 구조 정리
    /// TODO : 글쓰기 로직 및 유효성 검사 추가
    /// TODO : 디자인 수정
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// 글쓰는 로고
          Container(
            height: Get.height * 0.2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          /// 글쓰기 입력 - 제목
          Container(
            height: Get.height * 0.1,
            padding:
                EdgeInsets.fromLTRB(Get.width * 0.05, 0, Get.width * 0.05, 0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.mainRedColor, // 연한 회색 테두리
                ),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.mainRedColor, // 연한 회색 배경색
              ),
              child: TextFormField(
                decoration: const InputDecoration(
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
                ),
                maxLines: 3,
                maxLength: 50,
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
            height: 40,
          ),

          /// 글쓰기 입력 - A 보기
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
                decoration: const InputDecoration(
                  // 중앙 정렬
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
                decoration: const InputDecoration(
                  // 중앙 정렬
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
                onPressed: () {
                  print(controller.writeTitle.text);
                  print(controller.writeLeft.text);
                  print(controller.writeRight.text);
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
