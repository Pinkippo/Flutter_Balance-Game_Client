import 'package:sembast/sembast.dart';
import 'app_database.dart';


class LikeDao{

  static const String folderName = "like";

  final _chatFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.chatDatabase;

  // Future insert(LikeModel likeModel) async {
  //   await _chatFolder.add(await _db, likeMessage.toMap());
  // }

}