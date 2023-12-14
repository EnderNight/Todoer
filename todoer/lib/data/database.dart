import 'package:hive/hive.dart';

class Database {
  final Box<dynamic> _box = Hive.box('todoBox');
  List items = [];
  List<String> todoers = <String>[];

  Database() {
    for (String name in _box.keys) {
      todoers.add(name);
    }
  }

  void _saveTodoer(String todoerName) {
    _box.put(todoerName, items);
  }

  void addTodoer(String name) {
    todoers.add(name);
    items = [];
    _saveTodoer(name);
  }

  void removeTodoer(String name) {
    todoers.remove(name);
    _box.delete(name);
  }

  void loadTodos(String todoerName) {
    items = _box.get(todoerName, defaultValue: []);
  }

  void addTodo(String todoerName, String text) {
    items.add(<Object>[text, false]);

    _saveTodoer(todoerName);
  }

  void removeTodo(String todoerName, int index) {
    items.removeAt(index);

    _saveTodoer(todoerName);
  }

  void toggleTodo(String todoerName, int index, bool value) {
    items[index][1] = value;

    _saveTodoer(todoerName);
  }
}
