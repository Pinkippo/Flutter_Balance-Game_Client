import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/data/model/login_reponse_model.dart';
import 'package:flutter_balance_game_client/data/model/login_request_model.dart';
import 'package:flutter_balance_game_client/data/model/register_request_model.dart';
import 'package:flutter_balance_game_client/data/model/user_response_model.dart';
import 'package:flutter_balance_game_client/data/repository/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

/// 로그인 상태 enum
enum LoginState {
  login,
  logout,
  loginExpired,
}

/// 로그인 관련 Getx Controller
class LoginController extends GetxController{

  final AuthRepository authRepository;
  LoginController({required this.authRepository});

  /// 보안 저장소 - Jwt Token 보관
  final storage = const FlutterSecureStorage();

  /// 로그인 Jwt Token 상태
  final Rx<String> jwtToken = Rx<String>('');

  /// 로그인 이넘 상태
  final Rx<LoginState> loginState = LoginState.logout.obs;

  /// uid - 유저 번호
  final RxString uid = RxString('');

  /// 사용자 입력 정보
  final RxString userEmail = RxString(''); // 이메일

  final RxString userPw = RxString(''); // 비밀번호

  final RxString userPwCheck = RxString(''); // 비밀번호 확인

  final RxString userId = RxString(''); // 아이디

  final RxString userName = RxString(''); // 이름

  /// 사용자 로그인 입력 정보
  final RxString loginUserId = RxString(''); // 아이디
  final RxString loginUserPw = RxString(''); // 비밀번호

  /// 첫 입장 여부
  final RxBool firstEnter = true.obs;

  /// 딥링크 url
  final RxString deepLinkString = RxString('');

  changeDeepLinkState() {
    firstEnter.value = false;
  }

  changeDeepLinkUrl(String url) {
    deepLinkString.value = url;
  }


  /// 로그인 테스트 - 토큰 가져오기
  Future<void> getToken() async {
    jwtToken.value = await storage.read(key: 'jwtToken') ?? '';

    /// 유저 정보 가져오기 API 호출 -> 403 == 토큰 만료 로그인 페이지 / 200 == 로그인 상태 유지 + 메인 페이지 + userId 저장
    if(jwtToken.value == '') {
      print("토큰 없음 - 로그아웃");
      loginState.value = LoginState.logout;
    }else{
      final UserResponseModel response = await authRepository.getUserInfo(jwtToken.value);
      if(response.message == LoginState.login){
        print("토큰 있음 - 로그인");
        loginState.value = LoginState.login;
        uid.value = response.userId;
      } else if(response.message == LoginState.loginExpired){
        print("토큰 만료 - 로그아웃");
        // 토큰 초기화
        await storage.delete(key: 'jwtToken');
        loginState.value = LoginState.loginExpired;
      } else {
        print("토큰 있음 서버 오류 - 로그아웃");
        // 토큰 초기화
        await storage.delete(key: 'jwtToken');
        loginState.value = LoginState.logout;
      }
    }
  }


  /// 사용자 입력 정보 업데이트

  void clearUserInput() {
    userEmail.value = '';
    userPw.value = '';
    userPwCheck.value = '';
    userId.value = '';
    userName.value = '';
  }

  void updateLoginUserId(String value) {
    loginUserId.value = value;
  }

  void updateLoginUserPw(String value) {
    loginUserPw.value = value;
  }

  void updateEmail(String value) {
    userEmail.value = value;
  }

  void updatePw(String value) {
    userPw.value = value;
  }

  void updatePwCheck(String value) {
    userPwCheck.value = value;
  }

  void updateId(String value) {
    userId.value = value;
  }

  void updateName(String value) {
    userName.value = value;
  }

  /// 비밀번호 비교 - 메서드
  bool comparePassword() {
    if(userPw.value == userPwCheck.value) {
      return true;
    } else {
      return false;
    }
  }

  /// 로그인 - 메서드
  Future<bool> login() async {

    if(loginUserId.value == '' || loginUserPw.value == '') {
      Get.snackbar(
          '로그인 요청 실패',
          '아이디와 비밀번호를 확인해주세요.',
          backgroundColor: AppColors.mainRedColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    final LoginResponseModel response = await authRepository.login(LoginRequestModel(userId: loginUserId.value, userPw: loginUserPw.value));
    if(response.token != ''){
      /// 토큰 저장 - 로그인 성공
      jwtToken.value = response.token;
      await storage.write(key: 'jwtToken', value: response.token);

      // 유저 정보 호출 - uid 저장
      /// TODO : 로그인 API 변경 uid 함께 호출
      final UserResponseModel userInfo = await authRepository.getUserInfo(response.token);
      uid.value = userInfo.userId;

      return true;
    }else{
      /// 로그인 실패
      return false;
    }

  }

  /// 로그아웃 - 메서드
  Future<void> logout() async {
    await storage.delete(key: 'jwtToken');
    jwtToken.value = '';
  }

  /// 회원가입 - 메서드
  Future<bool> register() async {
    if (userEmail.value == '' ||
        userPw.value == '' ||
        userId.value == '' ||
        userName.value == '') {
      Get.snackbar('회원가입 요청 실패', '모든 정보를 입력해주세요.',
          backgroundColor: AppColors.mainRedColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (!comparePassword()) {
      Get.snackbar('회원가입 요청 실패', '비밀번호가 일치하지 않습니다.',
          backgroundColor: AppColors.mainRedColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    final bool response = await authRepository.register( RegisterRequestModel(
        userId: userId.value,
        userPw: userPw.value,
        userName: userName.value,
        userEmail: userEmail.value));

    return response;
  }
}
