import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/data/repository/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

/// 로그인 관련 Getx Controller
class LoginController extends GetxController{

  final storage = const FlutterSecureStorage();

  final Rx<String> jwtToken = Rx<String>('');

  @override
  void onInit() async {
    await setToken();
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


}