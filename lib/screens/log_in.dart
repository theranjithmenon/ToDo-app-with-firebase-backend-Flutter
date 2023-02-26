import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_firebase/services/googleSignIn.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/task_man.json', height: 350),
            MaterialButton(
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                GoogleAuth().googleLogIn();
              },
              child: const ListTile(
                leading: Icon(
                  BootstrapIcons.google,
                ),
                title: Text('Continue with Google'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
