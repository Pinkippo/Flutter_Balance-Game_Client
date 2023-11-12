import 'package:flutter_balance_game_client/common/pref/rx_preference_item.dart';

/// 앱 정보 설정
class Prefs {
  static final isAdPushOnRx = RxPreferenceItem<bool, RxBool>('isAdPushOnRx', true);
}