import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ToDoDetails extends StatelessWidget {
  ToDoDetails({
    Key? key,
    required this.complete,
  }) : super(key: key);
  static const routeName = '/todo_details';

  final Function complete;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final DateTime todoid = routeArgs['id'] as DateTime;
    final String todoTitle = routeArgs['title'] as String;
    final String todoDescription = routeArgs['description'] as String;
    final DateTime todoDeadline = routeArgs['deadline'] as DateTime;
    final bool todoisComplete = routeArgs['isComplete'] as bool;
    return Scaffold(
      appBar: AppBar(
        title: Text(todoTitle),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.black,
          ],
        )),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.amber,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Text(todoDescription,
                      style: TextStyle(
                        fontSize: 20,
                      ))),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.black,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Deadline:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(todoDeadline),
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            todoisComplete
                ? Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        'Task Completed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        'Task Pending',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
