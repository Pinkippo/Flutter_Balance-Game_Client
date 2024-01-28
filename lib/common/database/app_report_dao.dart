import 'package:sembast/sembast.dart';
import 'app_database.dart';

/// 신고 저장을 위한 DAO
class ReportDao{


  static const String folderName = "report";

  final _reportFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.reportDatabase;

  /// 추가 -> boardKey, commentKey == 글일경우 0 / 댓글일 경우 commentKey, uid, timestamp
  Future insert(String boardKey, String commentKey, String uid, String timestamp) async {
    await _reportFolder.add(await _db, {
      'boardKey': boardKey,
      'commentKey': commentKey,
      'uid': uid,
      'timestamp': timestamp,
    });
  }

  /// 조회 - bool
  Future<bool> isAlreadyReport(String boardKey, String commentKey, String uid) async {
    final finder = Finder(filter: Filter.and([
      Filter.equals('boardKey', boardKey),
      Filter.equals('commentKey', commentKey),
      Filter.equals('uid', uid),
    ]));

    final recordSnapshot = await _reportFolder.findFirst(await _db, finder: finder);

    if (recordSnapshot != null) {
      return true;
    }

    return false;
  }

  /// 전체 삭제
  Future deleteAll() async {
    await _reportFolder.delete(await _db);
  }

}