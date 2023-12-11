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

  /// 페이지 마지막 여부
  RxBool isLast = false.obs;

  /// 게시물 리스트
  RxList<BoardResponseModel> boardList = <BoardResponseModel>[].obs;

  @override
  void onInit() async {
    addBoardList();
    super.onInit();
  }

  /// 페이지 번호 수정
  void changePageNumber(int number) {
    pageNumber.value = number;
  }

  /// 게시글 리스트 추가 -
  Future<void> addBoardList() async {

    // 마지막 페이지 여부 확인
    if(isLast.value) {
      return;
    }

    String? token = await storage.read(key: 'jwtToken');
    print('토큰${token!}');
    print(pageNumber.value);
    print(pageSize.value);

    // 게시물 추가
    List<BoardResponseModel> tempList = await BoardRepository().getMainList(token ,pageNumber.value, pageSize.value);
    // 만약 게시물 개수가 20개 미만 - 마지막 페이지
    if (tempList.length < pageSize.value) {
      isLast.value = true;
    }

    boardList.addAll(tempList);
    // 페이지 번호 증가
    changePageNumber(pageNumber.value + 1);
  }

  /// 게시물 리스트 새로고침
  Future<void> refreshBoardList() async {
    // 게시물 리스트 초기화
    boardList.clear();
    changePageNumber(0);
    isLast.value = false;
    // 페이지 추가
    addBoardList();
  }



}