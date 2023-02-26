import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/screens/form.dart';
import 'package:todo_firebase/services/googleSignIn.dart';
import 'list.dart';

class HomeListPage extends StatefulWidget {
  const HomeListPage({Key? key}) : super(key: key);

  @override
  State<HomeListPage> createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  final user = FirebaseAuth.instance.currentUser!;
  int selectedIndex = 0;
  List pages = [list(false), null, list(true)];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(user.photoURL.toString()))),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.displayName.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
            Text(user.email.toString(),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
          ],
        ),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [PopupMenuItem(child: const Text('Log Out'),onTap: (){
              GoogleAuth().logout();
            },)];
          })
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            if (index == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TaskForm()));
            } else {
              setState(() {
                selectedIndex = index;
              });
            }
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.timer), label: 'Pending Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_task), label: 'Add Task'),
            BottomNavigationBarItem(
                icon: Icon(Icons.task_alt), label: 'Completed Tasks'),
          ]),
    );
  }
}
