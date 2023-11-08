
/// 회원가입 요청 모델
class RegisterRequestModel {
  String userId;
  String userPw;
  String userName;
  String userEmail;


  /// 회원가입 요청 모델 생성자
  RegisterRequestModel({
    required this.userId,
    required this.userPw,
    required this.userName,
    required this.userEmail
  });

  /// 회원가입 요청 모델 - JSON 변경 메서드
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userPw': userPw,
      'userName': userName,
      'userEmail': userEmail
    };
  }

}