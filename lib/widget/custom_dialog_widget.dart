import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';

/// Get.dialog() 내부 커스텀 위젯
class CustomGetxDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const CustomGetxDialogWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: AppColors.backgroundColor,
      title: Text(
        title,
        style: const TextStyle(color: AppColors.mainRedColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: Text(
        content,
        style: const TextStyle(color: AppColors.blackColor, fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text(
            '취소',
            style: TextStyle(color: AppColors.mainRedColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text(
            '확인',
            style: TextStyle(color: AppColors.mainRedColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}