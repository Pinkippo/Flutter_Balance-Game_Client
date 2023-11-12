import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';

/// 마이페이지 탭 구분 목차 위젯
class MyPageTitleWidget extends StatelessWidget {
  final String title;

  const MyPageTitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      color: AppColors.mainOrangeColor,
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