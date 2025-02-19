import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../data/models/dashboard_detail.dart';
import '../../data/models/task.dart';
import '../../utils/constants/local_db.dart';

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
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE ${LocalDbKeys.currentUserTable} (
          id TEXT PRIMARY KEY, 
          created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, 
          name TEXT NOT NULL, 
          email TEXT NOT NULL, 
          password TEXT NOT NULL, 
          role TEXT CHECK(role IN ('admin', 'salesperson', 'agency')) NOT NULL DEFAULT 'salesperson', 
          profile_bg_color TEXT NOT NULL, 
          api_token TEXT UNIQUE
        )
        ''');

        await db.execute('''
        CREATE TABLE ${LocalDbKeys.userTable} (
          id TEXT PRIMARY KEY, 
          created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, 
          name TEXT NOT NULL, 
          email TEXT NOT NULL, 
          password TEXT NOT NULL, 
          role TEXT CHECK(role IN ('admin', 'salesperson', 'agency')) NOT NULL DEFAULT 'salesperson', 
          profile_bg_color TEXT NOT NULL, 
          api_token TEXT UNIQUE
        )
        ''');

        await db.execute('''
        CREATE TABLE ${LocalDbKeys.designerTable} (
          id TEXT PRIMARY KEY, 
          created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, 
          code INTEGER, 
          name TEXT, 
          firm_name TEXT, 
          contact_no TEXT, 
          address TEXT,  
          profile_bg_color TEXT
        )
        ''');

        await db.execute('''
        CREATE TABLE ${LocalDbKeys.clientTable} (
          id TEXT PRIMARY KEY, 
          created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, 
          name TEXT, 
          contact_no TEXT, 
          address TEXT
        )
        ''');

        await db.execute('''
        CREATE TABLE ${LocalDbKeys.statusTable} (
          task_order BIGINT PRIMARY KEY, 
          created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, 
          name TEXT, 
          slug TEXT, 
          color TEXT,
          category TEXT
        )
        ''');

        await db.execute('''
        CREATE TABLE ${LocalDbKeys.priorityTable} (
          name TEXT PRIMARY KEY, 
          created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,  
          color TEXT
        )
        ''');

        await db.execute('''
        CREATE TABLE ${LocalDbKeys.taskTable} (
          id TEXT PRIMARY KEY, 
          deal_no TEXT UNIQUE NOT NULL, 
          name TEXT, 
          created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, 
          start_date TEXT DEFAULT CURRENT_TIMESTAMP, 
          due_date TEXT DEFAULT CURRENT_TIMESTAMP, 
          priority TEXT NOT NULL, 
          created_by TEXT, 
          remarks TEXT, 
          status TEXT NOT NULL, 
          FOREIGN KEY (priority) REFERENCES ${LocalDbKeys.priorityTable}(name), 
          FOREIGN KEY (created_by) REFERENCES ${LocalDbKeys.userTable}(id), 
          FOREIGN KEY (status) REFERENCES ${LocalDbKeys.statusTable}(name)
        )
        ''');

        await db.execute('''
        CREATE TABLE ${LocalDbKeys.taskAgencyTable} (
          user_id TEXT NOT NULL, 
          task_id TEXT NOT NULL, 
          created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, 
          PRIMARY KEY (user_id, task_id),
          FOREIGN KEY (user_id) REFERENCES ${LocalDbKeys.userTable}(id) ON DELETE CASCADE,
          FOREIGN KEY (task_id) REFERENCES ${LocalDbKeys.taskTable}(id) ON DELETE CASCADE
        )
        ''');

        await db.execute('''
        CREATE TABLE ${LocalDbKeys.taskSalesTable} (
          user_id TEXT NOT NULL, 
          task_id TEXT NOT NULL, 
          created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, 
          PRIMARY KEY (user_id, task_id),
          FOREIGN KEY (user_id) REFERENCES ${LocalDbKeys.userTable}(id) ON DELETE CASCADE,
          FOREIGN KEY (task_id) REFERENCES ${LocalDbKeys.taskTable}(id) ON DELETE CASCADE
        )
        ''');

        await db.execute('''
        CREATE TABLE ${LocalDbKeys.taskDesignerTable} (
          designer_id TEXT NOT NULL, 
          task_id TEXT NOT NULL, 
          created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, 
          PRIMARY KEY (designer_id, task_id),
          FOREIGN KEY (designer_id) REFERENCES ${LocalDbKeys.designerTable}(id) ON DELETE CASCADE,
          FOREIGN KEY (task_id) REFERENCES ${LocalDbKeys.taskTable}(id) ON DELETE CASCADE
        )
        ''');
      },
    );
  }

  /// Dashboard details
  Future<List<DashboardStatus>> getTaskCountPerStatus() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
        s.name AS status_name, 
        s.color AS color,
        COUNT(t.id) AS task_count
    FROM ${LocalDbKeys.statusTable} s
    LEFT JOIN ${LocalDbKeys.taskTable} t 
        ON s.name = t.status
    GROUP BY s.name;
        ''');

    return result.map(DashboardStatus.fromJson).toList();
  }

  /// Gets single task by id
  Future<Task?> getTaskById(String id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT * FROM tasks WHERE id = '$id';
        ''');
    return Task.fromJson(result.first);
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
