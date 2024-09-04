import 'package:hive/hive.dart';
import 'package:todoer/domain/todo.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isDone;

  const TodoModel({
    required this.id,
    required this.title,
    required this.isDone,
  });

  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      isDone: todo.isDone,
    );
  }

  Todo toEntity() {
    return Todo(
      id: id,
      title: title,
      isDone: isDone,
    );
  }
}
