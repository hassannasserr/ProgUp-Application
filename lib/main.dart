import 'package:flutter/material.dart';
import 'package:srs_app/pages/ForgetPass.dart';
import 'package:srs_app/pages/ProfilePage.dart';
import 'package:srs_app/pages/RecommendationsPage.dart';
import 'package:srs_app/pages/Signup.dart';
import 'package:srs_app/pages/Taskpage.dart';
import 'package:srs_app/pages/VerifyEmailScreen.dart';
import 'package:srs_app/pages/insghts.dart';
import 'package:srs_app/pages/login.dart';
import 'package:srs_app/pages/Homepage.dart';
import 'package:srs_app/pages/SleepPage.dart';
import 'package:srs_app/pages/WakeUpPage.dart';
import 'package:srs_app/pages/ChangePass.dart';
import 'package:srs_app/pages/newpass.dart';
import 'package:srs_app/pages/pomodoro.dart';
import 'package:srs_app/pages/Startpage.dart';
import 'package:srs_app/pages/FirstPage_Stress.dart';
import 'dart:io';
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
       home: const Startpage(),
       //home: Login(),
       //home: Profilepage(),
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
        '/insights': (context) => const Insights(),
        '/taskspage':(context)=> TasksPage(),

        '/recommendations':(context)=>const RecommendationsPage(
          sleepAverage: 'Moderate',
          socialAverage: 'Moderate',
          studyAverage: 'Moderate',
          physicalAverage: 'Moderate',
        ),

        '/stresspage':(context)=> SocialActivityPage(),
        '/forget':(context)=>ForgotPasswordScreen(),
        '/verify':(context)=>VerifyEmailScreen(),
        '/Newpass':(context)=>const Newpass(),
      },
      
    );
  }
}
