import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import './models/tasks.dart';
import '../screens/completed_screen.dart';
import '../screens/home_screen.dart';
import '../screens/incomplete_screen.dart';
import '../widgets/create_task_modal.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksModel(),
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RootScreen(),
      ),
    );
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  static const _screenOptions = [
    HomeScreen(),
    CompletedScreen(),
    IncompleteScreen(),
  ];

  @override
  void initState() {
    super.initState();
    final tasks = context.read<TasksModel>();
    tasks.fetchItems();
    // WidgetsBinding.instance!.addPostFrameCallback(
    //   (_) async {
    //     await deleteDatabase(
    //         path.join(await getDatabasesPath(), 'todoapp_database.db'));
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: IndexedStack(
      //   index: _currentIndex,
      //   children: const [
      //     HomeScreen(),
      //     CompletedScreen(),
      //     IncompleteScreen(),
      //   ],
      // ),
      // resizeToAvoidBottomInset: false,

      body: _screenOptions.elementAt(_currentIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            isScrollControlled: true,
            context: context,
            builder: (ctx) {
              return SizedBox(
                height: 56 * 4 + MediaQuery.of(context).viewInsets.bottom,
                child: const CreateTaskModal(),
              );
            },
          );
        },
        tooltip: 'Create new task',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Incomplete',
          ),
        ],
      ),
    );
  }
}
