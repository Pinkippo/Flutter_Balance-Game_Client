import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';

/// 마이페이지 탭 상단 위젯
class MyPageHeader extends StatelessWidget {
  const MyPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.account_circle,
            size: 60,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "마이페이지",
              style: TextStyle(
                fontSize: 24,
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '설정과 개인정보 변경을 해보자!',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
