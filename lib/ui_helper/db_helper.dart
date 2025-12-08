import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  final String tableName = "bookmarked";

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), "bookmarked.db");
    print("Database path: $path");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
          thumbnail TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          id INTEGER NOT NULL
  )
        ''');
      },
    );
  }

  Future<int> addBookmark({required String thumbnailUrl, required String name ,  required int? id }) async {
    final db = await database;
    print("Inserted into DB: $name");
    return await db.insert(
      tableName,
      {
        "thumbnail": thumbnailUrl,
        "name": name,
        "id" : id,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<Map<String, dynamic>>> getAllBookmarks() async {
    final db = await database;
    return await db.query(tableName, orderBy: "id DESC");
  }
}
