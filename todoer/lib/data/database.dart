import 'package:hive/hive.dart';

class Database {
  final Box box = Hive.box('todoBox');
  List items = [];

  Database() {
    items = box.get('todos', defaultValue: []);
  }

  void _saveItems() {
    box.put('todos', items);
  }

  void addItem(String text) {
    items.add([text, false]);

    _saveItems();
  }

  void removeItem(int index) {
    items.removeAt(index);

    _saveItems();
  }

  void toggleItem(int index) {
    items[index][1] = !items[index][1];

    _saveItems();
  }
}
