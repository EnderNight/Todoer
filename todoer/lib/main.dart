import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoer/data/database.dart';

import 'package:todoer/widgets/todo_item_widget.dart';
import 'package:todoer/widgets/todo_text_input.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todoBox');

  runApp(const TodoerApp());
}

class TodoerApp extends StatelessWidget {
  const TodoerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todoer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database db = Database();
  final _todoTextController = TextEditingController();

  void createTodo(String text) {
    setState(() {
      db.addItem(text);
      _todoTextController.clear();
    });
  }

  void removeTodo(int index) {
    setState(() {
      db.removeItem(index);
    });
  }

  void toggleTodo(int index) {
    setState(() {
      db.toggleItem(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todoer')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: db.items.length,
                    itemBuilder: (context, index) {
                      return TodoItemWidget(
                        text: db.items[index][0],
                        isDone: db.items[index][1],
                        onDeletePress: () => removeTodo(index),
                        onTap: () => toggleTodo(index),
                      );
                    }),
              ),
              TodoTextInput(
                todoTextController: _todoTextController,
                onSubmit: createTodo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
