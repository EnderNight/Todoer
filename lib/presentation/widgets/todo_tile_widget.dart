import 'package:flutter/material.dart';
import 'package:todoer/domain/todo.dart';

class TodoTileWidget extends StatelessWidget {
  final Todo todo;
  final void Function(bool?) onToggle;
  final void Function() onDelete;

  const TodoTileWidget({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      title: Text(
        todo.title,
        style: todo.isDone
            ? textTheme.bodyLarge!
                .copyWith(decoration: TextDecoration.lineThrough)
            : null,
      ),
      leading: Checkbox(
        value: todo.isDone,
        onChanged: onToggle,
      ),
      trailing: IconButton(
        onPressed: onDelete,
        icon: const Icon(
          Icons.cancel,
        ),
      ),
    );
  }
}
