import 'package:flutter/material.dart';
import 'package:srs_app/pages/ProfilePage.dart';
import 'package:srs_app/pages/Signup.dart';
import 'package:srs_app/pages/Taskpage.dart';
import 'package:srs_app/pages/insghts.dart';
import 'package:srs_app/pages/login.dart';
import 'package:srs_app/pages/Startpage.dart';
import 'package:srs_app/pages/Homepage.dart';
import 'package:srs_app/pages/SleepPage.dart';
import 'package:srs_app/pages/WakeUpPage.dart';
import 'package:srs_app/pages/ChangePass.dart';
import 'package:srs_app/pages/pomodoro.dart';
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
       home: const HomePage(),
       //home: Homepage(),
       //home: Login(),
       // home: Profilepage(),
      //home: ChangePass(),
      routes: {
        '/login': (context) => const Login(),
        '/pomo': (context) => const Pomodoro(),
        '/signup': (context) => const Signup(),
        '/homepage': (context) => const HomePage(),
        '/profile': (context) => const Profilepage(),
        '/Startpage': (context) => const Startpage(),
        '/sleep': (context) => const SleepPage(),
        '/wakeup': (context) => const Wakeuppage(),
        '/changepass': (context) => const ChangePass(),
        '/insights': (context) => const insights(),
        '/taskspage':(context)=>TasksPage(),
      },
      
    );
  }
}
