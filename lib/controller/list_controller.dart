import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/data/model/board_response_model.dart';
import 'package:get/get.dart';

class ListController extends GetxController{

  RxList<BoardResponseModel> boardList = <BoardResponseModel>[].obs;


  @override
  void onInit() async {
    await addMockBoard();
    super.onInit();
  }

  /// Test 데이터 추가
  Future<void> addMockBoard() async {
    for (int i = 0; i < 20; i++) {
      boardList.add(BoardResponseModel(
        boardDate: '2021-09-01',
        boardTitle: '제목sfasdfasfasdfasfasdfasfdasdfaadfadfasdfasdfadfadfasfdasfdasfasdfasdfasfasdf $i',
        boardKey: i,
        leftContent: '왼쪽 $i',
        rightContent: '오른쪽 $i',
        userName: '유저 $i',
      ));
    }
  }



}