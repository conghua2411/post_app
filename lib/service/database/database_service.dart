import 'package:post_app/model/post/post_model.dart';
import 'package:post_app/model/user/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseService {
  DatabaseService() {
    print('DatabaseService: constructor');
  }

  Database database;

  Future _createTable(Database db) {
    var listCreateTable = <Future>[];

    listCreateTable.add(db.execute(
        "CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT, username TEXT, email TEXT, address TEXT, phone TEXT, website TEXT, company TEXT)"));
    listCreateTable.add(db.execute(
        "CREATE TABLE post(id INTEGER PRIMARY KEY, userId INTEGER, title TEXT, body TEXT)"));
    listCreateTable.add(db.execute(
        "CREATE TABLE comment(id INTEGER PRIMARY KEY, postId INTEGER, name TEXT, email TEXT, body TEXT)"));

    return Future.wait(listCreateTable);
  }

  setupBd() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'post_database.db'),
      onCreate: (db, version) {
        print('db onCreate: alo1234 -- version: $version');
        return _createTable(db);
      },
      onOpen: (db) {
        print('db onOpen: alo1234');
      },
      onConfigure: (db) {
        print('db onConfigure: alo1234');
      },
      onDowngrade: (db, oldVersion, newVersion) {
        print(
            'db onDowngrade: alo1234 --- oldVersion: $oldVersion : newVersion: $newVersion');
      },
      onUpgrade: (db, newVersion, oldVersion) {
        print(
            'db onUpgrade: alo1234 --- oldVersion: $oldVersion : newVersion: $newVersion');
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> loadAllPost() => database.query('post');

  Future insertPost(PostModel post) => database.insert('post', post.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);

  Future insertListPost(List<PostModel> listPost) =>
      database.transaction((txn) {
        var batch = txn.batch();

        listPost.forEach((post) {
          batch.insert('post', post.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        });

        return batch.commit();
      });

  Future insertUser(UserModel user) => database.insert('user', user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);

  Future<List<Map<String, dynamic>>> getUserById(int id) =>
      database.rawQuery('SELECT * FROM user WHERE id=$id');
}
