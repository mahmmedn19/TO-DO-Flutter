import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:untitled/data/modles/task.dart';
import '../../../utils/constants.dart';
import 'local_data_source.dart';

class LocalDataSourceImp implements LocalDataSource {
  Database? database;

  @override
  Future<Database> initLocalDataBase() async {
    if (database != null) return database!;
    database = await openDatabase('${await getDatabasesPath()}/todo.db',
        version: 1, onCreate: _onCreate);
    return database!;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Task (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        subTitle TEXT,
        isChecked BOOLEAN,
        dateTime TEXT
      )
    ''');
  }

  @override
  deleteTask(todoItemId) async {
    await database?.delete(TableDatabase.tTask, where: 'id = $todoItemId');
  }

  @override
  Future<void> editTask(TodoItem todoItem) async {
    await database?.update(
      TableDatabase.tTask, todoItem.toJson(), where: 'id = ?',
      whereArgs: [todoItem.id],);
  }

  @override
  Future<List<TodoItem>> getTask() async {
    return (await database?.query(TableDatabase.tTask, orderBy: 'dateTime'))!
        .map((e) => TodoItem.fromJson(e))
        .toList();
  }

  @override
  Future<void> insertTask(TodoItem todoItem) async {
    await database?.insert(TableDatabase.tTask, todoItem.toJson());
  }

}
