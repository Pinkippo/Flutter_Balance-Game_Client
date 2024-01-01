import 'package:flutter_balance_game_client/data/model/like_model.dart';
import 'package:sembast/sembast.dart';
import 'app_database.dart';

/// 좋아요 여부 저장을 위한 DAO
class LikeDao{

  static const String folderName = "like";

  final _chatFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.chatDatabase;

  /// 추가
  Future insert(LikeModel likeModel) async {
    await _chatFolder.add(await _db, likeModel.toMap());
  }

  /// 조회 - bool
  Future<bool> isLike(String boardKey, String jwt) async {
    final finder = Finder(filter: Filter.and([
      Filter.equals('boardKey', boardKey),
      Filter.equals('jwt', jwt),
    ]));
    final recordSnapshot = await _chatFolder.findFirst(await _db, finder: finder);
    if(recordSnapshot == null){
      return false;
    }else{
      return true;
    }
  }

  /// 삭제
  Future delete(String boardKey, String jwt) async {
    final finder = Finder(filter: Filter.and([
      Filter.equals('boardKey', boardKey),
      Filter.equals('jwt', jwt),
    ]));
    await _chatFolder.delete(await _db, finder: finder);
  }


}