import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/services/firestoreOperations.dart';

class TaskDetails extends StatelessWidget {
  final snapshot;
  final index;

  TaskDetails({Key? key, required this.snapshot, required this.index})
      : super(key: key);
  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                snapshot.data!.docs[index]['title'],
                style: const TextStyle(fontSize: 55),
              ),
              Text(
                snapshot.data!.docs[index]['description'],
                style: const TextStyle(fontSize: 25),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${snapshot.data!.docs[index]['timeHour']} : ${snapshot.data!.docs[index]['timeMinute']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        '${snapshot.data!.docs[index]['dateDay']}/${snapshot.data!.docs[index]['dateMonth']}/${snapshot.data!.docs[index]['dateYear']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                color: Colors.blueAccent.withOpacity(0.5),
                textColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {},
                child: const Icon(Icons.edit),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                color: Colors.redAccent.withOpacity(0.5),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textColor: Colors.white,
                onPressed: () {
                  FireStoreOperations().delete(snapshot, index);
                  Navigator.pop(context);
                },
                child: const Icon(Icons.delete),
              )
            ],
          ),
        ));
  }
}
