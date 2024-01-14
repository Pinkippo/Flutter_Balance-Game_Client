import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/controller/write_controller.dart';
import 'package:flutter_balance_game_client/widget/write/write_form_widget.dart';
import 'package:get/get.dart';

/// 메인 글쓰기 탭
class MainWriteTab extends StatelessWidget {
  const MainWriteTab({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(WriteController() , permanent: true);

    /// TODO : 디자인 수정
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// 글쓰는 로고
            Container(
              height: Get.height * 0.2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),

            /// 글쓰기 입력 폼
            const WriteForm(),

          ],
        ),
      ),
    );
  }
}
