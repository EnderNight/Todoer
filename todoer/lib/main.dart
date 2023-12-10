import 'package:flutter/material.dart';

void main() => runApp(const TodoerApp());

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todoer')),
      body: const Center(
        child: Text('Hello World!'),
      ),
    );
  }
}