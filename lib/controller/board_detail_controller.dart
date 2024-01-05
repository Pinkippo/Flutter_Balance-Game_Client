import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/common/database/app_like_dao.dart';
import 'package:flutter_balance_game_client/data/model/board_response_model.dart';
import 'package:flutter_balance_game_client/data/model/comment_response_model.dart';
import 'package:flutter_balance_game_client/data/model/like_model.dart';
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

  /// 좋아요 여부
  RxBool isLike = false.obs;

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
        backgroundColor: AppColors.mainRedColor,
        colorText: Colors.white,
        margin: const EdgeInsets.fromLTRB(20, 0, 100, 20),
      );
      Get.back();
    }

    /// 좋아요 여부 확인 후 변경
    isLike.value = await LikeDao().isLike( boardKey.toString(), token, boardResponseModel.value.boardDate);
    print("좋아요 여부 : ${isLike.value}");

  }

  /// 댓글 작성
  Future<void> writeComment(int boardKey) async {
    if(commentContent.text.isEmpty){
      Get.snackbar(
        "댓글 작성 실패",
        "댓글을 입력해주세요",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.mainRedColor,
        colorText: Colors.white,
        margin: const EdgeInsets.fromLTRB(20, 0, 100, 20),
      );
      return;
    }

    String? token = await storage.read(key: 'jwtToken');

    int createCommentKey = await BoardRepository().writeComment(token!, boardKey, commentContent.text);
    if(createCommentKey == 0){
      return;
    }

    // 댓글 작성 후 댓글 리스트에 추가
    addCommentToModel(
      CommentModel(
        commentKey: createCommentKey,
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

  /// 좋아요 추가/삭제
  Future<void> changeLike(int boardKey) async {
    String? token = await storage.read(key: 'jwtToken');
    if(isLike.value){
      await BoardRepository().deleteLike(token!, boardKey).then((value) async {
        await LikeDao().delete(boardKey.toString(), token).then((value){
          isLike.value = false;
          boardResponseModel.value.heartCount -= 1;
          boardResponseModel.refresh();
        });
        print("좋아요 삭제 성공");
      });
    }else{
      await BoardRepository().addLike(token!, boardKey).then((value) async {
        await LikeDao().insert(LikeModel(boardKey: boardKey.toString(), jwt: token, timestamp: DateTime.now().toString())).then((value){
          isLike.value = true;
          boardResponseModel.value.heartCount += 1;
          boardResponseModel.refresh();
        });
        print("좋아요 추가 성공");
      });
    }
  }

  /// 댓글 삭제
  Future<void> deleteComment(int index) async {
    String? token = await storage.read(key: 'jwtToken');

    await BoardRepository().deleteComment(
        token!,
        boardResponseModel.value.boardKey,
        boardResponseModel.value.commentList[index].commentKey
        ).then((value){
          if(value){
            boardResponseModel.value.commentList.removeWhere((element) => element.commentKey == boardResponseModel.value.commentList[index].commentKey);
            boardResponseModel.refresh();
            Get.snackbar(
                "댓글 삭제 성공",
                "댓글을 삭제했습니다",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.mainOrangeColor,
                colorText: Colors.white,
                margin: const EdgeInsets.only(bottom: 60, left: 10, right: 10)
            );
          }
    });
  }

}