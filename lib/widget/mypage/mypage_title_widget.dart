import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:get/get.dart';

/// 마이페이지 탭 구분 목차 위젯
class MyPageTitleWidget extends StatelessWidget {
  final String title;

  const MyPageTitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.94,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.mainRedColor, Colors.redAccent],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 10),
              blurRadius: 5,
              spreadRadius: 0,
            )
          ]),
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 14.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}