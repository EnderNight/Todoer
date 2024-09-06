import 'package:flutter/material.dart';
import 'package:todoer/domain/todo.dart';
import 'package:todoer/presentation/cubits/todo_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoSheetWidget extends StatefulWidget {
  final Todo todo;

  const TodoSheetWidget({
    super.key,
    required this.todo,
  });

  @override
  State<TodoSheetWidget> createState() => _TodoSheetWidgetState();
}

class _TodoSheetWidgetState extends State<TodoSheetWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.todo.title);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: controller,
          ),
          const SizedBox(height: 80),
          FilledButton.icon(
            onPressed: () {
              final newTodo = widget.todo.copyWith(title: controller.text);

              context.read<TodoCubit>().updateTodo(newTodo);
            },
            label: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
