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

import 'dart:io';

import 'package:srs_app/pages/FirstPage_Stress.dart';


void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       //home:Wakeuppage(),

      // home: TasksPage(),

      home: Startpage(),

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
