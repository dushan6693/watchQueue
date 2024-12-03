import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:watch_queue/res/database/todos_model.dart';
import 'package:watch_queue/res/database/version_model.dart';

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
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create the `todos` table
    await db.execute('''
    CREATE TABLE todos(
      count INTEGER PRIMARY KEY AUTOINCREMENT,
      id TEXT,
      type TEXT,
      name TEXT,
      img TEXT,
      release_date TEXT,
      listed_date TEXT,
      watch_status INTEGER
    )
  ''');
    // Create the `version` table
    await db.execute('''
    CREATE TABLE version(
      id TEXT PRIMARY KEY,
      version_code INTEGER DEFAULT '1'
    )
  ''');
    _insertVersionDefault(VersionModel(
        id: 'version_id01',
        versionCode: 1)); //set default value to version table
  }

  //insert
  Future<int> insertTodo(TodosModel todosModel) async {
    final db = await database;
    incrementVersion('version_id01');
    return await db.insert('todos', todosModel.toMap());
  }

  Future<int> insertVersion(VersionModel versionModel) async {
    final db = await database;
    return await db.insert('version', versionModel.toMap());
  }


  Future<int> _insertVersionDefault(VersionModel versionModel) async {
    final db = await database;
    return await db.insert('version', versionModel.toMap());
  }

//get
  Future<List<TodosModel>> getTodo(String imdbId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM todos WHERE id = ?', [imdbId]);

    return List.generate(maps.length, (i) {
      return TodosModel.fromMap(maps[i]);
    });
  }

  Future<List<TodosModel>> getTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM todos ORDER BY count DESC');

    return List.generate(maps.length, (i) {
      return TodosModel.fromMap(maps[i]);
    });
  }

  Future<List<TodosModel>> getTodosLike(String filter) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .rawQuery('SELECT * FROM todos WHERE name LIKE ?', ['$filter%']);

    return List.generate(maps.length, (i) {
      return TodosModel.fromMap(maps[i]);
    });
  }

  Future<VersionModel> getVersion(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM version WHERE id = ?', [id]);
      return VersionModel.fromMap(maps[0]);

  }

  Future<int> getTodosCount() async {
    final db = await database;
    final result = await db.query('movies');
    return result.length;
  }

//update
  Future<int> updateTodo(TodosModel todosModel) async {
    final db = await database;
    incrementVersion('version_id01');
    return await db.update(
      'todos',
      todosModel.toMap(),
      where: 'id = ?',
      whereArgs: [todosModel.id],
    );
  }

  Future<int> updateVersion(VersionModel versionModel) async {
    final db = await database;
    return await db.update(
      'version',
      versionModel.toMap(),
      where: 'id = ?',
      whereArgs: [versionModel.id],
    );
  }

  Future<int> updateWatchStatus(int status, String id) async {
    final db = await database;
    incrementVersion('version_id01');
    return await db.rawUpdate(
        'UPDATE todos SET watch_status = ? WHERE id= ?', [status, id]);
  }

  //delete
  Future<int> deleteTodo(String imdbId) async {
    final db = await database;
    incrementVersion('version_id01');
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [imdbId],
    );
  }
  //increment. increment version_code on Version table by 1. to update the database status.
  Future<int> incrementVersion(String versionId) async {
    final db = await database;
    VersionModel resentVersion = await getVersion(versionId);
    resentVersion.versionCode+=1;
    return await db.update('version', resentVersion.toMap());
  }
//isAvailable
  Future<bool> isAvailable(String imdbId) async {
    final db = await database;
    final result =
        await db.rawQuery('SELECT COUNT(*) FROM todos WHERE id = ?', [imdbId]);
    int? count = Sqflite.firstIntValue(result);
    return count != null && count > 0;
  }

  Future<bool> isAvailableAll() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM todos');
    int? count = Sqflite.firstIntValue(result);
    return count != null && count > 0;
  }
}
