import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

/// 상단 배너 슬라이더
class TopBannerSlider extends StatelessWidget {

  /// 아이템 리스트
  final List<Widget>? sliderItemList;

  /// 배너 변경 함수
  final void Function(int, CarouselPageChangedReason) onChanged;

  const TopBannerSlider(
      {required this.sliderItemList, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: sliderItemList,
      options: CarouselOptions(
        autoPlay: true,
        height: 100,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayInterval: const Duration(seconds: 5),
        // enlargeCenterPage: true,
        // aspectRatio: 2.0,
        viewportFraction: 1.0,
        onPageChanged: onChanged,
      ),
    );
  }
}