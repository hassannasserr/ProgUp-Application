import 'package:flutter/material.dart';
import 'package:srs_app/pages/ProfilePage.dart';
import 'package:srs_app/pages/Signup.dart';
import 'package:srs_app/pages/login.dart';
import 'package:srs_app/pages/Homepage.dart';
import 'package:srs_app/pages/taskspage.dart';
import 'package:srs_app/pages/SleepPage.dart';
import 'package:srs_app/pages/WakeUpPage.dart';
import 'package:srs_app/pages/ChangePass.dart';
import 'package:srs_app/pages/ProfilePage.dart';
import 'package:srs_app/Widgets/taskwidget.dart';
import 'package:intl/intl.dart'; // لإظهار التاريخ الحقيقي
import 'pages/AddTask.dart';
void main() {
  Intl.defaultLocale = 'en_US';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:TasksPage(),
      //home: Homepage(),
      //home:Profilepage(),
      // home: Homepage(),

      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/taskspage': (context) => Taskspage(),
        '/profile': (context) => Profilepage(),
        '/changepass' : (context) => ChangePass(),

      },

    );
  }
}