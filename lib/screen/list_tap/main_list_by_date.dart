import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/util.dart';
import 'package:flutter_balance_game_client/controller/board_detail_controller.dart';
import 'package:get/get.dart';

import '../../common/app_colors.dart';
import '../../controller/list_controller.dart';
import '../../widget/main_list_no_item_widget.dart';

/// 메인 리스트 탭 - 날짜별
class ListByDate extends GetView<ListController> {
  const ListByDate({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.mainRedColor,
      backgroundColor: AppColors.backgroundColor,
      onRefresh: () async {
        await controller.refreshBoardList(0);
      },
      child: Obx(
        () {
          if (controller.boardListByDate.isEmpty) {
            /// 게시물이 없는 경우
            return ListView(
              children: [
                SizedBox(
                  height: Get.height * 0.3,
                ),
                const NoMainItemWidget(),
              ],
            );
          } else {
            /// 게시물이 있는 경우
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!controller.isLastByDate.value && scrollInfo.metrics.extentAfter <= 250 && !controller.isLoading.value) {
                  controller.addBoardList(0);
                }
                return false;
              },
              child: ListView.builder(
                itemCount: controller.boardListByDate.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await Get.toNamed('/detail?boardKey=${controller.boardListByDate[index].boardKey}');
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [AppColors.mainRedColor, Colors.redAccent],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(0, 10),
                              blurRadius: 5,
                              spreadRadius: 0,
                            )
                          ]),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: Get.width,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.mainRedColor,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.boardListByDate[index].userName,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      convertToFormattedString(controller
                                          .boardListByDate[index].boardDate),
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          /// 중단부
                          SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(
                                controller
                                    .boardListByDate[index].boardTitle,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Container(
                            color: Colors.white.withOpacity(0.65),
                            height: 75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                /// TODO : 게시물 정보 데이터 연결하기
                                _buildCountColumn('조회수 👀', 10),
                                _buildCountColumn('댓글 💬', 20),
                                _buildCountColumn('좋아요 ❤️', controller
                                    .boardListByDate[index].heartCount),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  /// 게시물 정보 보여주는 위젯
  Widget _buildCountColumn(String label, int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
