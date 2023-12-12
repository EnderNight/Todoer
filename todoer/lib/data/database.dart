import 'package:hive/hive.dart';

class Database {
  final Box box = Hive.box('todoBox');
  List<(String, bool)> items = [];

  Database() {
    items = box.get('todos', defaultValue: <List<(String, bool)>>[])
        as List<(String, bool)>;
  }

  void _saveItems() {
    box.put('todos', items);
  }

  void addItem(String text) {
    items.add((text, false));

    _saveItems();
  }

  void removeItem(int index) {
    items.removeAt(index);

    _saveItems();
  }

  void toggleItem(int index) {
    (String, bool) prev = items[index];
    items.removeAt(index);

    items.add((prev.$1, !prev.$2));

    _saveItems();
  }
}
