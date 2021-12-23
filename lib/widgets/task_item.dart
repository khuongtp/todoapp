import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tasks.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({Key? key, required this.item, this.keepAlive = false})
      : super(key: key);

  final Task item;
  final bool keepAlive;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    bool isChecked = widget.item.isCompleted == 1;
    // print('task item build');

    return Card(
      child: StatefulBuilder(builder: (context, setState) {
        return CheckboxListTile(
          title: Text(
            widget.item.title,
            style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null,
            ),
          ),
          value: isChecked,
          onChanged: (value) async {
            var tasks = context.read<TasksModel>();
            await tasks.updateStatus(widget.item.id, value! ? 1 : 0);
            setState(() {
              isChecked = value;
            });
          },
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
