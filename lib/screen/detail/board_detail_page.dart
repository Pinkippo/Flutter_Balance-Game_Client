import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/common/share/kakao_share_manager.dart';
import 'package:flutter_balance_game_client/controller/board_detail_controller.dart';
import 'package:flutter_balance_game_client/widget/detail/detail_comment_list_widget.dart';
import 'package:flutter_balance_game_client/widget/detail/detail_comment_write_widget.dart';
import 'package:flutter_balance_game_client/widget/detail/detail_division_widget.dart';
import 'package:flutter_balance_game_client/widget/detail/detail_main_widget.dart';
import 'package:flutter_balance_game_client/widget/mypage/mypage_title_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../common/util.dart';

/// 게시글 상세 페이지
class BoardDetailPage extends GetView<BoardDetailController> {
  const BoardDetailPage({
    super.key,
  });

  /// TODO : 게시글 상세 페이지 디자인
  /// TODO : 게시글 상세 페이지 기능 구현
  @override
  Widget build(BuildContext context) {
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
          title:  Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${controller.boardResponseModel.value.userName}의 밸런스 게임",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor
                  ),
                ),
                Text(
                  // 값이 '' 아닐때만 날짜 변환
                  controller.boardResponseModel.value.boardDate != ''
                      ? convertToFormattedString(controller.boardResponseModel.value.boardDate)
                      : '',
                  style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.blackColor
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
          actions: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                /// 좋아요 버튼
                IconButton(
                  onPressed: () async {
                    /// TODO : 디자인 추가
                    await controller.changeLike(controller.boardResponseModel.value.boardKey);
                  },
                  icon: Obx(
                    () => Icon(
                      /// 좋아요 여부 - 아이콘 변경
                      controller.isLike.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 30,
                      color: AppColors.mainRedColor,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  child: Obx(
                    () => Text(
                      controller.boardResponseModel.value.heartCount.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              // 게시글 상세 정보 + 댓글 리스트
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // 로딩 중 TODO: 스켈레톤 UI 적용
                      (controller.boardResponseModel.value.boardKey == 0)
                          ? SizedBox(
                              height: Get.height * 0.9,
                              child: const Center(
                                child: SpinKitThreeBounce(
                                  color: AppColors.mainRedColor,
                                ),
                              ),
                            )
                          // 로딩 완료
                          : Column(
                              children: [
                                // 게시글 상세 정보
                                const DetailMainWidget(),

                                const SizedBox(
                                  height: 30,
                                ),

                                const DetailDivisionWidget(),

                                const SizedBox(
                                  height: 10,
                                ),

                                // 댓글 리스트
                                const DetailCommentListWidget(),

                                // 댓글 더보기 버튼 -> true 일때만 출력
                                controller.isCommentMore.value == true ?
                                TextButton(
                                  onPressed: () async {
                                    controller.loadMoreComments();
                                  },
                                  child: const Center(
                                    child: Text(
                                      "댓글 더보기",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.mainRedColor,
                                      ),
                                    ),
                                  ),
                                ) : const SizedBox.shrink(),


                                // 하단 여백 100
                                const SizedBox(
                                  height: 100,
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),

              // 댓글 작성부 위젯
              const DetailCommentWriteWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
