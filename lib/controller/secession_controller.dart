import 'package:get/get.dart';

class SecessionController extends GetxController{

  /// 사용자 탈퇴 비밀번호 입력 정보 컨트롤러
  final RxString secessionUserPw = RxString(''); // 비밀번호

  /// 사용자 탈퇴 비밀번호 입력 정보 업데이트
  void updateSecessionUserPw(String pw) => secessionUserPw.value = pw;

  /// 사용자 탈퇴 비밀번호 입력 정보 초기화
  void clearSecessionUserPw() => secessionUserPw.value = '';

}