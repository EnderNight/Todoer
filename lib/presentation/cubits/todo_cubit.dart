import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoer/domain/todo.dart';
import 'package:todoer/domain/todo_repository.dart';
import 'package:equatable/equatable.dart';

part 'todo_state.dart';

enum TodoSortType {
  creationDate,
  alpha,
  done,
  todo,
}

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository repository;

  TodoCubit(this.repository)
      : super(const TodoState(
          [],
          TodoSortType.creationDate,
        ));

  void _sortTodos(List<Todo> todos, [TodoSortType? sortType]) {
    if (sortType != null && sortType == state.sortType) return;

    switch (sortType ?? state.sortType) {
      case TodoSortType.creationDate:
        todos.sort((t1, t2) => t1.creationDate.compareTo(t2.creationDate));
        break;
      case TodoSortType.alpha:
        todos.sort((t1, t2) => t1.title.compareTo(t2.title));
        break;
      case TodoSortType.done:
        todos.sort((t1, t2) => t1.isDone == t2.isDone
            ? 0
            : t1.isDone
                ? -1
                : 1);
        break;
      case TodoSortType.todo:
        todos.sort((t1, t2) => t1.isDone == t2.isDone
            ? 0
            : t1.isDone
                ? 1
                : -1);
        break;
    }
  }

  Future<void> loadTodos() async {
    final todos = await repository.getTodos();
    final sortType = state.sortType;

    _sortTodos(todos);

    emit(TodoState(todos, sortType));
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

  Future<void> updateTodo(Todo todo) async {
    await repository.updateTodo(todo);

    loadTodos();
  }

  Future<void> sortTodos(TodoSortType type) async {
    final todos = List<Todo>.from(state.todos);

    _sortTodos(todos, type);

    emit(TodoState(todos, type));
  }
}
