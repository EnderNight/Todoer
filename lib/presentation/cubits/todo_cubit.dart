import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoer/domain/todo.dart';
import 'package:todoer/domain/todo_repository.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepository repository;

  TodoCubit(this.repository) : super([]);

  Future<void> loadTodos() async {
    final todos = await repository.getTodos();

    emit(todos);
  }

  Future<void> addTodo(Todo todo) async {
    await repository.addTodo(todo);

    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await repository.deleteTodo(todo);

    loadTodos();
  }

  Future<void> toggleTodo(Todo todo) async {
    await repository.updateTodo(todo.toggle());

    loadTodos();
  }
}
