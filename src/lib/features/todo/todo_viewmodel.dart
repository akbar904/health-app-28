import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.dialogs.dart';
import 'package:my_app/features/todo/todo_repository.dart';
import 'package:my_app/models/todo.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoViewModel extends BaseViewModel {
  final _todoRepository = locator<TodoRepository>();
  final _dialogService = locator<DialogService>();
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> initialize() async {
    setBusy(true);
    await loadTodos();
    setBusy(false);
  }

  Future<void> loadTodos() async {
    _todos = await _todoRepository.getTodos();
    notifyListeners();
  }

  Future<void> addTodo() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.addTodo,
    );

    if (response?.confirmed == true && response?.data != null) {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: response!.data,
        createdAt: DateTime.now(),
      );
      await _todoRepository.addTodo(todo);
      await loadTodos();
    }
  }

  Future<void> toggleTodoComplete(String id) async {
    await _todoRepository.toggleTodoCompletion(id);
    await loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.confirmation,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (response?.confirmed == true) {
      await _todoRepository.deleteTodo(id);
      await loadTodos();
    }
  }
}
