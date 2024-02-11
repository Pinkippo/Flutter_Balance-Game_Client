import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/banner/banner_item.dart';
import 'package:flutter_balance_game_client/controller/list_controller.dart';
import 'package:flutter_balance_game_client/widget/banner/banner_item_widget.dart';
import 'package:flutter_balance_game_client/widget/banner/banner_slide_widget.dart';
import 'package:flutter_balance_game_client/widget/main_list_by/list_by_tab_header_widget.dart';
import 'package:get/get.dart';

import '../../controller/main_list_by_controller.dart';
import '../list_tap/main_list_by_date.dart';
import '../list_tap/main_list_by_heart.dart';
import '../list_tap/main_list_by_heart_on.dart';

/// 메인 리스트 탭
class MainListTap extends GetView<ListByController> {
  const MainListTap({super.key});

  /// 메인 리스트 탭 내부 글 목록
  static List<Widget> tabPages = const <Widget>[
    ListByDate(),
    ListByHeart(),
    ListByHeartOn(),
  ];

  @override
  Widget build(BuildContext context) {

    Get.put(ListByController(), permanent: true);
    Get.put(ListController(), permanent: true);

    return Column(
      children: [

        /// 이미지 배너
        Obx(() => TopBannerSlider(
            sliderItemList: _getBannerWidget(), onChanged: controller.onBannerChanged)),
        const SizedBox(height: 20),

        /// 탭 바 - 바텀 네비게이션 바와 동일한 방식으로 구현
        ListByTabHeader(controller: controller),

        /// 탭 바 내부 글 목록
        Expanded(
          child: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: tabPages,
          )),
        ),
      ],
    );
  }

  /// 배너 리스트
  List<Widget>? _getBannerWidget() {
    final bannerList = BannerItem().tempBannerList;
    final bannerTotalCount = bannerList.length;
    return bannerList.map((bannerItem) {
      return BannerCard(
          bannerIndex: controller.bannerCurrentIndex.value,
          bannerTotalCount: bannerTotalCount,
          bannerDTO: bannerItem);
    }).toList();
  }

}
