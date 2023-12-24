import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/common/util.dart';
import 'package:get/get.dart';
import 'package:flutter_balance_game_client/controller/board_detail_controller.dart';

/// 게시글 상세 페이지 - 댓글 리스트 위젯
class DetailCommentListWidget extends GetView<BoardDetailController> {
  const DetailCommentListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 카드 형태로 댓글 리스트 출력
    return Obx(
      () => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.boardResponseModel.value.commentList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.fromLTRB(
              Get.width * 0.05,
              10,
              Get.width * 0.05,
              0,
            ),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.mainPurpleColor.withAlpha(150),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 댓글 작성자 정보
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "익명",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      convertToFormattedString(controller.boardResponseModel
                          .value.commentList[index].commentTime),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                /// 댓글 내용
                Text(
                  controller.boardResponseModel.value.commentList[index]
                      .commentContent,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
