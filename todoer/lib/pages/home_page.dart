import 'package:flutter/material.dart';
import 'package:todoer/data/database.dart';
import 'package:todoer/widgets/todo_item.dart';
import 'package:todoer/widgets/todo_text_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database db = Database();
  final TextEditingController _todoTextController = TextEditingController();

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

  void toggleTodo(int index, bool isDone) {
    setState(() {
      db.toggleItem(index, isDone);
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
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: db.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TodoItemWidget(
                        text: db.items[index][0],
                        isDone: db.items[index][1],
                        onDeletePress: () => removeTodo(index),
                        onTap: (bool? isDone) => toggleTodo(index, isDone!),
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
