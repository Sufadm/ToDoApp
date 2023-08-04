import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';

class ToDoProvider extends ChangeNotifier {
  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  List<dynamic> _toDoList = [];

  List<dynamic> get toDoList => _toDoList;

  ToDoProvider() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    _toDoList = db.toDoList; // No need to change this line
  }

  void checkBoxChanged(bool? value, int index) {
    _toDoList[index][1] = !toDoList[index][1];
    db.updateDatabase();
    notifyListeners();
  }

  void saveNewTask(String taskName) {
    _toDoList.add([taskName, false]);
    db.updateDatabase();
    notifyListeners();
  }

  void deleteTask(int index) {
    _toDoList.removeAt(index);
    db.updateDatabase();
    notifyListeners();
  }
}
