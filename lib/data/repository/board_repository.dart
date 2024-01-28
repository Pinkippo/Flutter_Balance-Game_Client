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

  /// 댓글 작성
  Future<int> writeComment(String token, int boardKey, String content) async {
    return MyApiClient().writeComment(token, boardKey, content);
  }

  /// 좋아요 추가
  Future<bool> addLike(String token, int boardKey) async {
    return MyApiClient().addLike(token, boardKey);
  }

  /// 좋아요 삭제
  Future<bool> deleteLike(String token, int boardKey) async {
    return MyApiClient().deleteLike(token, boardKey);
  }

  /// 댓글 삭제
  Future<bool> deleteComment(String token, int boardKey, int commentKey) async {
    return MyApiClient().deleteComment(token, boardKey, commentKey);
  }

  /// 게임 참여
  Future<bool> addGame(String token, int boardKey, String result) async {
    return MyApiClient().addGame(token, boardKey, result);
  }

  /// 게시물 신고
  Future<bool> reportBoard(String token, int boardKey, String reason) async {
    return MyApiClient().reportBoard(token, boardKey, reason);
  }

  /// 댓글 신고
  Future<bool> reportComment(String token, int commentKey, String reason) async {
    return MyApiClient().reportComment(token, commentKey, reason);
  }

}