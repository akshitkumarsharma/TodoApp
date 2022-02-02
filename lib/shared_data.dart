import 'package:flutter/cupertino.dart';
import 'package:todo_app/task.dart';
import 'sqlite.dart';

class TodosData extends ChangeNotifier {
  bool isDataLoaded = false;
  List<Task> activeTaskList = [];
  TodosData() {
    initTodosData();
  }
  Future<void> initTodosData() async {
    activeTaskList = await SqliteDB.getAllPendingTasks();
    isDataLoaded = true;
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    var taskAsMap = task.toMap();
    taskAsMap.remove("taskID");
    int? id = await SqliteDB.insertTask(taskAsMap);
    if (id == null) {
      print("could not insert into database");
    } else {
      task.taskID = id;
      activeTaskList.add(task);
      notifyListeners();
    }
  }

  Future<void> updateTask(Task task) async {
    bool success = await SqliteDB.updateTask(task);
    if (success == false) {
      print("could not update the task");
    } else {
      var index =
          activeTaskList.indexWhere((element) => element.taskID == task.taskID);
      activeTaskList[index] = task;
      notifyListeners();
    }
  }

  Future<void> deleteTask(Task task) async {
    bool success = await SqliteDB.deleteTask(task);
    if (success == false) {
      print("could not delete the task");
    } else {
      var index =
          activeTaskList.indexWhere((element) => element.taskID == task.taskID);
      activeTaskList.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> finishTask(Task task) async {
    task.isFinished = true;
    bool success = await SqliteDB.updateTask(task);
    if (success == false) {
      print("could not mark the task as finished");
    } else {
      var index =
          activeTaskList.indexWhere((element) => element.taskID == task.taskID);
      activeTaskList.removeAt(index);
      notifyListeners();
    }
  }
}
