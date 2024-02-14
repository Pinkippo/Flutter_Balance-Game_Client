import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/controller/login_controller.dart';
import 'package:get/get.dart';

/// 마이페이지 탭 상단 위젯
class MyPageHeader extends GetView<LoginController> {
  const MyPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.94,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.mainRedColor , Colors.redAccent],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 10),
              blurRadius: 5,
              spreadRadius: 0,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 상단 - 사용자 이름
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.account_circle,
                  size: 60,
                  color: Colors.white,
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${controller.userName.value}님",
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      controller.userEmail.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),

          const Spacer(),

          /// 하단 - 사용자 정보
          Container(
            color: Colors.white.withOpacity(0.65),
            height: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /// TODO : 사용자 정보 데이터 연결하기
                _buildCountColumn('작성한 게시글', 10),
                _buildCountColumn(
                    '작성한 댓글', 20),
                _buildCountColumn(
                    '누른 좋아요', 20),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  /// 사용자 정보 보여주는 위젯
  Widget _buildCountColumn(String label, int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
