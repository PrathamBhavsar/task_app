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
      version: 5,
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

        await db.execute('''
        CREATE TABLE designers (
          id BLOB PRIMARY KEY, 
          created_at TEXT NOT NULL, 
          code BIGINT(20), 
          name TEXT, 
          firm_name TEXT, 
          contact_no TEXT, 
          address TEXT,  
          profile_bg_color TEXT
        )
          ''');
      },
    );
  }

  Future<void> insertOrUpdateUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(
      LocalDbKeys.usersTable,
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertOrUpdateDesigner(Map<String, dynamic> designer) async {
    final db = await database;
    await db.insert(
      LocalDbKeys.designersTable,
      designer,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query(LocalDbKeys.usersTable);
  }

  Future<List<Map<String, dynamic>>> getDesigners() async {
    final db = await database;
    return await db.query(LocalDbKeys.designersTable);
  }

  Future<void> deleteAllUsers() async {
    final db = await database;
    await db.delete(LocalDbKeys.usersTable);
  }

  Future<void> deleteAllDesigners() async {
    final db = await database;
    await db.delete(LocalDbKeys.designersTable);
  }
}
