import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/services/firestoreOperations.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key,}) : super(key: key);

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController _taskName = TextEditingController();

  final TextEditingController _description = TextEditingController();

  String title = '';
  String description = '';
  TimeOfDay? time;
  DateTime? date;
  User user = FirebaseAuth.instance.currentUser!;



  _datePicker(context) async {
    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
  }

  _timePicker(context) async {
    time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: DateTime.now().hour, minute: DateTime.now().minute));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Text(
                      _taskName.text,
                      style: const TextStyle(fontSize: 35),
                    ),
                    Text(
                      _description.text,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    TextField(
                      controller: _taskName,
                      onChanged: (title) {
                        setState(() {
                          title = title;
                        });
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Title',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _description,
                      keyboardType: TextInputType.text,
                      maxLines: null,
                      onChanged: (description) {
                        setState(() {
                          description = description;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _datePicker(context);
                            },
                            icon: const Icon(Icons.date_range)),
                        IconButton(
                            onPressed: () {
                              _timePicker(context);
                            },
                            icon: const Icon(Icons.timer)),
                        const Spacer(),
                        MaterialButton(
                          onPressed: () {
                            if (_taskName.text == '' ||
                                _description.text == '' ||
                                date == null ||
                                time == null) {
                              return;
                            } else {
                              FireStoreOperations().addTo(_taskName.text,
                                  _description.text, date, time);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Add Task'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
