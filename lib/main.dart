import 'package:flutter/material.dart';
import 'package:srs_app/pages/ProfilePage.dart';
import 'package:srs_app/pages/RecommendationsPage.dart';
import 'package:srs_app/pages/Signup.dart';
import 'package:srs_app/pages/login.dart';
import 'package:srs_app/pages/Homepage.dart';
import 'package:srs_app/pages/SleepPage.dart';
import 'package:srs_app/pages/WakeUpPage.dart';
import 'package:srs_app/pages/ChangePass.dart';
import 'package:srs_app/pages/Taskpage.dart';
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
       //home: Homepage(),
       //home: Login(),
      home: Profilepage(),
      //home: ChangePass(),
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/taskspage': (context) => TasksPage(),
        '/changepass': (context) => ChangePass(),
        '/homepage': (context) => HomePage(),
        '/profile': (context) => Profilepage(),
        '/recommendations': (context) => RecommendationsPage(),





      },
      
    );
  }
}
