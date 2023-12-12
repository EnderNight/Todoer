class TodoItem {
  String text;
  bool isDone;

  TodoItem({required this.text, required this.isDone});

  void toggleDone() {
    isDone = !isDone;
  }
}
