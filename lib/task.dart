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
  Task({
    required this.taskName,
    required this.finished,
    required this.skipped,
    required this.taskId,
    required this.taskListID,
    this.parentTaskID,
    this.deadlineDate,
    this.deadlineTime,
  });
  String taskId;
  String taskListID;
  String? parentTaskID; //used for repeated task instances only
  String taskName;
  DateTime? deadlineDate;
  DateTime? deadlineTime;
  bool finished;
  bool skipped;
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
  String taskListID;
  String repeatingTaskId;
  String repeatingTaskName;
  RepeatCycle repeatCycle;
  RepeatFrequency? repeatFrequency;
  DateTime deadlineDate;
  DateTime? deadlineTime;
}

class TaskList {
  String taskListID;
  String taskListName;
  List<Task> nonRepeatingTasks;
  List<RepeatingTask> repeatingTasks;
  List<Task> repeatingTaskInstances = [];
  TaskList({
    required this.nonRepeatingTasks,
    required this.repeatingTasks,
    required this.repeatingTaskInstances,
    required this.taskListID,
    required this.taskListName,
  });
}
