import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repository.dart';

class SecessionController extends GetxController{

  final storage = const FlutterSecureStorage();

  /// 사용자 탈퇴 비밀번호 입력 정보 컨트롤러
  final RxString secessionUserPw = RxString(''); // 비밀번호

  /// 사용자 탈퇴 비밀번호 입력 정보 업데이트
  void updateSecessionUserPw(String pw) => secessionUserPw.value = pw;

  /// 사용자 탈퇴 비밀번호 입력 정보 초기화
  void clearSecessionUserPw() => secessionUserPw.value = '';

  /// 탈퇴하기
  Future<bool> secession() async {
    String? token = await storage.read(key: 'jwtToken');
    bool result = await AuthRepository().secession(token!, secessionUserPw.value);
    return result;
  }


}