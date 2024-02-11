/// 배너 아이템 클래스
class BannerItem {

  /// 메인 배너 리스트
  final List<BannerDTO> tempBannerList = [
    BannerDTO(name: "테스트 배너 1", bannerUrl: "", bannerOrder: 1, fileDirectory:"banner", fileName: "test_banner_1",  ),
    BannerDTO(name: "테스트 배너 2", bannerUrl: "", bannerOrder: 2, fileDirectory:"banner", fileName: "test_banner_2",  ),
    BannerDTO(name: "테스트 배너 3", bannerUrl: "", bannerOrder: 3, fileDirectory:"banner", fileName: "test_banner_3",  ),
  ];

}

/// 배너 DTO
class BannerDTO {
  final String name;
  final String bannerUrl;
  final int bannerOrder;
  String? fileDirectory;
  String? fileName;
  BannerDTO({
    required this.name,
    required this.bannerUrl,
    required this.bannerOrder,
    this.fileDirectory,
    this.fileName,
  });
}