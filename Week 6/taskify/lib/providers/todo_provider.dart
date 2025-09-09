import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _showOnlyCompleted
      ? _todos.where((todo) => todo.isDone).toList()
      : _todos;

  bool _showOnlyCompleted = false;
  bool get showOnlyCompleted => _showOnlyCompleted;

  TodoProvider() {
    _loadTodos();
  }

  void _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('todos');

    if (todosString != null) {
      final List decoded = json.decode(todosString);
      _todos =
          decoded.map((e) => TodoModel.fromJson(e)).toList().cast<TodoModel>();
    } else {
      _todos = TodoModel.todoList(); // initial sample data
    }

    notifyListeners();
  }

  void _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(_todos.map((e) => e.toJson()).toList());
    prefs.setString('todos', encoded);
  }

  void addTodo(String title) {
    _todos.add(
      TodoModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(), title: title),
    );
    _saveTodos();
    notifyListeners();
  }

  void toggleTodo(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index].isDone = !_todos[index].isDone;
      _saveTodos();
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    _saveTodos();
    notifyListeners();
  }

  void clearAll() {
    _todos.clear();
    _saveTodos();
    notifyListeners();
  }

  void toggleFilter() {
    _showOnlyCompleted = !_showOnlyCompleted;
    notifyListeners();
  }

  void showAll() {
    _showOnlyCompleted = false;
    notifyListeners();
  }

  List<TodoModel> search(String keyword) {
    return todos
        .where(
            (todo) => todo.title!.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }
}
