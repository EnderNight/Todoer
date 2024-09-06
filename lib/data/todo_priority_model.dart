import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoer/domain/todo.dart';

part 'todo_priority_model.g.dart';

@HiveType(typeId: 2)
enum TodoPriorityModel {
  @HiveField(0)
  high,

  @HiveField(1)
  medium,

  @HiveField(2)
  low,
}

TodoPriority priorityToEntity(TodoPriorityModel priority) {
  return switch (priority) {
    TodoPriorityModel.high => TodoPriority.high,
    TodoPriorityModel.medium => TodoPriority.medium,
    TodoPriorityModel.low => TodoPriority.low,
  };
}

TodoPriorityModel priorityFromEntity(TodoPriority priority) {
  return switch (priority) {
    TodoPriority.high => TodoPriorityModel.high,
    TodoPriority.medium => TodoPriorityModel.medium,
    TodoPriority.low => TodoPriorityModel.low,
  };
}
