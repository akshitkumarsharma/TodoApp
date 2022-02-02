import 'package:flutter/cupertino.dart';
import 'package:todo_app/task.dart';
import 'sqlite.dart';

class SharedData extends ChangeNotifier {
  int x = 1, y = 1;
  SharedData();
  incrementX() {
    x = x + 1;
    notifyListeners();
  }
}

class TodosData extends ChangeNotifier {
  bool isDataLoaded = false;
  List<Task> activeTaskList = [];
  TodosData() {
    initTodosData();
  }
  void initTodosData() async {
    await Future.delayed(Duration(seconds: 5));
    activeTaskList = await SqliteDB.getAllPendingTasks();
    isDataLoaded = true;
    notifyListeners();
  }

  void addTask(Task task) async {
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
}
