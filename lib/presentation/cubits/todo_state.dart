part of 'todo_cubit.dart';

class TodoState extends Equatable {
  final List<Todo> todos;
  final TodoSortType sortType;

  const TodoState(
    this.todos,
    this.sortType,
  );

  @override
  List<Object> get props => [todos, sortType];
}
