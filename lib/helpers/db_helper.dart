import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tododapp/models/tasks.dart';

// Open the database and store the reference.
final database = getDatabasesPath().then(
  (path) {
    return openDatabase(
      join(path, 'todoapp_database.db'),
      // When the database is first created, create a table to store tasks.
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, isCompleted INTEGER)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  },
);

class DbHelper {
  static Future<void> insertTask(Task task) async {
    final db = await database;

    // Insert the Task into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same task is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Task>> tasks() async {
    WidgetsFlutterBinding.ensureInitialized();
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task(
        maps[i]['id'],
        maps[i]['title'],
        maps[i]['isCompleted'],
      );
    });
  }

  static Future<void> updateTask(Task task) async {
    WidgetsFlutterBinding.ensureInitialized();
    final db = await database;

    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // static Future<void> deleteTask(int id) async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final db = await database;

  //   await db.delete(
  //     'tasks',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }
}
