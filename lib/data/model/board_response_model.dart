import 'package:flutter_balance_game_client/data/model/comment_response_model.dart';

/// 글 리스트 응답 모델
class BoardResponseModel {
  final int boardKey;
  final String userName;
  final String boardDate;
  final String boardTitle;
  final String leftContent;
  final String rightContent;
  final int heartCount;
  // + 단일 조회만 사용
  final int leftCount;
  final int rightCount;
  // 댓글 리스트
  final List<CommentModel> commentList;

  BoardResponseModel({
    required this.boardKey,
    required this.userName,
    required this.boardDate,
    required this.boardTitle,
    required this.leftContent,
    required this.rightContent,
    required this.heartCount,
    required this.leftCount,
    required this.rightCount,
    required this.commentList,
  });

  BoardResponseModel.listItem({
    required this.boardKey,
    required this.userName,
    required this.boardDate,
    required this.boardTitle,
    required this.leftContent,
    required this.rightContent,
    required this.heartCount,
  }) : leftCount = 0, rightCount = 0, commentList = [];


  factory BoardResponseModel.fromJson(Map<String, dynamic> json) {
    List<CommentModel> comments = [];
    if (json['commentList'] != null) {
      for (var commentJson in json['commentList']) {
        comments.add(CommentModel.fromJson(commentJson));
      }
    }

    return BoardResponseModel(
      boardKey: json['boardKey'] as int,
      userName: json['userName'] as String,
      boardDate: json['boardDate'] as String,
      boardTitle: json['boardTitle'] as String,
      leftContent: json['leftContent'] as String,
      rightContent: json['rightContent'] as String,
      heartCount: json['heartCount'] as int,
      leftCount: json['leftCount'] == null ? 0 : json['leftCount'] as int,
      rightCount: json['rightCount'] == null ? 0 : json['rightCount'] as int,
      commentList: comments,
    );
  }

}