import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoer/data/database.dart';
import 'package:todoer/pages/todoers_items_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todoBox');

  Database db = Database();

  runApp(TodoerApp(db: db));
}

class TodoerApp extends StatelessWidget {
  const TodoerApp({
    super.key,
    required this.db,
  });

  final Database db;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todoer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: TodoersPage(db: db),
    );
  }
}
