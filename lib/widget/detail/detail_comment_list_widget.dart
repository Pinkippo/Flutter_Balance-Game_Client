import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/common/util.dart';
import 'package:flutter_balance_game_client/data/model/comment_response_model.dart';
import 'package:get/get.dart';
import 'package:flutter_balance_game_client/controller/board_detail_controller.dart';

import '../report/report_dialog_widget.dart';

/// 게시글 상세 페이지 - 댓글 리스트 위젯
class DetailCommentListWidget extends GetView<BoardDetailController> {
  const DetailCommentListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 카드 형태로 댓글 리스트 출력
    return Obx(
      () {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          // 기본 5개 출력
          itemCount: controller.boardResponseModel.value.commentList.length > controller.commentCount.value
              ? controller.commentCount.value
              : controller.boardResponseModel.value.commentList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.fromLTRB(
                Get.width * 0.05,
                10,
                Get.width * 0.05,
                0,
              ),
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "익명의 사용자",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          convertToFormattedString(controller.boardResponseModel.value.commentList[index].commentTime),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white,),
                            iconSize: 20,
                            onPressed: () async {
                              await controller.deleteComment(index);
                            },
                        ),
                        // 신고하기
                        IconButton(
                          icon: const Icon(Icons.report_problem_outlined, color: Colors.white,),
                          iconSize: 20,
                          onPressed: () async {
                            Get.dialog(
                              ReportDialogWidget(commentKey: controller.boardResponseModel.value.commentList[index].commentKey),
                            );
                          },
                          splashColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  /// 댓글 내용
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text(
                      controller.boardResponseModel.value.commentList[index].commentContent,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
