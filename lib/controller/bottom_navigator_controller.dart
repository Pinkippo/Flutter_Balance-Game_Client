import 'package:get/get.dart';

/// 바텀 네비게이션 바 관련 Getx Controller
class CustomBottomNavgationBarController extends GetxController {

  /// .to로 생성된 인스턴스에 접근하기 위한 static 변수
  static CustomBottomNavgationBarController get to => Get.find();

  /// 선택된 탭 인덱스 정보
  final RxInt selectedIndex = 1.obs;

  /// 선택된 탭 인덱스 변경 - 메서드
  void changeIndex(int index) {
    selectedIndex(index);
  }
}