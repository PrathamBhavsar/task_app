import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'task_app.db');
    return await openDatabase(
      path,
      version: 9,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE users (
          id TEXT PRIMARY KEY, 
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
          id TEXT PRIMARY KEY, 
          created_at TEXT NOT NULL, 
          code INTEGER, 
          name TEXT, 
          firm_name TEXT, 
          contact_no TEXT, 
          address TEXT,  
          profile_bg_color TEXT
        )
        ''');

        await db.execute('''
        CREATE TABLE clients (
          id TEXT PRIMARY KEY, 
          created_at TEXT NOT NULL, 
          name TEXT, 
          contact_no TEXT, 
          address TEXT
        )
        ''');

        await db.execute('''
        CREATE TABLE status (
          task_order TEXT PRIMARY KEY, 
          created_at TEXT NOT NULL, 
          name TEXT, 
          slug TEXT, 
          color TEXT,
          category TEXT
        )
        ''');
      },
    );
  }

  /// Insert or update a single record in the table
  Future<void> insertOrUpdate(String table, Map<String, dynamic> data) async {
    final db = await database;
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Store a list of records in the table
  Future<void> storeAllData(
      String table, List<Map<String, dynamic>> dataList) async {
    final db = await database;
    Batch batch = db.batch();
    for (var data in dataList) {
      batch.insert(
        table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  /// Get all records from the table
  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await database;
    return await db.query(table);
  }

  /// Delete all records from the specified table
  Future<void> deleteAll(String table) async {
    final db = await database;
    await db.delete(table);
  }
}
