import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoer/domain/todo.dart';
import 'package:todoer/domain/todo_repository.dart';
import 'package:equatable/equatable.dart';

part 'todo_state.dart';

enum TodoSortType {
  high,
  medium,
  low,
  done,
  todo;

  TodoPriority get priority => switch (this) {
        high => TodoPriority.high,
        low => TodoPriority.low,
        _ => TodoPriority.medium,
      };
}

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository repository;

  TodoCubit(this.repository)
      : super(const TodoState(
          [],
          TodoSortType.todo,
        ));

  void _sortTodos(List<Todo> todos, [TodoSortType? sortType]) {
    if (sortType != null && sortType == state.sortType) return;

    switch (sortType ?? state.sortType) {
      case TodoSortType.high:
      case TodoSortType.medium:
      case TodoSortType.low:
        todos.sort((t1, t2) => t1.priority == t2.priority
            ? 0
            : t1.priority == (sortType ?? state.sortType).priority
                ? -1
                : t2.priority == (sortType ?? state.sortType).priority
                    ? 1
                    : 0);
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
