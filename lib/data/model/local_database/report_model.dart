
/// 게임 + 댓글 신고 여부 저장을 위한 로컬 데이터베이스 모델
class ReportModel{

  @override
  int get hashCode => boardKey.hashCode ^ commentKey.hashCode ^ uid.hashCode ^ timestamp.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ReportModel &&
              runtimeType == other.runtimeType &&
              boardKey == other.boardKey &&
              commentKey == other.commentKey &&
              uid == other.uid &&
              timestamp == other.timestamp;

  int? id;

  final String boardKey;
  final String commentKey;
  final String uid;
  final String timestamp;

  ReportModel({
    required this.boardKey,
    required this.commentKey,
    required this.uid,
    required this.timestamp,
  });

  static ReportModel fromMap(Map<String, dynamic> map, String carId) {
    return ReportModel(
      boardKey: map['boardKey'] as String,
      commentKey: map['commentKey'] as String,
      uid: map['uid'] as String,
      timestamp: map['timestamp'] as String,
    );
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      boardKey: json['boardKey'] as String,
      commentKey: json['commentKey'] as String,
      uid: json['uid'] as String,
      timestamp: json['timestamp'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'boardKey': boardKey,
      'commentKey': commentKey,
      'uid': uid,
      'timestamp': timestamp,
    };
  }

}