import 'package:flutter/material.dart';
import 'package:untitled/ui/todoScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-DO  Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ToDoScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TodoItem> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
      ),
      body: Column(
        children: [
          _buildTodoList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a To-Do'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addTodoItem(titleController.text, descriptionController.text);
                titleController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTodoList() {
    return Expanded(
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return _buildTodoItem(todos[index]);
        },
      ),
    );
  }

  Widget _buildTodoItem(TodoItem todoItem) {
    return ListTile(
      title: Text(
        todoItem.title,
        style: TextStyle(
          color: todoItem.isCompleted ? Colors.grey : Colors.black,
          decoration: todoItem.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: todoItem.description.isNotEmpty
          ? Text(
              todoItem.description,
              style: TextStyle(
                color: todoItem.isCompleted ? Colors.grey : Colors.black54,
                decoration:
                    todoItem.isCompleted ? TextDecoration.lineThrough : null,
              ),
            )
          : null,
      tileColor: todoItem.isCompleted ? Colors.greenAccent : null,
      onTap: () {
        _toggleTodoCompletion(todoItem);
      },
    );
  }

  void _addTodoItem(String title, String description) {
    if (title.isNotEmpty) {
      setState(() {
        todos.add(TodoItem(title: title, description: description));
      });
    }
  }

  void _toggleTodoCompletion(TodoItem todo) {
    setState(() {
      todo.isCompleted = !todo.isCompleted;
    });
  }
}

class TodoItem {
  final String title;
  final String description;
  bool isCompleted;

  TodoItem(
      {required this.title,
      required this.description,
      this.isCompleted = false});
}
