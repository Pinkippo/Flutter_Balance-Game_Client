
/// 로그인 응답 모델
class LoginResponseModel {

  String message;
  String token;

  /// 로그인 응답 모델 생성자
  LoginResponseModel({
    required this.message,
    required this.token,
  });

  /// 로그인 응답 모델 - fromJson 메서드
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'],
      token: json['token'],
    );
  }
}