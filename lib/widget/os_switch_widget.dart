import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';

/// OS별 스위치 위젯
class OsSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const OsSwitch({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.mainRedColor,
            trackColor: AppColors.mainRedColor.withOpacity(0.25),
          )
        : Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.mainRedColor,
            activeTrackColor: AppColors.mainRedColor.withOpacity(0.25),
          );
  }
}
