import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:watch_queue/res/database/dbmodel.dart';

class DBHandler {
  static final DBHandler _instance = DBHandler._internal();
  factory DBHandler() => _instance;

  static Database? _database;

  DBHandler._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'db_todo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos(
        id TEXT PRIMARY KEY,
        name TEXT,
        img TEXT,
        release_date TEXT,
        listed_date TEXT,
        watch_status INTEGER
      )
    ''');
  }

  Future<int> insert(DbModel dbModel) async {
    final db = await database;
    return await db.insert('todos', dbModel.toMap());
  }

  Future<List<DbModel>> getTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM todos ORDER BY listed_date DESC');

    return List.generate(maps.length, (i) {
      return DbModel.fromMap(maps[i]);
    });
  }

  Future<List<DbModel>> getTodo(String imdbId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM todos WHERE id = ?', [imdbId]);

    return List.generate(maps.length, (i) {
      return DbModel.fromMap(maps[i]);
    });
  }
  Future<bool> isAvailable(String imdbId) async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM todos WHERE id = ?', [imdbId]);
    int? count = Sqflite.firstIntValue(result);
    return count != null && count > 0;
  }


  Future<int> update(DbModel dbModel) async {
    final db = await database;
    return await db.update(
      'todos',
      dbModel.toMap(),
      where: 'id = ?',
      whereArgs: [dbModel.id],
    );
  }

  Future<int> delete(String imdbId) async {
    final db = await database;
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [imdbId],
    );
  }
}
