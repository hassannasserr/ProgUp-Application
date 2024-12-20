import 'package:flutter/material.dart';
import 'package:srs_app/pages/ProfilePage.dart';
import 'package:srs_app/pages/Signup.dart';
import 'package:srs_app/pages/login.dart';
import 'package:srs_app/pages/Startpage.dart';
import 'package:srs_app/pages/Homepage.dart';
import 'package:srs_app/pages/SleepPage.dart';
import 'package:srs_app/pages/WakeUpPage.dart';
import 'package:srs_app/pages/ProfilePage.dart';
import 'package:srs_app/pages/ChangePass.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       //home:Wakeuppage(),
       home: Startpage(),
       //home: Homepage(),
       //home: Login(),
     // home: Profilepage(),
      //home: ChangePass(),
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/taskspage': (context) => HomePage(),
        '/profile': (context) => Profilepage(),
        '/homepage': (context) => Startpage(),
        '/sleep': (context) => SleepPage(),
        '/wakeup': (context) => Wakeuppage(),
        '/changepass': (context) => ChangePass(),
      },
      
    );
  }
}
