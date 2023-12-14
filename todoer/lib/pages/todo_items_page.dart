import 'package:flutter/material.dart';
import 'package:todoer/data/database.dart';
import 'package:todoer/widgets/todo_item.dart';
import 'package:todoer/widgets/todo_text_input.dart';

class TodoItemsPage extends StatefulWidget {
  const TodoItemsPage({
    super.key,
    required this.db,
    required this.todoerName,
  });

  final Database db;
  final String todoerName;

  @override
  State<TodoItemsPage> createState() => _TodoItemsPageState();
}

class _TodoItemsPageState extends State<TodoItemsPage> {
  final TextEditingController _todoTextController = TextEditingController();

  void createTodo(String text) {
    setState(() {
      widget.db.addTodo(widget.todoerName, text);
      _todoTextController.clear();
    });
  }

  void removeTodo(int index) {
    setState(() {
      widget.db.removeTodo(widget.todoerName, index);
    });
  }

  void toggleTodo(int index, bool isDone) {
    setState(() {
      widget.db.toggleTodo(widget.todoerName, index, isDone);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.todoerName)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: widget.db.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TodoItemWidget(
                        text: widget.db.items[index][0],
                        isDone: widget.db.items[index][1],
                        onDeletePress: () => removeTodo(index),
                        onTap: (bool? isDone) => toggleTodo(index, isDone!),
                      );
                    }),
              ),
              TodoTextInput(
                todoTextController: _todoTextController,
                onSubmit: createTodo,
                hintText: 'Enter a Todo',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
