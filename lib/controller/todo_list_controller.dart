import 'package:flutter/material.dart';

import 'package:todo_list_provider/model/todo.dart';

class TodoController extends ChangeNotifier {
  final List<Todo> _todoList = <Todo>[];

  void addTodo(Todo todo) {
    _todoList.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todoList.remove(todo);
    notifyListeners();
  }

  void changeValue(int index) {
    _todoList[index].isDone = !_todoList[index].isDone;
    notifyListeners();
  }

  List<Todo> get getAllTOdos => _todoList;

  void clearAll() {
    _todoList.clear();
    notifyListeners();
  }
}
