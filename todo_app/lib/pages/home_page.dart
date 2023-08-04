import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/provider/provider_file.dart';
import 'package:todo_app/util/diologue_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();
  final _controller = TextEditingController();
  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DiologueBox(
            controller: _controller,
            onSave: () {
              Provider.of<ToDoProvider>(context, listen: false)
                  .saveNewTask(_controller.text);
              Navigator.pop(context);
              _controller.clear();
            },
            onCancel: () => Navigator.pop(context),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var toDoProvider = Provider.of<ToDoProvider>(context);
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('Todo App'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          createNewTask();
        },
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onchanged: (value) => toDoProvider.checkBoxChanged(value, index),
            deleteFunction: (context) => toDoProvider.deleteTask(index),
          );
        },
      ),
    );
  }
}
