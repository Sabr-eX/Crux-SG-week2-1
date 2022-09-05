import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import './todo.dart';
import './todo_details.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({
    Key? key,
    required this.todos,
    required this.deleteTx,
    required this.completeTx,
  }) : super(key: key);

  final List<ToDo> todos;
  final Function deleteTx;
  final Function completeTx;

  void selectTask(BuildContext ctx) {}

  @override
  Widget build(BuildContext context) {
    return todos.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Nothing To Do',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Quicksand-Regular',
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 400,
                    child: Image.asset(
                      'assets/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            );
          })
        : Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.indigo,
                  Colors.blue,
                ],
              ),
            ),
            height: 600,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ToDoDetails.routeName, arguments: {
                      'id': todos[index].id,
                      'title': todos[index].title,
                      'description': todos[index].description,
                      'deadline': todos[index].deadline,
                      'isComplete': todos[index].isComplete,
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      8,
                      4,
                      8,
                      4,
                    ),
                    child: Slidable(
                      key: const ValueKey(0),
                      startActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            onPressed: (_) => deleteTx(todos[index].id),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            onPressed: (_) => completeTx(todos[index].id),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            icon: Icons.check,
                            label: 'Complete',
                          ),
                        ],
                      ),
                      child: Container(
                        child: Card(
                          margin: EdgeInsets.all(2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          color: Colors.yellow[100],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              todos[index].isComplete
                                  ? Icon(
                                      Icons.check_box_outlined,
                                      color: Colors.green,
                                      size: 30,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank_rounded,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                              Text(
                                todos[index].title,
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd()
                                    .format(todos[index].deadline),
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
