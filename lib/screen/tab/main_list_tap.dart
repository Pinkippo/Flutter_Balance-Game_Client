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
        /// TODO: 서버에서 데이터를 0페이지부터 가져와서 초기화
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
            return ListView.builder(
              itemCount: controller.boardList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    color: AppColors.backgroundColor,
                    width: Get.width * 0.9,
                    height: 180,
                    /// 상단부
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
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
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        /// 중단부
                        SizedBox(
                          height: 30,
                          child: Center(
                            child: Text(
                              controller.boardList[index].boardTitle,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        /// 하단부
                        Container(
                          height: 90,
                          color: Colors.red,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      controller.boardList[index].leftContent,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.green,
                                  child: Center(
                                    child: Text(
                                      controller.boardList[index].rightContent,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}