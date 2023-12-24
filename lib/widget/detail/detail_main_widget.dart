import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/common/util.dart';
import 'package:flutter_balance_game_client/controller/board_detail_controller.dart';
import 'package:get/get.dart';

/// 게시글 상세 페이지 - 정보 위젯
class DetailMainWidget extends GetView<BoardDetailController> {
  const DetailMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            const SizedBox(
              height: 20,
            ),

            /// 게시물 제목
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: Get.width * 0.9,
              height: 100,
              color: AppColors.backgroundColor,
              child: Center(
                child: Text(
                  controller.boardResponseModel.value.boardTitle,
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            /// 게시물 왼쪽 값
            SizedBox(
              width: Get.width * 0.9,
              height: 75,
              child: ElevatedButton(
                onPressed: () {
                  /// TODO : 게시글 왼쪽 값 클릭 이벤트
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blackColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  child: Center(
                    child: Text(
                      controller.boardResponseModel.value.leftContent,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// VS
            Container(
              height: Get.height * 0.05,
              padding:
              EdgeInsets.fromLTRB(Get.width * 0.05, 0, Get.width * 0.05, 0),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'VS',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            /// 게시물 오른쪽 값
            SizedBox(
              width: Get.width * 0.9,
              height: 75,
              child: ElevatedButton(
                onPressed: () {
                  /// TODO : 게시글 오른쪽 값 클릭 이벤트
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blackColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  child: Center(
                    child: Text(
                      controller.boardResponseModel.value.rightContent,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
