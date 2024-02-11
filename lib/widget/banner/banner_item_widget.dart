import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/banner/banner_item.dart';
import 'package:flutter_balance_game_client/widget/banner/custom_image_widget.dart';

/// 배너 카드 위젯
class BannerCard extends StatelessWidget {
  /// 배너 전체 개수
  final int bannerTotalCount;

  /// 배너 인덱스
  final int bannerIndex;

  /// 배너 DTO
  final BannerDTO bannerDTO;

  const BannerCard(
      {required this.bannerTotalCount,
      required this.bannerIndex,
      required this.bannerDTO,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 345,
      height: 100,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomRadiusImage.asset(
                fileDirectory: bannerDTO.fileDirectory!,
                fileName: bannerDTO.fileName!,
                radius: 20,
                width: 345,
                height: 100),
          ),
          _getBannerCountContainer()
        ],
      ),
    );
  }

  /// 인덱스 표시
  Widget _getBannerCountContainer() {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
        child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black54,
              ),
              width: 40,
              height: 20,
              child: Center(
                  child: Text(
                "$bannerIndex/$bannerTotalCount",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              )),
            )),
      ),
    );
  }
}
