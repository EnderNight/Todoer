import 'package:flutter/material.dart';

import 'package:todoer/widgets/todo_item_widget.dart';
import 'package:todoer/widgets/todo_text_input.dart';

import 'domain/todo_item.dart';

void main() => runApp(const TodoerApp());

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
  final List<TodoItem> _items = [
    TodoItem(text: 'Quoicoubeh', isDone: false),
  ];

  final _todoTextController = TextEditingController();

  void createTodo(String text) {
    setState(() {
      TodoItem newItem = TodoItem(text: text, isDone: false);
      _items.add(newItem);
      _todoTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todoer')),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return TodoItemWidget(todoItem: _items[index]);
                  }),
            ),
            TodoTextInput(
              todoTextController: _todoTextController,
              onSubmit: createTodo,
            ),
          ],
        ),
      ),
    );
  }
}
