import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tasks.dart';

class CreateTaskModal extends StatefulWidget {
  const CreateTaskModal({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  late final TextEditingController _controller;

  void _saveTask() {
    if (_controller.text.isEmpty) return;
    var tasks = context.read<TasksModel>();
    tasks.add(_controller.text);
    _controller.clear();
    const snackBar = SnackBar(
      duration: Duration(milliseconds: 1000),
      content: Text('New Task Added Successfully!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 56,
              alignment: Alignment.centerLeft,
              child: Text(
                'Create new task',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Task title'),
              onSubmitted: (value) {
                Navigator.of(context).pop();
                _saveTask();
              },
            ),
            const SizedBox(height: 56 - 48),
            SizedBox(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('CANCEL'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    child: const Text('SAVE'),
                    onPressed: _controller.text.isEmpty ? null : _saveTask,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SaveButton extends StatefulWidget {
  const SaveButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback? onPressed;

  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('SAVE'),
      onPressed: widget.onPressed,
    );
  }
}
