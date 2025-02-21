import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../data/models/client.dart';
import '../../data/models/dashboard_detail.dart';
import '../../data/models/priority.dart';
import '../../data/models/status.dart';
import '../../data/models/task.dart';
import '../../data/models/taskWithDetails.dart';
import '../../data/models/taskWithUser.dart';
import '../../data/models/user.dart';
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
      sp.name AS salesperson_name, 
      sp.profile_bg_color AS salesperson_profile_bg_color, 
      ag.name AS agency_name, 
      ag.profile_bg_color AS agency_profile_bg_color
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

  /// Task with details
  Future<TaskWithDetails?> getTaskWithDetails(String taskId) async {
    final db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
      t.id AS id,
      t.deal_no, 
      t.name AS task_name,
      t.created_at, 
      t.start_date, 
      t.due_date, 
      t.remarks, 
  
      -- Status Details
      s.task_order AS status_order,
      s.name AS status_name, 
      s.slug AS status_slug, 
      s.color AS status_color, 
      s.category AS status_category, 
      s.created_at AS status_created_at,
  
      -- Priority Details
      p.name AS priority_name,
      p.color AS priority_color,
      p.created_at AS priority_created_at,
  
      -- Salesperson Details
      sp.id AS salesperson_id,
      sp.name AS salesperson_name,
      sp.email AS salesperson_email,
      sp.role AS salesperson_role,
      sp.profile_bg_color AS salesperson_profile_bg_color,
      sp.api_token AS salesperson_api_token,
      sp.created_at AS salesperson_created_at,
  
      -- Agency Details
      ag.id AS agency_id,
      ag.name AS agency_name,
      ag.email AS agency_email,
      ag.role AS agency_role,
      ag.profile_bg_color AS agency_profile_bg_color,
      ag.api_token AS agency_api_token,
      ag.created_at AS agency_created_at,
  
      -- Client Details
      c.id AS client_id,
      c.name AS client_name,
      c.contact_no AS client_contact_no,
      c.address AS client_address,
      c.created_at AS client_created_at,  -- **Added comma here**
  
      -- Designer Details
      d.id AS designer_id,
      d.code AS designer_code,
      d.name AS designer_name,
      d.firm_name AS designer_firm_name,
      d.contact_no AS designer_contact_no,
      d.profile_bg_color AS designer_profile_bg_color,
      d.address AS designer_address,
      d.created_at AS designer_created_at
  
  FROM ${LocalDbKeys.taskTable} t
  
  -- Join status table
  LEFT JOIN ${LocalDbKeys.statusTable} s ON t.status = s.name
  
  -- Join priority table
  LEFT JOIN ${LocalDbKeys.priorityTable} p ON t.priority = p.name
  
  -- Join users for salesperson
  LEFT JOIN ${LocalDbKeys.userTable} sp ON t.salesperson_id = sp.id
  
  -- Join users for agency
  LEFT JOIN ${LocalDbKeys.userTable} ag ON t.agency_id = ag.id
  
  -- Join clients
  LEFT JOIN ${LocalDbKeys.clientTable} c ON t.client_id = c.id  
  
  -- Join designers
  LEFT JOIN ${LocalDbKeys.designerTable} d ON t.designer_id = d.id
  
  WHERE t.id = ?;

  ''', [taskId]);

    if (result.isNotEmpty) {
      final taskData = result.first;

      // Convert result into a JSON-structured map
      final Map<String, dynamic> jsonData = {
        'id': taskData['id'],
        'deal_no': taskData['deal_no'],
        'name': taskData['task_name'],
        'created_at': taskData['created_at'],
        'start_date': taskData['start_date'],
        'due_date': taskData['due_date'],
        'remarks': taskData['remarks'],
        'status': {
          'task_order': taskData['status_order'],
          'name': taskData['status_name'],
          'slug': taskData['status_slug'],
          'color': taskData['status_color'],
          'category': taskData['status_category'],
          'created_at': taskData['status_created_at'],
        },
        'priority': {
          'name': taskData['priority_name'],
          'color': taskData['priority_color'],
          'created_at': taskData['priority_created_at'],
        },
        'salesperson': {
          'id': taskData['salesperson_id'],
          'name': taskData['salesperson_name'],
          'email': taskData['salesperson_email'],
          'role': taskData['salesperson_role'],
          'profile_bg_color': taskData['salesperson_profile_bg_color'],
          'api_token': taskData['salesperson_api_token'],
          'created_at': taskData['salesperson_created_at'],
        },
        'agency': {
          'id': taskData['agency_id'],
          'name': taskData['agency_name'],
          'email': taskData['agency_email'],
          'role': taskData['agency_role'],
          'profile_bg_color': taskData['agency_profile_bg_color'],
          'api_token': taskData['agency_api_token'],
          'created_at': taskData['agency_created_at'],
        },
        'client': {
          'id': taskData['client_id'],
          'name': taskData['client_name'],
          'contact_no': taskData['client_contact_no'],
          'address': taskData['client_address'],
          'created_at': taskData['client_created_at'],
        },
        'designer': {
          'id': taskData['designer_id'],
          'code': taskData['designer_code'],
          'name': taskData['designer_name'],
          'firm_name': taskData['designer_firm_name'],
          'profile_bg_color': taskData['designer_profile_bg_color'],
          'contact_no': taskData['designer_contact_no'],
          'address': taskData['designer_address'],
          'created_at': taskData['designer_created_at'],
        },
      };
      print(jsonData);
      // Now we can use the `fromJson` method
      return TaskWithDetails.fromJson(jsonData);
    }

    return null;
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
