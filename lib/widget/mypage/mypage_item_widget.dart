import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';

/// 마이페이지 내부 아이템 위젯
class MyPageListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MyPageListItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.mainRedColor,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.blackColor,
          fontSize: 20,
        ),
      ),
      onTap: onTap,
    );
  }
}