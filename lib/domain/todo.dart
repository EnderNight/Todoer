import 'package:todoer/core/utils/string.dart';

enum TodoPriority {
  high,
  medium,
  low;

  @override
  String toString() => name.capitalize();
}

class Todo {
  final String id;
  final String title;
  final bool isDone;
  final DateTime creationDate;
  final TodoPriority priority;

  const Todo({
    this.id = '',
    required this.title,
    this.isDone = false,
    required this.creationDate,
    required this.priority,
  });

  Todo toggle() {
    return copyWith(isDone: !isDone);
  }

  Todo copyWith({
    String? id,
    String? title,
    bool? isDone,
    DateTime? creationDate,
    TodoPriority? priority,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      creationDate: creationDate ?? this.creationDate,
      priority: priority ?? this.priority,
    );
  }
}
