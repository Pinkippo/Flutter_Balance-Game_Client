import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/data/model/board_response_model.dart';
import 'package:flutter_balance_game_client/data/repository/board_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';



class ListController extends GetxController{

  final storage = const FlutterSecureStorage();

  /// 페이지 번호
  RxInt pageNumber = 0.obs;

  /// 페이지 사이즈
  RxInt pageSize = 20.obs;

  RxList<BoardResponseModel> boardList = <BoardResponseModel>[].obs;

  @override
  void onInit() async {
    //await addMockBoard();
    addBoardList();

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
        heartCount: i,
      ));
    }
  }

  /// 게시글 리스트 추가 -
  Future<void> addBoardList() async {
    String? token = await storage.read(key: 'jwtToken');
    print('토큰${token!}');
    print(pageNumber.value);
    print(pageSize.value);

    List<BoardResponseModel> tempList = await BoardRepository().getMainList(token ,pageNumber.value, pageSize.value);
    boardList.addAll(tempList);
  }



}