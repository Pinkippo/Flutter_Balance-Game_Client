import 'package:flutter_balance_game_client/data/model/login_request_model.dart';
import 'package:flutter_balance_game_client/data/model/register_request_model.dart';
import 'package:flutter_balance_game_client/data/provider/api.dart';

/// 회원 데이터 처리 클래스
class AuthRepository{

  login(LoginRequestModel loginRequestModel) {
    return MyApiClient().login(loginRequestModel);
  }
  
  register(RegisterRequestModel registerRequestModel) {
    return MyApiClient().register(registerRequestModel);
  }

  secession(String token, String password) {
    return MyApiClient().secession(token, password);
  }

  getUserInfo(String token) {
    return MyApiClient().getUserInfo(token);
  }

}