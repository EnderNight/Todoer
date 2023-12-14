import 'package:flutter/material.dart';

class TodoItemWidget extends StatelessWidget {
  final String text;
  final bool isDone;
  final void Function() onDeletePress;
  final void Function(bool?) onTap;

  const TodoItemWidget({
    super.key,
    required this.text,
    required this.isDone,
    required this.onDeletePress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: Row(
            children: <Widget>[
              Checkbox(value: isDone, onChanged: onTap),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                      decoration: isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
              IconButton(
                onPressed: onDeletePress,
                icon: const Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}
