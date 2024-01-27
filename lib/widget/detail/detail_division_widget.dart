import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/common/share/kakao_share_manager.dart';
import 'package:flutter_balance_game_client/controller/board_detail_controller.dart';
import 'package:get/get.dart';


class DetailDivisionWidget extends GetView<BoardDetailController> {
  const DetailDivisionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: Get.width * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 카카오톡 공유하기 아이콘 버튼
          SizedBox(
            height: 60,
            width: 80,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                IconButton(
                  onPressed: () async {
                    KakaoShareManager().shareMyCode(
                      ShareModel(
                        title: controller.boardResponseModel.value.boardTitle,
                        url: "yangjataekil://detail?boardKey=${controller.boardResponseModel.value.boardKey}",
                        likeCount: controller.boardResponseModel.value.heartCount.toString(),
                        commentCount: controller.boardResponseModel.value.commentList.length.toString(),
                        boardKey: controller.boardResponseModel.value.boardKey.toString(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.share,
                    size: 34,
                    color: AppColors.mainRedColor,
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  child: Text(
                    "공유하기",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
