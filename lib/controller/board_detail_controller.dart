import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/common/database/app_game_dao.dart';
import 'package:flutter_balance_game_client/common/database/app_like_dao.dart';
import 'package:flutter_balance_game_client/controller/login_controller.dart';
import 'package:flutter_balance_game_client/data/model/board_response_model.dart';
import 'package:flutter_balance_game_client/data/model/comment_response_model.dart';
import 'package:flutter_balance_game_client/data/model/local_database/game_model.dart';
import 'package:flutter_balance_game_client/data/model/local_database/like_model.dart';
import 'package:flutter_balance_game_client/data/repository/board_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

/// 게시글 상세 관련 Getx Controller
class BoardDetailController extends GetxController{

  final storage = const FlutterSecureStorage();

  // 댓글 입력 컨트롤러
  TextEditingController commentContent = TextEditingController();

  // 댓글 갯수 -> 기본 5개
  RxInt commentCount = 5.obs;

  // 댓글 더보기 여부
  RxBool isCommentMore = false.obs;

  // 신고하기 폭력 여부
  RxBool isViolence = false.obs;

  // 신고하기 선정적 여부
  RxBool isSexual = false.obs;

  // 신고하기 광고 여부
  RxBool isAd = false.obs;

  // 신고하기 폭력 변경
  void changeViolence(){
    isViolence.value = !isViolence.value;
  }

  // 신고하기 선정적 변경
  void changeSexual(){
    isSexual.value = !isSexual.value;
  }

  // 신고하기 광고 변경
  void changeAd(){
    isAd.value = !isAd.value;
  }

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

  /// 게임 참여 여부
  Rx<GameStatus> isGame = GameStatus.none.obs;

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

    /// 댓글 정보 정렬
    boardResponseModel.value.commentList.sort((a, b) {
      return b.commentTime.compareTo(a.commentTime);
    });

    /// 댓글 갯수 확인
    checkCommentCount();

    /// 좋아요 여부 확인 후 변경
    isLike.value = await LikeDao().isLike( boardKey.toString(), Get.find<LoginController>().uid.value , boardResponseModel.value.boardDate);
    print("좋아요 여부 : ${isLike.value}");

    /// 게임 참여 여부 확인 후 변경
    isGame.value = await GameDao().isAlreadyGame(boardKey.toString(), Get.find<LoginController>().uid.value , boardResponseModel.value.boardDate);
    print("게임 참여 여부 : ${isGame.value}");

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
    boardResponseModel.value.commentList.insert(0, newComment);
    checkCommentCount();
    boardResponseModel.refresh();
  }

  /// 댓글 갯수 확인 후 더보기 버튼 출력여부 결정
  void checkCommentCount() {
    if (boardResponseModel.value.commentList.length > commentCount.value) {
      isCommentMore.value = true;
    }
  }

  /// 밸런스 게임 참가
  Future<void> addGame(GameStatus status) async{
    String? token = await storage.read(key: 'jwtToken');
    if(status == GameStatus.left){
      await BoardRepository().addGame(token!, boardResponseModel.value.boardKey, "left").then((value) async {
        await GameDao().insert(GameModel(boardKey: boardResponseModel.value.boardKey.toString(), uid: Get.find<LoginController>().uid.value, result: "left", timestamp: DateTime.now().toString())).then((value){
          isGame.value = GameStatus.left;
          boardResponseModel.value.leftCount += 1;
          boardResponseModel.refresh();
        });
      });
    }else if(status == GameStatus.right){
      await BoardRepository().addGame(token!, boardResponseModel.value.boardKey, "right").then((value) async {
        await GameDao().insert(GameModel(boardKey: boardResponseModel.value.boardKey.toString(), uid: Get.find<LoginController>().uid.value, result: "right", timestamp: DateTime.now().toString())).then((value){
          isGame.value = GameStatus.right;
          boardResponseModel.value.rightCount += 1;
          boardResponseModel.refresh();
        });
      });
    }else{
      return;
    }
  }

  /// 좋아요 추가/삭제
  Future<void> changeLike(int boardKey) async {
    String? token = await storage.read(key: 'jwtToken');
    if(isLike.value){
      await BoardRepository().deleteLike(token!, boardKey).then((value) async {
        await LikeDao().delete(boardKey.toString(), Get.find<LoginController>().uid.value).then((value){
          isLike.value = false;
          boardResponseModel.value.heartCount -= 1;
          boardResponseModel.refresh();
        });
        print("좋아요 삭제 성공");
      });
    }else{
      await BoardRepository().addLike(token!, boardKey).then((value) async {
        await LikeDao().insert(LikeModel(boardKey: boardKey.toString(), uid: Get.find<LoginController>().uid.value, timestamp: DateTime.now().toString())).then((value){
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

  /// 댓글 더보기
  void loadMoreComments() {
    commentCount.value += 5;
    // 더보기 버튼 숨기기
    if (commentCount.value >= boardResponseModel.value.commentList.length) {
      isCommentMore.value = false;
    }
    boardResponseModel.refresh();
  }

  /// 게시물 신고하기
  Future<void> reportGame() async {

    String? token = await storage.read(key: 'jwtToken');

    String reportReason = "";

    if(!isViolence.value && !isSexual.value && !isAd.value){
      Get.snackbar(
          "신고 실패",
          "신고 사유를 선택해주세요",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.mainRedColor,
          colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 60, left: 10, right: 10),
          duration: const Duration(seconds: 1)
      );
      return;
    }

    if(isViolence.value){
      reportReason += "[폭력적]";
    }
    if(isSexual.value){
      reportReason += "[선정적]";
    }
    if(isAd.value){
      reportReason += "[광고]";
    }

    await BoardRepository().reportBoard(
      token!,
      boardResponseModel.value.boardKey,
      reportReason
    ).then((value){
      if(value){
        Get.snackbar(
            "신고 성공",
            "게시물 신고를 완료했습니다",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.mainOrangeColor,
            colorText: Colors.white,
            margin: const EdgeInsets.only(bottom: 60, left: 10, right: 10),
            duration: const Duration(seconds: 1)
        );
      }
    });

    isViolence.value = false;
    isSexual.value = false;
    isAd.value = false;
  }

}