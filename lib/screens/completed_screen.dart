import 'package:flutter/material.dart';
import 'package:nil/nil.dart';
import 'package:provider/provider.dart';

import '../models/tasks.dart';
import '../widgets/task_item.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskListLength =
        context.select<TasksModel, int>((tasks) => tasks.items.length);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
      ),
      body: ListView.builder(
        /// Preserve scroll state
        key: const PageStorageKey(1),
        padding: const EdgeInsets.only(bottom: 80),
        itemBuilder: (context, index) {
          return Builder(
            builder: (context) {
              /// item will never change
              final item = context.select<TasksModel, Task>((tasks) {
                return tasks.items[taskListLength - index - 1];
              });

              /// Watch for task status to return nothing if it's not completed
              final isCompleted = context.select<TasksModel, bool>((tasks) =>
                  tasks.items[taskListLength - index - 1].isCompleted == 1);
              if (!isCompleted) return nil;
              return TaskItem(
                item: item,
                keepAlive: true,
              );
            },
          );
        },
        itemCount: taskListLength,
      ),
    );
  }
}
