import 'package:flutter_balance_game_client/controller/login_controller.dart';

class UserResponseModel {
  final LoginState message;
  final String userId;
  final String userName;
  final String userEmail;

  UserResponseModel({
    required this.message,
    required this.userId,
    required this.userName,
    required this.userEmail,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      message: LoginState.login,
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userEmail: json['userEmail'] ?? '',
    );
  }
}
