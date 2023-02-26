import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreOperations {
  User user = FirebaseAuth.instance.currentUser!;

  addTo(title, description, date, time) {
    Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'dateYear': date?.year.toString(),
      'dateMonth': date?.month.toString(),
      'dateDay': date?.day.toString(),
      'timeHour': time?.hour.toString(),
      'timeMinute': time?.minute.toString(),
      'isDone': false
    };
    FirebaseFirestore.instance.collection(user.email.toString()).add(data);
  }
  delete(snapshot,index){
    FirebaseFirestore.instance
        .collection(user.email.toString())
        .doc(snapshot.data!.docs[index].reference.id)
        .delete();
  }
  edit(){
    // to be done
  }
  taskCompleted(snapshot,index){
    FirebaseFirestore.instance
        .collection(user.email.toString())
        .doc(snapshot.data!.docs[index].reference.id)
        .update({'isDone': true});
  }
  undoCompleted(snapshot,index){
    FirebaseFirestore.instance
        .collection(user.email.toString())
        .doc(snapshot.data!.docs[index].reference.id)
        .update({'isDone': false});
  }
}
