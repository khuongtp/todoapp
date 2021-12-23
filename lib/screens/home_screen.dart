import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tododapp/widgets/task_item.dart';

import '../models/tasks.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskListLength =
        context.select<TasksModel, int>((tasks) => tasks.items.length);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tasks'),
      ),
      body: ListView.builder(
        /// Preserve scroll state
        key: const PageStorageKey(0),
        padding: const EdgeInsets.only(bottom: 80),
        itemBuilder: (context, index) {
          return Builder(
            builder: (context) {
              /// item will never change
              final item = context.select<TasksModel, Task>((tasks) {
                return tasks.items[taskListLength - index - 1];
              });

              /// Don't keep item alive to avoid unnecessary rebuilding when add new task
              return TaskItem(
                item: item,
                keepAlive: false,
              );
            },
          );
        },
        itemCount: taskListLength,
      ),
    );
  }
}
