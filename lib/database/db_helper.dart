import 'package:mobil_projem/model/sqflite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  final String tableadiSoyadi = 'tablePersonel';
  final String columnId = 'id';
  final String columnadiSoyadi = 'adiSoyadi';
  final String columntcKimlikNo = 'tcKimlikNo';
  final String columnunvan = 'unvan';
  final String columngorevYeri = 'gorevYeri';

  DbHelper._internal();

  factory DbHelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'personel.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableadiSoyadi($columnId INTEGER PRIMARY KEY, "
        "$columnadiSoyadi TEXT,"
        "$columntcKimlikNo TEXT,"
        "$columnunvan TEXT,"
        "$columngorevYeri TEXT)";
    await db.execute(sql);
  }

  Future<int?> savePersonel(Personel personel) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableadiSoyadi, personel.toMap());
  }

  Future<List?> getAllPersonel() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableadiSoyadi, columns: [
      columnId,
      columnadiSoyadi,
      columngorevYeri,
      columntcKimlikNo,
      columnunvan
    ]);

    return result.toList();
  }

  Future<int?> updatePersonel(Personel personel) async {
    var dbClient = await _db;
    return await dbClient!.update(tableadiSoyadi, personel.toMap(),
        where: '$columnId = ?', whereArgs: [personel.id]);
  }

  Future<int?> deletePersonel(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableadiSoyadi, where: '$columnId = ?', whereArgs: [id]);
  }
}
