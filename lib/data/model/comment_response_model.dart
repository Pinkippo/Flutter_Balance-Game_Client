class CommentModel {
  final int commentKey;
  final String commentContent;
  final String commentTime;

  CommentModel({
    required this.commentKey,
    required this.commentContent,
    required this.commentTime,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentKey: json['commentKey'] as int,
      commentContent: json['commentContent'] as String,
      commentTime: json['commentTime'] as String,
    );
  }
}
