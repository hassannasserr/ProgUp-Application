import 'package:flutter/material.dart';

class RecommendationsPage extends StatefulWidget {
  @override
  State<RecommendationsPage> createState() => _RecommendationsPageState();
}
class _RecommendationsPageState extends State<RecommendationsPage> {
  // Colors for each section
  final Map<String, Color> sectionColors = {
    "Task Management": Color(0xFF283c64),
    "Sleep Recommendations": Color(0xFF386454),
    "Productivity Recommendations": Color(0xFF702c54),

  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24282e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF24282e),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/taskspage');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello She",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AbhayaLibre',
                    ),
                  ),
                  Image.asset(
                    'assets/images/small_white_logo.png',
                    height: 70,
                    width: 70,
                  ),
                ],
              ),
              Text(
                "Here It's\nYour Recommendations",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'AbhayaLibre',
                ),
              ),
              SizedBox(height: 5),
              _buildSection("Task Management", [
                "You have a high-priority task due tomorrow. Consider completing it today to avoid last-minute stress.",
                "You haven't scheduled time for task X this week. Add it to your schedule to stay on track.",
                "Break your task 'Prepare for Presentation' into smaller subtasks to make it more manageable.",
              ]),
              _buildSection("Sleep Recommendations", [
                "You slept less than 6 hours last night. Aim for at least 7-8 hours of sleep tonight to boost productivity.",
                "Your sleep pattern is inconsistent. Try to go to bed at the same time every night for better quality rest.",
              ]),
              _buildSection("Productivity Recommendations", [
                "You've completed 3 Pomodoro sessions today. Take a 15-30 minute break to recharge.",
                "You are most productive in the morning. Schedule your high-priority tasks during this time.",
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> recommendations) {
    final Color color = sectionColors[title] ?? Colors.grey; //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        ...recommendations.map((text) => _buildRecommendationCard(text, color: color)).toList(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poetsen',
      ),
    );
  }

  Widget _buildRecommendationCard(String text, {Color color = const Color(0xFF283c64)}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontFamily: 'AbhayaLibre',

        ),
      ),
    );
  }
}
