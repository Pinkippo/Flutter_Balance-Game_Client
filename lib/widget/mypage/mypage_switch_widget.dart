import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/widget/os_switch_widget.dart';

/// 마이페이지 스위치 위젯
class MyPageSwitchmenu extends StatelessWidget {
  final String title;
  final bool isOn;
  final ValueChanged<bool> onChanged;

  const MyPageSwitchmenu(this.title, this.isOn, {super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: ListTile(
        leading: const Icon(
          Icons.notifications,
          color: Colors.redAccent,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: OsSwitch(value: isOn, onChanged: onChanged,),
      ),
    );
  }
}
