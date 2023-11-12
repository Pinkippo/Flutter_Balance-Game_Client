import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/controller/bottom_navigator_controller.dart';
import 'package:get/get.dart';

class NoMainItemWidget extends GetView<CustomBottomNavgationBarController> {
  const NoMainItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "밸런스 게임이 없습니다! \n새로운 게임을 만들어봐요!!",
              style: TextStyle(
                fontSize: 24,
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              heroTag: "create_game",
              elevation: 10,
              backgroundColor: Colors.white,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              onPressed: () {
                controller.changeIndex(0);
              },
              child: const Icon(
                Icons.add,
                color: AppColors.mainRedColor,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
