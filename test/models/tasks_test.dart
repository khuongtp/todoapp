import 'package:flutter_test/flutter_test.dart';
import 'package:tododapp/models/tasks.dart';

void main() {
  test(
    'Item list length should increase by 1 after adding a new task',
    () {
      final tasks = TasksModel();
      final currentLength = tasks.items.length;
      tasks.add('test task');
      expect(tasks.items.length, currentLength + 1);
    },
  );

  test(
    'Task status should be updated',
    () {
      final tasks = TasksModel();
      tasks.add('test task');
      final task = tasks.items[0];
      tasks.updateStatus(task.id, 1);
      expect(task.isCompleted, 1);
      tasks.updateStatus(task.id, 0);
      expect(task.isCompleted, 0);
    },
  );
}
