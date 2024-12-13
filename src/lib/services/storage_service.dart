import 'dart:convert';
import 'package:my_app/models/todo.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

class StorageService {
  final logger = Logger();
  static const String _todoKey = 'todos';

  Future<List<Todo>> getTodos() async {
    try {
      // For demo purposes, we'll use a static list
      // In a real app, this would use SharedPreferences or other storage
      return [];
    } catch (e) {
      logger.e('Error getting todos: $e');
      return [];
    }
  }

  Future<void> saveTodos(List<Todo> todos) async {
    try {
      final String encodedTodos = jsonEncode(
        todos.map((todo) => todo.toJson()).toList(),
      );
      debugPrint('Saved todos: $encodedTodos');
    } catch (e) {
      logger.e('Error saving todos: $e');
    }
  }
}
