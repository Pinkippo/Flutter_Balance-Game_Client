import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';

/// 메인 페이지 내부 리스트 탭 관련 Getx Controller
class ListByController extends GetxController {

  /// .to로 생성된 인스턴스에 접근하기 위한 static 변수
  static ListByController get to => Get.find();

  /// 선택된 탭 인덱스 정보
  final RxInt selectedIndex = 0.obs;

  /// 배너 인덱스 정보
  final RxInt bannerCurrentIndex = 1.obs;

  /// 선택된 탭 인덱스 변경 - 메서드
  void changeIndex(int index) {
    selectedIndex(index);
  }

  /// 배너 현재 인덱스 변경
  void onBannerChanged(int index, CarouselPageChangedReason reason) {
    bannerCurrentIndex(index + 1);
  }

}