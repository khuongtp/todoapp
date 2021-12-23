import 'package:flutter/material.dart';
import 'package:tododapp/helpers/db_helper.dart';

class TasksModel extends ChangeNotifier {
  List<Task> items = [];

  Future<void> fetchItems() async {
    items = await DbHelper.tasks();
    notifyListeners();
  }

  Future<void> add(String title, {bool test = false}) async {
    final task = Task(DateTime.now().millisecondsSinceEpoch, title, 0);
    items.add(task);
    notifyListeners();
    // Since we are not running test on any real device we cannot access the
    // path to database
    if (!test) {
      await DbHelper.insertTask(task);
    }
  }

  Future<void> updateStatus(int id, int isCompleted,
      {bool test = false}) async {
    Task item = items.firstWhere((element) => element.id == id);
    item.isCompleted = isCompleted;
    notifyListeners();
    if (!test) {
      await DbHelper.updateTask(item);
    }
  }
}

class Task {
  final int id;
  final String title;
  int isCompleted; // SQLite does not support bool

  Task(this.id, this.title, this.isCompleted);

  // Convert a Task into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Task{id: $id, title: $title, isCompleted: $isCompleted}';
  }
}
