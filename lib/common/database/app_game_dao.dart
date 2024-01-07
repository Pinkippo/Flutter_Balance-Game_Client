import 'package:flutter_balance_game_client/data/model/local_database/game_model.dart';
import 'package:sembast/sembast.dart';
import 'app_database.dart';

/// 게임 참여 여부 저장을 이넘
enum GameStatus {
  none,
  left,
  right,
}

/// 게임 여부 저장을 위한 DAO
class GameDao{

  static const String folderName = "game";

  final _gameFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.chatDatabase;

  /// 추가
  Future insert(GameModel gameModel) async {
    await _gameFolder.add(await _db, gameModel.toMap());
  }

  /// 조회 - bool
  Future<GameStatus> isAlreadyGame(String boardKey, String jwt, String createTime) async {
    final finder = Finder(filter: Filter.and([
      Filter.equals('boardKey', boardKey),
      Filter.equals('jwt', jwt),
    ]));

    final recordSnapshot = await _gameFolder.findFirst(await _db, finder: finder);

    DateTime createTimeDateTime = DateTime.parse(createTime);

    if (recordSnapshot != null) {
      DateTime timestampDateTime = DateTime.parse(recordSnapshot['timestamp'].toString());

      if (timestampDateTime.compareTo(createTimeDateTime) < 0) {
        await delete(boardKey, jwt).then((value){
          print("게임 데이터 삭제");
        });
        return GameStatus.none;
      }

      if (recordSnapshot['result'] == 'left') {

        return GameStatus.left;

      } else if (recordSnapshot['result'] == 'right') {

        return GameStatus.right;

      }
    }

    return GameStatus.none;
  }


  /// 삭제
  Future delete(String boardKey, String jwt) async {
    final finder = Finder(filter: Filter.and([
      Filter.equals('boardKey', boardKey),
      Filter.equals('jwt', jwt),
    ]));
    await _gameFolder.delete(await _db, finder: finder);
  }

  /// 전체 삭제
  Future deleteAll() async {
    await _gameFolder.delete(await _db);
  }

}