import 'package:flutter/material.dart';
import 'package:todoer/domain/todo.dart';
import 'package:todoer/presentation/widgets/todo_sheet_widget.dart';

class TodoTileWidget extends StatelessWidget {
  final Todo todo;
  final void Function(bool?) onToggle;
  final void Function() onDelete;
  final void Function(String title, TodoPriority priority) onTodoUpdate;

  const TodoTileWidget({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onTodoUpdate,
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
      subtitle: Row(
        children: [
          switch (todo.priority) {
            TodoPriority.low => const Icon(
                Icons.circle,
                size: 15,
                color: Colors.green,
              ),
            TodoPriority.medium => const Icon(
                Icons.circle,
                size: 15,
                color: Colors.orange,
              ),
            TodoPriority.high => const Icon(
                Icons.circle,
                size: 15,
                color: Colors.red,
              ),
          },
          const SizedBox(width: 5),
          Text(todo.priority.toString()),
        ],
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
      onTap: () => showModalBottomSheet(
          context: context,
          showDragHandle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) {
            return TodoSheetWidget(
              todo: todo,
              validateBtnText: 'Update',
              onValidate: onTodoUpdate,
              shouldClear: false,
            );
          }),
    );
  }
}
