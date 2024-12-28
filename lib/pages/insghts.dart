import 'package:flutter/material.dart';
import 'package:srs_app/Widgets/insightwidget.dart';

class Insights extends StatefulWidget {
  const Insights({super.key});

  @override
  State<Insights> createState() => _insightsState();
}

class _insightsState extends State<Insights> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24282e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF24282e),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/homepage');
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Image.asset(
          'assets/images/small_white_logo.png',
          height: 70,
        ),
        centerTitle: true,
      ),
      body: 
         ListView(
          padding: const EdgeInsets.all(15),
          children: const [
            SleepInsightWidget(),
            SizedBox(height: 10,),
            StudyInsightWidget(),
            SizedBox(height: 10,),
            SocialInsightWidget(),
            SizedBox(height: 10,),
            PhysicalInsightWidget()
            
          ]
        ),
    
    );
  }
}