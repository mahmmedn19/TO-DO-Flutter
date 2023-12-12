import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/data/data_source/local/local_data_source.dart';
import 'package:untitled/data/modles/task.dart';

import '../components/add_dialog.dart';
import '../components/dialog_confrim.dart';
import '../data/data_source/local/local_data_source_imp.dart';
import '../utils/app_assets.dart';
import '../utils/notification_service.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoScreen> {
  List<TodoItem> _todoList = [];
  bool _loading = true;
  final LocalDataSource _dataSource = LocalDataSourceImp();

  _bind() async {
    await _dataSource.initLocalDataBase();
    _todoList = await _dataSource.getTask();
    _loading = false;
    setState(() {});
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
            child: Text(
          'MO-Todo  ${_todoList.length}',
          style: const TextStyle(color: Colors.black87),
        )),
      ),
      body: _loading
          ? _loadingBuilder()
          : _todoList.isEmpty
              ? _emptyBuilder()
              : _todoBuilder(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return TaskDialog(
                onPressed: (TodoItem? newTask) {
                  _todoList.add(newTask!);
                  _dataSource.insertTask(newTask);
                  NotificationService().scheduleNotification(
                      id: newTask.id!,
                      title: newTask.title,
                      body: newTask.description,
                      scheduledNotificationDateTime: newTask.date!);
                  _todoList.sort(
                    (a, b) => a.date!.compareTo(b.date!),
                  );
                  setState(() {});
                  Navigator.pop(context);
                },
                task: TodoItem(
                    title: null,
                    date: null,
                    description: null,
                    isCompleted: false),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _loadingBuilder() => Center(child: Lottie.asset(AppAssets.loading));

  _emptyBuilder() => Center(child: Lottie.asset(AppAssets.emptyList));

  _todoBuilder() => ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.black26,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 250.0,
                        child: ListTile(
                          title: Text(
                            _todoList[index].title!,
                            style: const TextStyle(
                                color: Colors.blueAccent, fontSize: 20.0),
                          ),
                          subtitle: Row(
                            children: [
                              Text(DateFormat.yMMMd()
                                  .format(_todoList[index].date!)),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                  '${_todoList[index].date!.hour}:${_todoList[index].date!.minute}')
                            ],
                          ),
                          trailing:
                              //----------------------------------------------
                              IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogConfirm(
                                      message: 'Are You Sure  ?',
                                      btnName: 'delete',
                                      onPressed: () {
                                        _dataSource
                                            .deleteTask(_todoList[index].id);
                                        _todoList.removeAt(index);
                                        NotificationService().showNotification(
                                            id: 1,
                                            title: 'Note',
                                            body: 'Item is Deleted');
                                        Navigator.pop(context);
                                        setState(() {});
                                      });
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return TaskDialog(
                                  onPressed: (TodoItem? newTask) {
                                    newTask!.id = _todoList[index].id;
                                    _todoList[index] = newTask;
                                    _dataSource.editTask(_todoList[index]);
                                    NotificationService().scheduleNotification(
                                        id: newTask.id!,
                                        title: newTask.title,
                                        body: newTask.description,
                                        scheduledNotificationDateTime:
                                            newTask.date!);
                                    _todoList.sort(
                                      (a, b) => a.date!.compareTo(b.date!),
                                    );
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  task: _todoList[index],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.edit_square,
                            color: Colors.blue,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _todoList[index].isCompleted,
                        onChanged: (value) {
                          setState(() {
                            _todoList[index].isCompleted = value!;
                            _dataSource.editTask(_todoList[index]);
                            //print(_todoList[index].isChecked);
                          });
                        },
                      ),
                      Text(
                        _todoList[index].description!,
                        style: const TextStyle(
                            color: Colors.blueAccent, fontSize: 20.0),
                      ),
                    ],
                  )
                ],
              ),
            ));
      },
      itemCount: _todoList.length);
}
