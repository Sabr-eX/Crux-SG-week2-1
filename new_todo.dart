import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewToDo extends StatefulWidget {
  const NewToDo({
    Key? key,
    required this.addTx,
  }) : super(key: key);

  final Function addTx;

  @override
  State<NewToDo> createState() => _NewToDoState();
}

class _NewToDoState extends State<NewToDo> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? _selectedDeadline;

  void _submitData() {
    final _enteredTitle = titleController.text;
    final _enteredDescription = descriptionController.text;

    if (_enteredTitle.isEmpty || _selectedDeadline == 0) {
      return;
    }

    widget.addTx(
      _enteredTitle,
      _enteredDescription,
      _selectedDeadline,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDeadline = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            top: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDeadline == null
                          ? 'Deadline not set'
                          : 'Chosen deadline: ${DateFormat.yMd().format(_selectedDeadline!)}'),
                    ),
                    TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
                        ),
                        onPressed: _presentDatePicker,
                        child: const Text('Set Deadline',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: _submitData,
                child: const Text('Add ToDo'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
