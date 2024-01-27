import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:get/get.dart';

import '../../controller/board_detail_controller.dart';

class ReportDialogWidget extends GetView<BoardDetailController> {
  const ReportDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "신고 사유를 선택해주세요",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          /// 폭력적인 표현
          Obx(
            () => GestureDetector(
              onTap: () async {
                controller.changeViolence();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 40,
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: controller.isViolence.value ? AppColors.mainRedColor : AppColors.blackColor,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          size: 20,
                          Icons.system_security_update_warning_outlined,
                          color: controller.isViolence.value ? AppColors.mainRedColor : AppColors.blackColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "폭력적인 표현",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: controller.isViolence.value ? AppColors.mainRedColor : AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// 선정적인 표현
          Obx(
            () => GestureDetector(
              onTap: () {
                controller.changeSexual();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 40,
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: controller.isSexual.value ? AppColors.mainRedColor : AppColors.blackColor,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          size: 20,
                          Icons.system_security_update_warning_outlined,
                          color: controller.isSexual.value ? AppColors.mainRedColor : AppColors.blackColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "선정적인 표현",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: controller.isSexual.value ? AppColors.mainRedColor : AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// 광고
          Obx(
            () => GestureDetector(
              onTap: () {
                controller.changeAd();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 40,
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: controller.isAd.value ? AppColors.mainRedColor : AppColors.blackColor,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          size: 20,
                          Icons.system_security_update_warning_outlined,
                          color: controller.isAd.value ? AppColors.mainRedColor : AppColors.blackColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "광고",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: controller.isAd.value ? AppColors.mainRedColor : AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),



        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            Get.back();
            await controller.reportGame();
          },
          child: const Text(
            '신고하기',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
      ],
    );
  }
}
