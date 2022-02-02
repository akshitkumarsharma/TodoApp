enum RepeatCycle {
  onceADay,
  onceADayMonFri,
  onceAWeek,
  onceAMonth,
  onceAYear,
  other,
}
enum Tenure { days, weeks, months, years }

class RepeatFrequency {
  RepeatFrequency({required this.num, required this.tenure});
  int num;
  Tenure tenure;
}

class Task {
  static late int counter;
  Task({
    required this.taskName,
    required this.finished,
    required this.taskListID,
    taskId = null,
    this.parentTaskID,
    this.deadlineDate,
    this.deadlineTime,
  }) {
    if (taskId == null) {
      this.taskId = counter;
      counter++;
    } else {
      this.taskId = taskId;
    }
  }

  static initializeCounter(int counter) {
    Task.counter = counter;
  }

  late int taskId;
  int taskListID;
  int? parentTaskID; //used for repeated task instances only
  String taskName;
  DateTime? deadlineDate;
  DateTime? deadlineTime;
  bool finished;
  void finishTask() {
    finished = true;
  }
}

class RepeatingTask {
  RepeatingTask({
    required this.repeatingTaskId,
    required this.repeatingTaskName,
    required this.repeatCycle,
    required this.deadlineDate,
    this.repeatFrequency,
    this.deadlineTime,
    required this.taskListID,
  });

  int taskListID;
  int repeatingTaskId;
  String repeatingTaskName;
  RepeatCycle repeatCycle;
  RepeatFrequency? repeatFrequency;
  DateTime deadlineDate;
  DateTime? deadlineTime;
}

class TaskList {
  int taskListID;
  String taskListName;
  List<Task> nonRepeatingTasks;
  List<RepeatingTask> repeatingTasks;
  List<Task> activeRepeatingTaskInstances;

  TaskList({
    required this.nonRepeatingTasks,
    required this.repeatingTasks,
    required this.activeRepeatingTaskInstances,
    required this.taskListID,
    required this.taskListName,
  });
  List<Task> getActiveTasks() {
    //TODO::Select repeating Task Instances as well
    List<Task> activeNonRepeatingTasks = [];
    {
      for (var i = 0; i < nonRepeatingTasks.length; i++) {
        if (nonRepeatingTasks[i].finished == false) {
          activeNonRepeatingTasks.add(nonRepeatingTasks[i]);
        }
      }
      return (activeNonRepeatingTasks);
    }
  }

  List<Task> getFinishedTasks() {
    //repeating Instances as well as non-repeating Instances
    return ([]);
  }

  void FinishTask(Task task) {}

  void addTask({
    required String taskName,
    DateTime? deadlineDate,
    DateTime? deadlineTime,
    int? parentTaskID,
  }) {
    //
    Task(
      taskName: taskName,
      finished: false,
      taskListID: taskListID,
      deadlineDate: deadlineDate,
      deadlineTime: deadlineTime,
      parentTaskID: parentTaskID,
    );

    if (parentTaskID != null) {
      //
    }
  }

  void finishTask(Task task) {}
}
