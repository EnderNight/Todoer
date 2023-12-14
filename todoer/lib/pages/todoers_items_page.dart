import 'package:flutter/material.dart';
import 'package:todoer/data/database.dart';
import 'package:todoer/pages/todo_items_page.dart';
import 'package:todoer/widgets/todo_text_input.dart';
import 'package:todoer/widgets/todoer_item.dart';

class TodoersPage extends StatefulWidget {
  const TodoersPage({
    super.key,
    required this.db,
  });

  final Database db;

  @override
  State<TodoersPage> createState() => _TodoersPageState();
}

class _TodoersPageState extends State<TodoersPage> {
  final TextEditingController _todoTextController = TextEditingController();

  void createTodoer(String name) {
    setState(() {
      widget.db.addTodoer(name);
      _todoTextController.clear();
    });
  }

  void removeTodoer(String name) {
    setState(() {
      widget.db.removeTodoer(name);
    });
  }

  void onTodoerSelected(BuildContext context, int index) {
    widget.db.loadTodos(widget.db.todoers[index]);
    Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => TodoItemsPage(
            db: widget.db,
            todoerName: widget.db.todoers[index],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todoer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: widget.db.todoers.length,
                  itemBuilder: (BuildContext context, int index) =>
                      TodoerItemWidget(
                    todoerName: widget.db.todoers[index],
                    onTap: () => onTodoerSelected(context, index),
                    onDelete: () => removeTodoer(widget.db.todoers[index]),
                  ),
                ),
              ),
              TodoTextInput(
                todoTextController: _todoTextController,
                onSubmit: createTodoer,
                hintText: 'Enter a Todoer',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
