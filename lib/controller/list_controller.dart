import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/data/model/board_response_model.dart';
import 'package:flutter_balance_game_client/data/repository/board_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';



class ListController extends GetxController{

  final storage = const FlutterSecureStorage();

  /// 딥링크 스트림
  StreamSubscription? _sub;

  /// 페이지 번호 - 날짜순
  RxInt pageNumberByDate = 0.obs;

  /// 페이지 번호 - 좋아요순
  RxInt pageNumberByHeart = 0.obs;

  /// 페이지 번호 - 좋아요 누른 글
  RxInt pageNumberByHeartOn = 0.obs;

  /// 페이지 사이즈
  RxInt pageSize = 10.obs;

  /// 페이지 마지막 여부 - 날짜순
  RxBool isLastByDate = false.obs;

  /// 페이지 마지막 여부 - 좋아요순
  RxBool isLastByHeart = false.obs;

  /// 페이지 마지막 여부 - 좋아요 누른 글
  RxBool isLastByHeartOn = false.obs;

  /// 로딩 여부
  RxBool isLoading = false.obs;

  /// 게시물 리스트 - 날짜순
  RxList<BoardResponseModel> boardListByDate = <BoardResponseModel>[].obs;

  /// 게시물 리스트 - 좋아요순
  RxList<BoardResponseModel> boardListByHeart = <BoardResponseModel>[].obs;

  /// 게시물 리스트 - 좋아요 누른 글
  RxList<BoardResponseModel> boardListByHeartOn = <BoardResponseModel>[].obs;

  @override
  void onInit() async {

    /// 게시물 리스트에 초기 조회순 20개 추가
    await addBoardList(0);
    await addBoardList(1);
    await addBoardList(2);

    /// 백그라운드 딥링크 처리
    _handleIncomingLinks();

    super.onInit();
  }

  @override
  void dispose() {
    // 딥링크 스트림 해제
    _sub?.cancel();
    super.dispose();
  }

  /// 백그라운드 딥링크 처리
  void _handleIncomingLinks() {
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        if(uri == null) {
          return;
        }
        String boardKey = uri.queryParameters['boardKey'] ?? '';

        /// 딥링크로 들어온 경우 디테일 페이지 스택 추가
        Get.toNamed('/detail?boardKey=$boardKey');
      }, onError: (Object err) {
        print('딥링크 에러 => $err');
      });
    }
  }

  /// 페이지 번호 수정
  void changePageNumber(int index, int number) {
    if(index == 0) {
      pageNumberByDate.value = number;
    } else if(index == 1) {
      pageNumberByHeart.value = number;
    } else if(index == 2) {
      pageNumberByHeartOn.value = number;
    }
  }

  /// 게시물 리스트 새로고침
  Future<void> refreshBoardList(int index) async {
    // 페이지 번호 초기화
    changePageNumber(index, 0);

    // 마지막 페이지 여부 초기화
    if(index == 0) {
      isLastByDate.value = false;
    } else if(index == 1) {
      isLastByHeart.value = false;
    } else if(index == 2) {
      isLastByHeartOn.value = false;
    }

    // 게시물 리스트 초기화
    if(index == 0) {
      boardListByDate.clear();
    } else if(index == 1) {
      boardListByHeart.clear();
    } else if(index == 2) {
      boardListByHeartOn.clear();
    }

    // 게시물 리스트 추가
    addBoardList(index);
  }

  /// 게시글 리스트 추가 - index : 탭 인덱스
  Future<void> addBoardList(int index) async {

    // 로딩 시작
    isLoading.value = true;

    String? token = await storage.read(key: 'jwtToken');

    // 인덱스에 따라 게시물을 불러오고 페이지 번호 증가 및 마지막 페이지 여부 수정
    if(index == 0 && !isLastByDate.value ) {
      List<BoardResponseModel> boardList = await BoardRepository().getMainListByDate(token!, pageNumberByDate.value, pageSize.value);
      if(boardList.length < pageSize.value && pageNumberByDate.value != 0) {
        isLastByDate.value = true;
        Get.snackbar(
          '마지막 리스트 입니다',
          '더 이상 게시물이 없습니다',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.mainPurpleColor,
          colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 70, left: 10, right: 10),
        );
      }else if(boardList.length < pageSize.value){
        isLastByDate.value = true;
      }

      boardListByDate.addAll(boardList);
      pageNumberByDate.value++;

    } else if(index == 1 && !isLastByHeart.value) {
      List<BoardResponseModel> boardList = await BoardRepository().getMainListByHeart(token!, pageNumberByHeart.value, pageSize.value);
      if(boardList.length < pageSize.value && pageNumberByHeart.value != 0) {
        isLastByHeart.value = true;
        Get.snackbar(
          '마지막 리스트 입니다',
          '더 이상 게시물이 없습니다',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.mainPurpleColor,
          colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 70, left: 10, right: 10),
        );
      }else if(boardList.length < pageSize.value){
        isLastByHeart.value = true;
      }

      boardListByHeart.addAll(boardList);
      pageNumberByHeart.value++;

    } else if(index == 2 && !isLastByHeartOn.value) {
      List<BoardResponseModel> boardList = await BoardRepository().getMainListByHeartOn(token!, pageNumberByHeartOn.value, pageSize.value);
      if(boardList.length < pageSize.value && pageNumberByHeartOn.value != 0) {
        isLastByHeartOn.value = true;
        Get.snackbar(
          '마지막 리스트 입니다',
          '더 이상 게시물이 없습니다',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.mainPurpleColor,
          colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 70, left: 10, right: 10),
        );
      }else if(boardList.length < pageSize.value){
        isLastByHeartOn.value = true;
      }

      boardListByHeartOn.addAll(boardList);
      pageNumberByHeartOn.value++;

    }

    // 로딩 종료
    isLoading.value = false;

  }



}