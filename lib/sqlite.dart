import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'task.dart';

class SqliteDB {
  SqliteDB.internal();
  static Database? _db;
  static Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  /// Initialize DB
  static initDb() async {
    String folderPath = await getDatabasesPath();
    String path = join(folderPath, "todo.db");
    //await deleteDatabase(path);
    var taskDb = await openDatabase(
      path,
      version: 3,
      onCreate: (Database db, int t) async {
        /*await db.execute(
            'CREATE TABLE LIST (listID INTEGER PRIMARY KEY, listName TEXT, isActive INTEGER)');*/
        await db.execute(
            'CREATE TABLE TASK (taskID INTEGER PRIMARY KEY, taskListID INTEGER, parentTaskID INTEGER, taskName TEXT, deadlineDate INTEGER, deadlineTime INTEGER, isFinished INTEGER, isRepeating INTEGER, )');

        //await db.insert("LIST", {"listName": "Default", "isActive": 1});
      },
    );
    _db = taskDb;
    return taskDb;
  }

  /// Count number of tables in DB
  static Future<int?> insertTask(Map<String, dynamic> taskData) async {
    var dbClient = await db;
    int id = await dbClient.insert("TASK", taskData);
    if (id != 0) {
      return (id);
    } else {
      return (null);
    }
  }

  ///returns all taks whose isFinished is false
  static Future<List<Task>> getAllPendingTasks() async {
    var dbClient = await db;
    List<Map<String, dynamic>> taskListFromDB =
        await dbClient.query("TASK", where: "isFinished = ?", whereArgs: [0]);
    List<Task> taskListAsObjects = [];
    for (var map in taskListFromDB) {
      print(map);
      taskListAsObjects.add(Task.fromMap(map));
    }
    /*var taskListInMemory = taskListFromDB.map((t) => Task.fromMap(t)).toList();
    return (taskListInMemory);*/
    return (taskListAsObjects);
  }

  static Future<bool> updateTask(Task task) async {
    var dbClient = await db;
    int changes = await dbClient.update("TASK", task.toMap(),
        where: "taskID = ?", whereArgs: [task.taskID]);
    return (changes > 0);
  }

  static Future<bool> deleteTask(Task task) async {
    var dbClient = await db;
    int changes = await dbClient
        .delete("TASK", where: "taskID = ?", whereArgs: [task.taskID]);
    return (changes == 1);
  }
}
