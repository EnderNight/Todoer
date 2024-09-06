import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoer/domain/todo.dart';
import 'package:todoer/presentation/cubits/todo_cubit.dart';
import 'package:todoer/presentation/widgets/todo_tile_widget.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  void _onTodoToggle(BuildContext context, int index) {
    final todoCubit = context.read<TodoCubit>();

    todoCubit.toggleTodo(todoCubit.state.todos[index]);
  }

  void _onTodoDelete(BuildContext context, int index) {
    final todoCubit = context.read<TodoCubit>();

    todoCubit.deleteTodo(todoCubit.state.todos[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todoer'),
        actions: [
          PopupMenuButton<TodoSortType>(
              onSelected: (sortType) {
                context.read<TodoCubit>().sortTodos(sortType);
              },
              itemBuilder: (_) => [
                    const PopupMenuItem<TodoSortType>(
                      value: TodoSortType.creationDate,
                      child: Text('Creation date'),
                    ),
                    const PopupMenuItem<TodoSortType>(
                      value: TodoSortType.alpha,
                      child: Text('Alphabetically'),
                    ),
                    const PopupMenuItem<TodoSortType>(
                      value: TodoSortType.todo,
                      child: Text('To do'),
                    ),
                    const PopupMenuItem<TodoSortType>(
                      value: TodoSortType.done,
                      child: Text('Done'),
                    ),
                  ]),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TodoCubit, TodoState>(builder: (_, state) {
          if (state.todos.isEmpty) {
            return const Center(
              child: Text('Nothing to do for now...'),
            );
          }

          return ListView.separated(
            itemCount: state.todos.length,
            itemBuilder: (context, index) => TodoTileWidget(
              todo: state.todos[index],
              onToggle: (_) => _onTodoToggle(context, index),
              onDelete: () => _onTodoDelete(context, index),
            ),
            separatorBuilder: (_, __) => const Divider(
              indent: 20,
              endIndent: 20,
            ),
          );
        }),
      ),
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
                        final todo = Todo(
                          title: title,
                          creationDate: DateTime.now(),
                          priority: TodoPriority.low,
                        );

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
