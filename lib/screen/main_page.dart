import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/controller/bottom_navigator_controller.dart';
import 'package:flutter_balance_game_client/screen/tab/main_list_tap.dart';
import 'package:flutter_balance_game_client/screen/tab/main_mypage_tap.dart';
import 'package:flutter_balance_game_client/screen/tab/main_write_tap.dart';
import 'package:flutter_balance_game_client/widget/bottom_navigator_widget.dart';
import 'package:get/get.dart';

/// 메인 페이지
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  /// 메인 페이지 탭 페이지
  static List<Widget> tabPages = const <Widget>[
    MainWriteTab(),
    MainListTap(),
    MainMypageTap(),
  ];

  @override
  Widget build(BuildContext context) {

    Get.put(CustomBottomNavgationBarController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      /// 앱바
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        title: const Text('배너형 로고', style: TextStyle(color: AppColors.mainRedColor , fontSize: 30 , fontWeight: FontWeight.bold )),
        centerTitle: false,
        elevation: 0,
        actions: const [
          IconButton(
            icon : Icon(Icons.notifications , color: AppColors.mainRedColor , size: 35),
            onPressed: null,
          ),
        ],
      ),

      /// 바디
      body:
          Obx(() => SafeArea(child: tabPages[CustomBottomNavgationBarController.to.selectedIndex.value])),

      /// 바텀 네비게이션 바
      bottomNavigationBar: const CustomBottomNavgationBar(),
    );
  }
}
