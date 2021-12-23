import 'package:flutter_test/flutter_test.dart';
import 'package:tododapp/models/tasks.dart';

void main() {
  test(
    'Task list length should increase by 1 after adding a new task',
    () async {
      final tasks = TasksModel();
      final currentLength = tasks.items.length;
      await tasks.add('test task', test: true);
      expect(tasks.items.length, currentLength + 1);
    },
  );

  test(
    'Task status should be updated',
    () async {
      final tasks = TasksModel();
      tasks.add('test task', test: true);
      final task = tasks.items[0];
      await tasks.updateStatus(task.id, 1, test: true);
      expect(task.isCompleted, 1);
      await tasks.updateStatus(task.id, 0, test: true);
      expect(task.isCompleted, 0);
    },
  );
}
