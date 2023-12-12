import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoer/widgets/home_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todoBox');

  runApp(const TodoerApp());
}

class TodoerApp extends StatelessWidget {
  const TodoerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todoer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
