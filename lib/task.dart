import 'package:flutter/material.dart';

enum RepeatCycle {
  onceADay,
  onceADayMonFri,
  onceAWeek,
  onceAMonth,
  onceAYear,
  other,
}

String repeatCycleToUIString(RepeatCycle r) {
  Map<RepeatCycle, String> mapper = {
    RepeatCycle.onceADay: "Once A Day",
    RepeatCycle.onceADayMonFri: "Once A Day( Mon-Fri )",
    RepeatCycle.onceAWeek: "Once A Week",
    RepeatCycle.onceAMonth: "Once A Month",
    RepeatCycle.onceAYear: "Once A Year",
    RepeatCycle.other: "Other...",
  };
  return (mapper[r]!);
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
    required this.taskListID,
    required this.taskId,
    this.parentTaskID,
    this.deadlineDate,
    this.deadlineTime,
  });

  late int taskId;
  int taskListID;
  int? parentTaskID; //used for repeated task instances only
  String taskName;
  DateTime? deadlineDate;
  TimeOfDay? deadlineTime;
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

  /*void addTask({
    required String taskName,
    DateTime? deadlineDate,
    TimeOfDay? deadlineTime,
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
  }*/

  void finishTask(Task task) {}
}
