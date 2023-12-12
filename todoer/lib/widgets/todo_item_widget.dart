import 'package:flutter/material.dart';

import 'package:todoer/domain/todo_item.dart';

class TodoItemWidget extends StatefulWidget {
  final TodoItem todoItem;

  const TodoItemWidget({
    super.key,
    required this.todoItem,
  });

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  void toggleDone() {
    setState(() {
      widget.todoItem.toggleDone();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: InkWell(
          onTap: toggleDone,
          child: Row(
            children: [
              Checkbox(value: widget.todoItem.isDone, onChanged: null),
              Text(
                widget.todoItem.text,
                style: TextStyle(
                    decoration: widget.todoItem.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
