import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../constants/local_db.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'task_app.db');
    return await openDatabase(
      path,
      version: 4,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE users (
          id BLOB PRIMARY KEY, 
          created_at TEXT NOT NULL, 
          name TEXT, 
          email TEXT, 
          password TEXT, 
          role TEXT CHECK(role IN ('admin', 'salesperson', 'agency')), 
          profile_bg_color TEXT
        )
          ''');
      },
    );
  }

  Future<void> insertOrUpdateUser(Map<String, dynamic> customer) async {
    final db = await database;
    await db.insert(
      LocalDbKeys.usersTable,
      customer,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query(LocalDbKeys.usersTable);
  }

  Future<void> deleteAllUsers() async {
    final db = await database;
    await db.delete(LocalDbKeys.usersTable);
  }
}
