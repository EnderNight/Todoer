class Todo {
  final String id;
  final String title;
  final bool isDone;
  final DateTime creationDate;

  const Todo({
    this.id = '',
    required this.title,
    this.isDone = false,
    required this.creationDate,
  });

  Todo toggle() {
    return copyWith(isDone: !isDone);
  }

  Todo copyWith({
    String? id,
    String? title,
    bool? isDone,
    DateTime? creationDate,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      creationDate: creationDate ?? this.creationDate,
    );
  }
}
