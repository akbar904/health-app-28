import 'package:my_app/models/todo.dart';
import 'package:my_app/services/storage_service.dart';

class TodoRepository {
  final StorageService _storageService;

  TodoRepository(this._storageService);

  Future<List<Todo>> getTodos() async {
    return await _storageService.getTodos();
  }

  Future<void> saveTodos(List<Todo> todos) async {
    await _storageService.saveTodos(todos);
  }

  Future<void> addTodo(Todo todo) async {
    final todos = await getTodos();
    todos.add(todo);
    await saveTodos(todos);
  }

  Future<void> updateTodo(Todo todo) async {
    final todos = await getTodos();
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await saveTodos(todos);
    }
  }

  Future<void> deleteTodo(String id) async {
    final todos = await getTodos();
    todos.removeWhere((todo) => todo.id == id);
    await saveTodos(todos);
  }

  Future<void> toggleTodoCompletion(String id) async {
    final todos = await getTodos();
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = todos[index];
      todos[index] = todo.copyWith(isCompleted: !todo.isCompleted);
      await saveTodos(todos);
    }
  }
}
