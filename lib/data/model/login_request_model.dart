
/// 회원가입 요청 모델
class LoginRequestModel {
  String userId;
  String userPassword;


  /// 로그인 요청 모델 생성자
  LoginRequestModel({
    required this.userId,
    required this.userPassword,
  });

  /// 회원가입 요청 모델 - JSON 변경 메서드
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userPassword': userPassword,
    };
  }

}