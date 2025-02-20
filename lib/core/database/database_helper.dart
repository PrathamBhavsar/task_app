import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../data/models/dashboard_detail.dart';
import '../../data/models/task.dart';
import '../../data/models/taskWithUser.dart';
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
        salesperson_id TEXT,  -- Define salesperson_id
        agency_id TEXT,       -- Define agency_id
        designer_id TEXT,     -- Define designer_id
        client_id TEXT,       -- Define client_id
        remarks TEXT, 
        status TEXT NOT NULL, 
        FOREIGN KEY (priority) REFERENCES ${LocalDbKeys.priorityTable}(name), 
        FOREIGN KEY (created_by) REFERENCES ${LocalDbKeys.userTable}(id), 
        FOREIGN KEY (status) REFERENCES ${LocalDbKeys.statusTable}(name),
        FOREIGN KEY (salesperson_id) REFERENCES ${LocalDbKeys.userTable}(id),
        FOREIGN KEY (agency_id) REFERENCES ${LocalDbKeys.userTable}(id),
        FOREIGN KEY (designer_id) REFERENCES ${LocalDbKeys.designerTable}(id),
        FOREIGN KEY (client_id) REFERENCES ${LocalDbKeys.clientTable}(id)
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

  /// Gets task overall
  Future<List<TaskWithUsers>> getTaskOverall() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
    t.id AS task_id,
    t.name AS task_name, 
    t.due_date, 
    s.name AS status_name, 
    s.color AS status_color, 
    p.name AS priority_name, 
    p.color AS priority_color, 
        COALESCE(sp.name, '') || ', ' || COALESCE(ag.name, '') AS user_names, 
        COALESCE(sp.profile_bg_color, '') || ', ' || COALESCE(ag.profile_bg_color, '') AS user_profile_bg_colors
      FROM ${LocalDbKeys.taskTable} t
      -- Join users for salesperson
      LEFT JOIN ${LocalDbKeys.userTable} sp ON t.salesperson_id = sp.id
      -- Join users for agency
      LEFT JOIN ${LocalDbKeys.userTable} ag ON t.agency_id = ag.id
      -- Join status table
      LEFT JOIN ${LocalDbKeys.statusTable} s ON t.status = s.name
      -- Join priority table
      LEFT JOIN ${LocalDbKeys.priorityTable} p ON t.priority = p.name
      ORDER BY t.name;
  ''');
    return result.map(TaskWithUsers.fromJson).toList();
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
