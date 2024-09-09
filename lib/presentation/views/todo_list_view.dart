import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoer/domain/todo.dart';
import 'package:todoer/presentation/cubits/todo_cubit.dart';
import 'package:todoer/presentation/widgets/todo_sheet_widget.dart';
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

  void _onTodoUpdate(
      BuildContext context, String title, TodoPriority priority, int index) {
    final todoCubit = context.read<TodoCubit>();

    todoCubit.updateTodo(todoCubit.state.todos[index].copyWith(
      title: title,
      priority: priority,
    ));
  }

  void _ontTodoAdd(BuildContext context, String title, TodoPriority priority) {
    final todoCubit = context.read<TodoCubit>();

    final todo = Todo(
      title: title,
      creationDate: DateTime.now(),
      priority: priority,
    );

    todoCubit.addTodo(todo);
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
                      value: TodoSortType.high,
                      child: Text('High'),
                    ),
                    const PopupMenuItem<TodoSortType>(
                      value: TodoSortType.medium,
                      child: Text('Medium'),
                    ),
                    const PopupMenuItem<TodoSortType>(
                      value: TodoSortType.low,
                      child: Text('Low'),
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
              onTodoUpdate: (title, priority) =>
                  _onTodoUpdate(context, title, priority, index),
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
          showModalBottomSheet(
              context: context,
              showDragHandle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) {
                return TodoSheetWidget(
                    shouldClear: true,
                    validateBtnText: 'Add',
                    onValidate: (title, priority) =>
                        _ontTodoAdd(context, title, priority));
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
