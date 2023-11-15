import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_balance_game_client/data/provider/api.dart';

import '../model/board_response_model.dart';

/// 회원 데이터 처리 클래스
class BoardRepository{

  /// 메인 리스트 호출
  Future<List<BoardResponseModel>> getMainList (String token, int pageNumber, int pageSize) async {
    return MyApiClient().getMainList(
      pageNumber, pageSize, token
    );
  }


}