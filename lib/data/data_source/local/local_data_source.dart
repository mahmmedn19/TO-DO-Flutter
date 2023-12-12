import 'package:untitled/data/modles/task.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalDataSource {
  Future<Database>  initLocalDataBase();
  Future<void> insertTask(TodoItem todoItem);
  Future<void> editTask(TodoItem todoItem);
  deleteTask(todoItemId);
  Future<List<TodoItem>> getTask();
}