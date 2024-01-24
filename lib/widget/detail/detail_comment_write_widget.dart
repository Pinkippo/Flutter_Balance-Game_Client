import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/controller/board_detail_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';

class DetailCommentWriteWidget extends GetView<BoardDetailController> {
  const DetailCommentWriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
            Get.width * 0.03,
            5,
            Get.width * 0.03,
            5,
          ),
          width: MediaQuery.of(context).size.width,
          height: 55,
          color: AppColors.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    cursorColor: Colors.white,
                    controller: controller.commentContent,
                    style: const TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold),
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: "댓글 작성...",
                      hintStyle: TextStyle(
                          color: Colors.black54, fontSize: 13),
                      border: InputBorder.none,
                    ),
                      onChanged: (text) {
                        /// 댓글 작성 글자 수 제한
                        if (text.length > 50) {
                          controller.commentContent.text = text.substring(0, 50);
                          controller.commentContent.selection = TextSelection.fromPosition(
                            const TextPosition(offset: 50),
                          );
                        }
                      },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () async {
                  await controller.writeComment(controller.boardResponseModel.value.boardKey);
                },
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: AppColors.mainRedColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
