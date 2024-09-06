import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoer/data/todo_model.dart';
import 'package:todoer/data/todo_priority_model.dart';
import 'package:todoer/data/todo_repository.dart';
import 'package:todoer/presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter('Todoer');

  Hive.registerAdapter(TodoModelAdapter());
  Hive.registerAdapter(TodoPriorityModelAdapter());

  final todoBox = await Hive.openBox<TodoModel>('todos');

  final repository = TodoRepositoryHive(todoBox);

  runApp(TodoerApp(repository: repository));
}
