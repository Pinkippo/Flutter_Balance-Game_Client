import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/controller/bottom_navigator_controller.dart';
import 'package:get/get.dart';

/// 바텀 네비게이션 바 위젯
class CustomBottomNavgationBar extends GetView<CustomBottomNavgationBarController> {
  const CustomBottomNavgationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Getx Obx를 사용하여 selectedIndex가 변경될 때마다 화면을 다시 그림
    return Obx(() => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeIndex,
          selectedItemColor: AppColors.mainRedColor,
          unselectedItemColor: AppColors.mainOrangeColor,
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          selectedLabelStyle: const TextStyle(fontSize: 14),
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.backgroundColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: controller.selectedIndex.value == 0
                    ? const Icon(Icons.edit_note)
                    : const Icon(Icons.edit_note_outlined),
                label: "만들기"),
            BottomNavigationBarItem(
                icon: controller.selectedIndex.value == 1
                    ? const Icon(Icons.home)
                    : const Icon(Icons.home_outlined),
                label: "메인"),
            BottomNavigationBarItem(
                icon: controller.selectedIndex.value == 2
                    ? const Icon(Icons.person)
                    : const Icon(Icons.person_outlined),
                label: "마이"),
          ],
        ));
  }
}