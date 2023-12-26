import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/data/model/board_response_model.dart';
import 'package:flutter_balance_game_client/data/model/comment_response_model.dart';
import 'package:flutter_balance_game_client/data/repository/board_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

/// 게시글 상세 관련 Getx Controller
class BoardDetailController extends GetxController{

  final storage = const FlutterSecureStorage();

  // 댓글 입력 컨트롤러
  TextEditingController commentContent = TextEditingController();

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

    boardResponseModel.value = await BoardRepository().getBoardDetail(token!, boardKey);

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

  /// 댓글 작성
  Future<void> writeComment(int boardKey) async {
    if(commentContent.text.isEmpty){
      Get.snackbar(
        "댓글 작성 실패",
        "댓글을 입력해주세요",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.fromLTRB(20, 0, 100, 20),
      );
      return;
    }

    String? token = await storage.read(key: 'jwtToken');
    await BoardRepository().writeComment(token!, boardKey, commentContent.text);

    // 댓글 작성 후 댓글 리스트에 추가
    addCommentToModel(
      CommentModel(
        // 키를 가장 큰 값으로 설정
        commentKey: 0,
        commentTime: DateTime.now().toString(),
        commentContent: commentContent.text,
      ),
    );


    commentContent.clear();
  }

  /// 댓글 추가
  void addCommentToModel(CommentModel newComment) {
    boardResponseModel.value.commentList.add(newComment);
    boardResponseModel.refresh();
  }

  /// 밸런스 게임 참가

  /// 좋아요 누르기







}