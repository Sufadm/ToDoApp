import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];
  final _mybox = Hive.box('myBox');

  void createInitialData() {
    toDoList = [
      ['makeTutorial', false],
      ['Do Exercise', false]
    ];
  }

  void loadData() {
    toDoList = _mybox.get('TODOLIST');
  }

  void updateDatabase() {
    _mybox.put('TODOLIST', toDoList);
  }
}
