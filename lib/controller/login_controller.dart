import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/data/model/login_reponse_model.dart';
import 'package:flutter_balance_game_client/data/model/login_request_model.dart';
import 'package:flutter_balance_game_client/data/model/register_request_model.dart';
import 'package:flutter_balance_game_client/data/provider/api.dart';
import 'package:flutter_balance_game_client/data/repository/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

/// 로그인 관련 Getx Controller
class LoginController extends GetxController{

  final AuthRepository authRepository;
  LoginController({required this.authRepository});

  /// 보안 저장소 - Jwt Token 보관
  final storage = const FlutterSecureStorage();

  /// 로그인 Jwt Token 상태
  final Rx<String> jwtToken = Rx<String>('');

  /// 사용자 입력 정보
  final RxString userEmail = RxString(''); // 이메일

  final RxString userPassword = RxString(''); // 비밀번호

  final RxString userPasswordCheck = RxString(''); // 비밀번호 확인

  final RxString userId = RxString(''); // 아이디

  final RxString userName = RxString(''); // 이름

  /// Controller -> onInit() 완료 후 실행 됨
  @override
  void onInit() async {

    /// 로그인 유지 - 토큰 가져오기
    await getToken();
    super.onInit();
  }

  /// 로그인 테스트 - 토큰 가져오기
  Future<void> getToken() async {
    jwtToken.value = await storage.read(key: 'jwtToken') ?? '';
    print('jwtToken: = ${jwtToken.value}');
  }

  /// 로그인 테스트 - 토큰 설정하기
  Future<void> setToken() async {
    print("토큰 세팅 --------");
    await storage.write(key: 'jwtToken', value: 'sdfsdfsdfsdf');
  }

  /// 사용자 입력 정보 업데이트
  void updateEmail(String value) {
    userEmail.value = value;
  }

  void updatePassword(String value) {
    userPassword.value = value;
  }

  void updatePasswordCheck(String value) {
    userPasswordCheck.value = value;
  }

  void updateId(String value) {
    userId.value = value;
  }

  void updateName(String value) {
    userName.value = value;
  }

  /// 비밀번호 비교 - 메서드
  bool comparePassword() {
    if(userPassword.value == userPasswordCheck.value) {
      return true;
    } else {
      return false;
    }
  }

  /// 로그인 - 메서드
  Future<bool> login() async {

    if(userId.value == '' || userPassword.value == '') {
      Get.snackbar(
          '로그인 요청 실패',
          '아이디와 비밀번호를 확인해주세요.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    final LoginResponseModel response = await authRepository.login(LoginRequestModel(userId: userId.value, userPassword: userPassword.value));
    if(response.token != ''){
      jwtToken.value = response.token;
      return true;
    }else{
      Get.snackbar(
          '로그인 요청 실패',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  /// 회원가입 - 메서드
  Future<void> register() async {
    if (userEmail.value == '' ||
        userPassword.value == '' ||
        userId.value == '' ||
        userName.value == '') {
      Get.snackbar('회원가입 요청 실패', '모든 정보를 입력해주세요.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!comparePassword()) {
      Get.snackbar('회원가입 요청 실패', '비밀번호가 일치하지 않습니다.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final response = await authRepository.register(
        RegisterRequestModel(
            userId: userId.value,
            userPassword: userPassword.value,
            userName: userName.value,
            userEmail: userEmail.value));

    ///TODO : 회원가입 로직 완성

  }

}