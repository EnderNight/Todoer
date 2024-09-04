import 'package:flutter/material.dart';
import 'package:todoer/domain/todo_repository.dart';
import 'package:todoer/presentation/views/todo_list_page.dart';

class TodoerApp extends StatelessWidget {
  final TodoRepository repository;

  const TodoerApp({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todoer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: TodoListPage(repository: repository),
    );
  }
}
