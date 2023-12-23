import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_balance_game_client/data/provider/api.dart';

import '../model/board_response_model.dart';

/// 게시판 데이터 처리 클래스
class BoardRepository{

  /// 메인 리스트 호출
  Future<List<BoardResponseModel>> getMainListByDate (String token, int pageNumber, int pageSize) async {
    return MyApiClient().getMainList(
      pageNumber, pageSize, token
    );
  }

  /// 좋아요 순 리스트 호출
  Future<List<BoardResponseModel>> getMainListByHeart (String token, int pageNumber, int pageSize) async {
    return MyApiClient().getMainListByHeart(
        pageNumber, pageSize, token
    );
  }

  /// 내가 좋아요 누른 글 리스트 호출
  Future<List<BoardResponseModel>> getMainListByHeartOn (String token, int pageNumber, int pageSize) async {
    return MyApiClient().getMainListByHeartOn(
        pageNumber, pageSize, token
    );
  }

  /// 글쓰기
  Future<bool> write(String token, String title, String left, String right) async {
    return MyApiClient().write(token, title, left, right);
  }

  /// 게시글 상세 호출
  Future<BoardResponseModel> getBoardDetail (String token, int boardKey) async {
    return MyApiClient().getBoardDetail(
        token, boardKey
    );
  }

}