import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/common/pref/app_pref.dart';
import 'package:flutter_balance_game_client/controller/login_controller.dart';
import 'package:flutter_balance_game_client/widget/mypage/mypage_header_widget.dart';
import 'package:flutter_balance_game_client/widget/mypage/mypage_item_widget.dart';
import 'package:flutter_balance_game_client/widget/mypage/mypage_switch_widget.dart';
import 'package:flutter_balance_game_client/widget/mypage/mypage_title_widget.dart';
import 'package:get/get.dart';

import '../../widget/custom_dialog_widget.dart';

/// 메인 마이페이지 탭
class MainMypageTap extends GetView<LoginController> {
  const MainMypageTap({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          /// 마이페이지 상단 탭
          const MyPageHeader(),
          const SizedBox(
            height: 20,
          ),
          /// 마이페이지 하단 탭
          const MyPageTitleWidget(title: '계정'),
          /// 정보 변경
          MyPageListItem(
            icon: Icons.person,
            title: '정보 변경',
            onTap: () {
              // TODO: 정보변경 페이지 이동 후 구현
            },
          ),
          /// 비밀번호 변경
          MyPageListItem(
            icon: Icons.lock,
            title: '비밀번호 변경',
            onTap: () {
              // TODO: 비밀 번호 변경 페이지 이동 후 구현
            },
          ),
          /// 로그아웃
          MyPageListItem(
            icon: Icons.logout,
            title: '로그아웃',
            onTap: () {
              Get.dialog(
                CustomGetxDialogWidget(
                  title: '로그아웃',
                  content: '로그아웃 하시겠습니까?',
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    controller
                        .logout()
                        .then((value) => {Get.offAllNamed('/login')});
                  },
                ),
              );
            },
          ),
          /// 회원 탈퇴
          MyPageListItem(
            icon: Icons.delete,
            title: '회원 탈퇴',
            onTap: () {
              // TODO: 회원탈퇴 페이지 이동 후 구현
            },
          ),
          const MyPageTitleWidget(title: '알림'),
          Obx(
                () => MyPageSwitchmenu('양자택일 알림', Prefs.isAdPushOnRx.get(),
                onChanged: (isOn) async {
                  Prefs.isAdPushOnRx.set(isOn);
                  if (isOn) {
                    print('양자택일 알림 ON');
                    /// TODO : 알림 ON 로직 연결
                  } else {
                    print('양자택일 알림 Off');
                    /// TODO : 알림 OFF 로직 연결
                  }
                }),
          ),
        ],
      ),
    );
  }
}
