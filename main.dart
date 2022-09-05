import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './todo.dart';
import './new_todo.dart';
import './todo_list.dart';
import './todo_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<ToDo> _userToDos = [];

  void _addNewToDo(
    String txTitle,
    String txDescription,
    DateTime choosenDeadline,
  ) {
    final newtx = ToDo(
      title: txTitle,
      description: txDescription,
      deadline: choosenDeadline,
      id: DateTime.now(),
    );

    setState(() {
      _userToDos.add(newtx);
    });
  }

  void _startAddNewToDo(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewToDo(addTx: _addNewToDo),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteToDo(DateTime id) {
    setState(() {
      _userToDos.removeWhere((tx) => tx.id == id);
    });
  }

  void _completeToDo(DateTime id) {
    setState(() {
      var completedtask = _userToDos.singleWhere((tx) => tx.id == id);
      completedtask.isComplete = true;
    });
  }

  Future _saveToDoInfo(DateTime id, String title, String description,
      DateTime deadline, bool isComplete) async {
    final ToDo todo = ToDo.fromJson({
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline,
      'isComplete': isComplete,
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString('todo', jsonEncode(todo));
    print(result);
  }

  Future _getToDoInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> todoMap = {};
    final String? todoStr = prefs.getString('todo');
    if (todoStr != null) {
      todoMap = jsonDecode(todoStr) as Map<String, dynamic>;
    }

    final ToDo todo = ToDo.fromJson(todoMap);
    print(todo);
    return todo;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              toolbarTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                    headline6: const TextStyle(
                      fontFamily: 'CherrySwash',
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  )
                  .bodyText2,
              titleTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                    headline6: const TextStyle(
                      fontFamily: 'CherrySwash',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  )
                  .headline6)),
      home: MyHomePage(
        userToDos: _userToDos,
        deleteToDo: _deleteToDo,
        completeToDo: _completeToDo,
        startAddNewToDo: _startAddNewToDo,
      ),
      routes: {
        ToDoDetails.routeName: ((context) => ToDoDetails(
              complete: _completeToDo,
            ))
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
    required this.userToDos,
    required this.deleteToDo,
    required this.completeToDo,
    required this.startAddNewToDo,
  }) : super(key: key);

  final List<ToDo> userToDos;
  final Function deleteToDo;
  final Function completeToDo;
  final Function startAddNewToDo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Dos'),
        centerTitle: true,
      ),
      body: ToDoList(
        todos: userToDos,
        deleteTx: deleteToDo,
        completeTx: completeToDo,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewToDo(context),
      ),
    );
  }
}
