import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:get/get.dart';

import '../../controller/main_list_by_controller.dart';

class ListByTabHeader extends StatelessWidget {

  final ListByController controller;

  const ListByTabHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// 날짜순 탭
          Expanded(
            child: GestureDetector(
              onTap: () {
                ListByController.to.changeIndex(0);
              },
              child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("최신순", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.blackColor)),
                  const SizedBox(height: 5),
                  Container(
                    height: 3,
                    width: Get.width * 0.2,
                    color: controller.selectedIndex.value == 0 ? AppColors.blackColor : Colors.transparent,
                  ),
                ],
              )),
            ),
          ),
          /// 좋아요 순 탭
          Expanded(
            child: GestureDetector(
              onTap: () {
                ListByController.to.changeIndex(1);
              },
              child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("인기순", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.blackColor)),
                  const SizedBox(height: 3),
                  Container(
                    height: 5,
                    width: Get.width * 0.2,
                    color: controller.selectedIndex.value == 1 ? AppColors.blackColor : Colors.transparent,
                  ),
                ],
              )),
            ),
          ),
          /// 인기 순 탭
          Expanded(
            child: GestureDetector(
              onTap: () {
                ListByController.to.changeIndex(2);
              },
              child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("좋아요", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.blackColor)),
                  const SizedBox(height: 3),
                  Container(
                    height: 5,
                    width: Get.width * 0.2,
                    color: controller.selectedIndex.value == 2 ? AppColors.blackColor : Colors.transparent,
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
