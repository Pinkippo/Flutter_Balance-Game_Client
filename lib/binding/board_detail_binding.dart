import 'package:flutter_balance_game_client/controller/board_detail_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// 게시글 상세 페이지 바인딩 - 게시글 상세 페이지 호출 시 게시글 정보 호출
class BoardDetailBinding implements Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<BoardDetailController>(() {
      return BoardDetailController();
    });
  }
}
