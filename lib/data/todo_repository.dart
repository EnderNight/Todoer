import 'package:hive/hive.dart';
import 'package:todoer/data/todo_model.dart';
import 'package:todoer/domain/todo.dart';
import 'package:todoer/domain/todo_repository.dart';
import 'package:uuid/uuid.dart';

class TodoRepositoryHive implements TodoRepository {
  final Box<TodoModel> _todoBox;
  static const Uuid uuid = Uuid();

  const TodoRepositoryHive(Box<TodoModel> todoBox) : _todoBox = todoBox;

  @override
  Future<void> addTodo(Todo todo) async {
    final id = uuid.v4();

    final idTodo = todo.copyWith(id: id);

    final model = TodoModel.fromEntity(idTodo);

    await _todoBox.put(model.id, model);
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await _todoBox.delete(todo.id);
  }

  @override
  Future<List<Todo>> getTodos() async {
    return _todoBox.values.map((v) => v.toEntity()).toList();
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final model = TodoModel.fromEntity(todo);

    await _todoBox.put(model.id, model);
  }
}
