import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/data/model/board_response_model.dart';
import 'package:flutter_balance_game_client/data/model/comment_response_model.dart';
import 'package:flutter_balance_game_client/data/repository/board_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

/// 게시글 상세 관련 Getx Controller
class BoardDetailController extends GetxController{

  final storage = const FlutterSecureStorage();

  // 스크롤 컨트롤러
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    await getBoardDetail();
    super.onInit();
  }

  /// 게시글 상세 정보
  Rx<BoardResponseModel> boardResponseModel = BoardResponseModel(
      boardKey: 0,
      userName: "",
      boardDate: "",
      boardTitle: "",
      leftContent: "",
      rightContent: "",
      heartCount: 0,
      leftCount: 0,
      rightCount: 0,
      commentList: []
  ).obs;

  // 게시물 정보 호출
  Future<void> getBoardDetail() async {

    final Map<String, dynamic> parameters = Get.parameters;
    int boardKey = int.parse(parameters['boardKey'] ?? '');

    String? token = await storage.read(key: 'jwtToken');

    //boardResponseModel.value = await BoardRepository().getBoardDetail(token!, boardKey);

    // 2초 딜레이
    await Future.delayed(const Duration(seconds: 1));

    // UI 생성을 위한 가짜 데이터
    boardResponseModel.value = BoardResponseModel(
        boardKey: 1,
        userName: "테스트 유저",
        boardDate: "2023-12-23T08:58:17.333Z",
        boardTitle: "일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오육칠팔구십",
        leftContent: "일이삼사오육칠팔구십일이삼사오육칠팔구십",
        rightContent: "일이삼사오육칠팔구십일이삼사오육칠팔구십",
        heartCount: 10,
        leftCount: 24,
        rightCount: 35,
        commentList: [
          CommentModel(
             commentContent: "테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 ",
            commentTime: "2023-12-23T08:58:17.333Z",
            commentKey: 1,
          ),
          CommentModel(
            commentContent: "테스트 댓글 2 테스트 댓글 2 테스트 댓글 2 테스트 댓글 2 테스트 댓글 2 테스트 댓글 2",
            commentTime: "2023-12-23T08:58:17.333Z",
            commentKey: 2,
          ),
          CommentModel(
            commentContent: "테스트 댓글 3 테스트 댓글 3",
            commentTime: "2023-12-23T08:58:17.333Z",
            commentKey: 3,
          ),
          CommentModel(
            commentContent: "테스트 댓글 4 테스트 댓글 4 테스트 댓글 4 테스트 댓글 4",
            commentTime: "2023-12-23T08:58:17.333Z",
            commentKey: 4,
          ),
          CommentModel(
            commentContent: "테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 ",
            commentTime: "2023-12-23T08:58:17.333Z",
            commentKey: 5,
          ),
          CommentModel(
            commentContent: "테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 ",
            commentTime: "2023-12-23T08:58:17.333Z",
            commentKey: 6,
          ),
          CommentModel(
            commentContent: "테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 테스트 댓글 1 ",
            commentTime: "2023-12-23T08:58:17.333Z",
            commentKey: 7,
          ),
        ]
    );


    if(boardResponseModel.value.boardKey == -1){
      Get.snackbar(
        "조회 실패",
        "게시물을 불러오는데 실패했습니다",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.fromLTRB(20, 0, 100, 20),
      );
      Get.back();
    }
  }




}