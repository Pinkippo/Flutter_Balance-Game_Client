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
                    child: Card(
                      elevation: 10,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      color: AppColors.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadowColor: Colors.grey.withOpacity(0.5),
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
                                  backgroundColor: AppColors.mainOrangeColor,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                          color: AppColors.blackColor
                                      ),
                                    ),
                                    Text(
                                      convertToFormattedString(controller.boardListByDate[index].boardDate),
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColors.blackColor
                                      ),
                                    ),
                                  ],
                                ),

                                const Spacer(),

                                SizedBox(
                                  height: 50,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      const Icon(
                                        Icons.favorite,
                                        color: AppColors.mainRedColor,
                                        size: 30,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Obx(
                                              () => Text(
                                            controller.boardListByDate[index].heartCount.toString(),
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
                                ),

                                const SizedBox(
                                  width: 18,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          /// 중단부
                          SizedBox(
                            width: Get.width * 0.86,
                            height: 50,
                            child: Center(
                              child: Text(
                                controller.boardListByDate[index].boardTitle,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackColor
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          /// 하단부
                          SizedBox(
                              height: 45,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Card(
                                        color: AppColors.mainOrangeColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Container()
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        "VS",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Card(
                                        color: AppColors.mainOrangeColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Container()
                                      ),
                                    ),
                                  ),
                                ],
                              )),

                          const SizedBox(
                            height: 10,
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
}
