import 'package:flutter_balance_game_client/data/model/local_database/like_model.dart';
import 'package:sembast/sembast.dart';
import 'app_database.dart';

/// 좋아요 여부 저장을 위한 DAO
class LikeDao{

  static const String folderName = "like";

  final _likeFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.likeDatabase;

  /// 추가
  Future insert(LikeModel likeModel) async {
    await _likeFolder.add(await _db, likeModel.toMap());
  }

  /// 조회 - bool
  Future<bool> isLike(String boardKey, String jwt, String createTime) async {

    final finder = Finder(filter: Filter.and([
      Filter.equals('boardKey', boardKey),
      Filter.equals('jwt', jwt),
    ]));

    final recordSnapshot = await _likeFolder.findFirst(await _db, finder: finder);

    // Parse createTime as DateTime
    DateTime createTimeDateTime = DateTime.parse(createTime);

    // timestamp보다 createTime이 더 최신이면 데이터가 초기화되었다고 판단 로컬데이터 삭제 후 false 반환
    if (recordSnapshot != null) {
      DateTime timestampDateTime = DateTime.parse(recordSnapshot['timestamp'].toString());

      if (timestampDateTime.compareTo(createTimeDateTime) < 0) {
        await delete(boardKey, jwt).then((value){
          print("좋아요 데이터 삭제");
        });
        return false;
      }
      return true;
    }

    return false;
  }


  /// 삭제
  Future delete(String boardKey, String jwt) async {
    final finder = Finder(filter: Filter.and([
      Filter.equals('boardKey', boardKey),
      Filter.equals('jwt', jwt),
    ]));
    await _likeFolder.delete(await _db, finder: finder);
  }

  /// 전체 삭제
  Future deleteAll() async {
    await _likeFolder.delete(await _db);
  }

}