import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoer/domain/todo_repository.dart';
import 'package:todoer/presentation/cubits/todo_cubit.dart';
import 'package:todoer/presentation/views/todo_list_view.dart';

class TodoListPage extends StatelessWidget {
  final TodoRepository repository;

  const TodoListPage({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(repository)..loadTodos(),
      child: const TodoListView(),
    );
  }
}
