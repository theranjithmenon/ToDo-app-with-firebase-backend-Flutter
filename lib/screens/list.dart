import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_firebase/screens/details.dart';
import 'package:todo_firebase/services/firestoreOperations.dart';

list(isDone) {
  User user = FirebaseAuth.instance.currentUser!;
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(user.email.toString())
          .where('isDone', isEqualTo: isDone)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(child: Lottie.asset('assets/astronaut.json'));
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return _tile(snapshot, index, user, context, isDone);
              });
        }
      });
}

_tile(snapshot, index, user, context, isDone) {
  return ListTile(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TaskDetails(
                    snapshot: snapshot,
                    index: index,
                  )));
    },
    leading: IconButton(
        onPressed: () {
          (isDone)
              ? FireStoreOperations().undoCompleted(snapshot, index)
              : FireStoreOperations().taskCompleted(snapshot, index);
        },
        icon: const Icon(Icons.task_alt),
        color: (isDone) ? Colors.blueAccent : null),
    title: Text(snapshot.data?.docs[index]['title']),
  );
}
