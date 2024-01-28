import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// 좋아요 저장을 위한 로컬 데이터 베이스 - Sembast Singleton
class AppDatabase {
  static final AppDatabase _singleton = AppDatabase._();

  static AppDatabase get instance => _singleton;

  Completer<Database>? _gameDbOpenCompleter;
  Completer<Database>? _likeDbOpenCompleter;
  Completer<Database>? _reportDbOpenCompleter;

  AppDatabase._();

  Future<Database> get gameDatabase async {
    if (_gameDbOpenCompleter == null) {
      _gameDbOpenCompleter = Completer();
      await _openGameDatabase();
    }
    return _gameDbOpenCompleter!.future;
  }

  Future _openGameDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'game.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);
    _gameDbOpenCompleter!.complete(database);
  }

  Future<Database> get likeDatabase async {
    if (_likeDbOpenCompleter == null) {
      _likeDbOpenCompleter = Completer();
      await _openLikeDatabase();
    }
    return _likeDbOpenCompleter!.future;
  }

  Future _openLikeDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final alarmDbPath = join(appDocumentDir.path, 'like.db');

    final alarmDatabase = await databaseFactoryIo.openDatabase(alarmDbPath);
    _likeDbOpenCompleter!.complete(alarmDatabase);
  }

  Future<Database> get reportDatabase async {
    if (_reportDbOpenCompleter == null) {
      _reportDbOpenCompleter = Completer();
      await _openReportDatabase();
    }
    return _reportDbOpenCompleter!.future;
  }

  Future _openReportDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final alarmDbPath = join(appDocumentDir.path, 'report.db');

    final alarmDatabase = await databaseFactoryIo.openDatabase(alarmDbPath);
    _reportDbOpenCompleter!.complete(alarmDatabase);
  }

}