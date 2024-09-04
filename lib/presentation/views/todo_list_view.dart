import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoer/domain/todo.dart';
import 'package:todoer/presentation/cubits/todo_cubit.dart';
import 'package:todoer/presentation/widgets/todo_tile_widget.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  void _onTodoToggle(BuildContext context, int index) {
    final todoCubit = context.read<TodoCubit>();

    todoCubit.toggleTodo(todoCubit.state[index]);
  }

  void _onTodoDelete(BuildContext context, int index) {
    final todoCubit = context.read<TodoCubit>();

    todoCubit.deleteTodo(todoCubit.state[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todoer'),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(builder: (_, todos) {
        if (todos.isEmpty) {
          return const Center(
            child: Text('Nothing to do for now...'),
          );
        }

        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) => TodoTileWidget(
            todo: todos[index],
            onToggle: (_) => _onTodoToggle(context, index),
            onDelete: () => _onTodoDelete(context, index),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a todo',
        onPressed: () {
          final todoCubit = context.read<TodoCubit>();

          showDialog(
              context: context,
              builder: (context) {
                final controller = TextEditingController();

                return AlertDialog(
                  title: const Text('Add a todo'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        final title = controller.text;
                        final todo = Todo(title: title);

                        todoCubit.addTodo(todo);

                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                  content: TextField(controller: controller),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
