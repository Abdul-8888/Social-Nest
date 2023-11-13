import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo_model.dart';

// * SharedPreference key
const todoListKey = 'todo_list';

class todo_crud {
  Future<List<todomodel>> getTodoList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final jsonDecoded = json.decode(jsonString) as List;

    return jsonDecoded
        .map(
          (eachItem) => todomodel.fromJson(eachItem as Map<String, dynamic>),
        )
        .toList();
  }

  void saveTodoTaskList(List<todomodel> todos) async {
    final stringJson = json.encode(todos);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(todoListKey, stringJson);
  }

  bool updateTodoTask(List<todomodel> todos, int id, String Title,
      String deadline, String description) {
    for (var i in todos) {
      if (i.id == id) {
        i.title = Title;
        i.description = description;
        i.deadline = deadline;
      }
    }
    saveTodoTaskList(todos);
    return true;
  }

  bool updateStatusTodoTask(List<todomodel> todos, int id, String status) {
    for (var i in todos) {
      if (i.id == id) {
        i.status = status;
      }
    }
    saveTodoTaskList(todos);
    return true;
  }
}
