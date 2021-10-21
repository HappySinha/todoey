import 'dart:collection';

import 'package:flutter/foundation.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'This is not a task', isDone: false),
    Task(name: 'This is a task', isDone: false),
    Task(name: 'This is not a task', isDone: false),
    Task(name: 'This is not a task', isDone: false),
    Task(name: 'This is not a task', isDone: false),
  ];

  int get taskCount {
    return _tasks.length;
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void addTask(String addTaskText) {
    final task = Task(name: addTaskText, isDone: false);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}

class Task {
  final String name;
  bool isDone;
  Task({required this.name, required this.isDone});
  void toggleDone() {
    isDone = !isDone;
  }
}
