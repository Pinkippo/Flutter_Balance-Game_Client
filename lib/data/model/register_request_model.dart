
/// 회원가입 요청 모델
class RegisterRequestModel {
  String userId;
  String userPassword;
  String userName;
  String userEmail;


  /// 회원가입 요청 모델 생성자
  RegisterRequestModel({
    required this.userId,
    required this.userPassword,
    required this.userName,
    required this.userEmail
  });

  /// 회원가입 요청 모델 - JSON 변경 메서드
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userPassword': userPassword,
      'userName': userName,
      'userEmail': userEmail
    };
  }

}