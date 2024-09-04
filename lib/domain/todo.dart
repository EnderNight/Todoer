class Todo {
  final String id;
  final String title;
  final bool isDone;

  const Todo({
    this.id = '',
    required this.title,
    this.isDone = false,
  });

  Todo toggle() {
    return Todo(
      id: id,
      title: title,
      isDone: !isDone,
    );
  }

  Todo copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
