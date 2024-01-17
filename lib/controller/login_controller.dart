import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/data/model/login_reponse_model.dart';
import 'package:flutter_balance_game_client/data/model/login_request_model.dart';
import 'package:flutter_balance_game_client/data/model/register_request_model.dart';
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

  changeLoginState() {
    firstEnter.value = false;
  }

  changeDeepLinkUrl(String url) {
    deepLinkString.value = url;
  }

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

  /// 로그인 테스트 - 로그인 상태 확인
  bool get isLogin => jwtToken.value != '';

  // /// 로그인 테스트 - 토큰 설정하기
  // Future<void> setToken() async {
  //   print("토큰 세팅 --------");
  //   await storage.write(key: 'jwtToken', value: 'sdfsdfsdfsdf');
  // }

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
