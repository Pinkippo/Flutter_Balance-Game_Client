import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/controller/list_controller.dart';
import 'package:get/get.dart';

import '../../widget/main_list_no_item_widget.dart';

/// 메인 리스트 탭
class MainListTap extends GetView<ListController> {
  const MainListTap({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(ListController(), permanent: true);

    return RefreshIndicator(
      color: AppColors.mainRedColor,
      backgroundColor: AppColors.backgroundColor,
      onRefresh: () async {
        await controller.refreshBoardList();
      },
      child: Obx(
        () {
          if (controller.boardList.isEmpty) {
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
                if (!controller.isLast.value && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  controller.addBoardList();
              }
                return false;
              },

              child: ListView.builder(
                itemCount: controller.boardList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    color: AppColors.cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.grey.withOpacity(0.5),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.boardList[index].userName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.boardList[index].boardDate,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.thumb_up_alt_outlined,
                                size: 30,
                                color: AppColors.mainPurpleColor,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        /// 중단부
                        SizedBox(
                          width: Get.width * 0.86,
                          child: Center(
                            child: Text(
                              controller.boardList[index].boardTitle,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        /// 하단부
                        SizedBox(
                            height: 90,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: AppColors.mainRedColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          controller.boardList[index].leftContent,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "VS",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: AppColors.mainRedColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          controller
                                              .boardList[index].rightContent,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
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
