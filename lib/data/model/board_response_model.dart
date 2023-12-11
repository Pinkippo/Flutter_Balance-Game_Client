/// 글 리스트 응답 모델
class BoardResponseModel {
  final int boardKey;
  final String userName;
  final String boardDate;
  final String boardTitle;
  final String leftContent;
  final String rightContent;
  final int heartCount;

  BoardResponseModel({
    required this.boardKey,
    required this.userName,
    required this.boardDate,
    required this.boardTitle,
    required this.leftContent,
    required this.rightContent,
    required this.heartCount,
  });

  factory BoardResponseModel.fromJson(Map<String, dynamic> json) {
    return BoardResponseModel(
      boardKey: json['boardKey'] as int,
      userName: json['userName'] as String,
      boardDate: json['boardDate'] as String,
      boardTitle: json['boardTitle'] as String,
      leftContent: json['leftContent'] as String,
      rightContent: json['rightContent'] as String,
      heartCount: json['heartCount'] as int,
    );
  }
}