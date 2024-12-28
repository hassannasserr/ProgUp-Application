import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Secure storage for JWT token
final storage = const FlutterSecureStorage();
final String baseUrl = 'https://s7s1.pythonanywhere.com';

// Method to read token
Future<String?> _getToken() async {
  return await storage.read(key: 'jwt_token');
}

// Method to store token
Future<void> _storeToken(String token) async {
  await storage.write(key: 'jwt_token', value: token);
}

// Method to delete token (on logout)
Future<void> _deleteToken() async {
  await storage.delete(key: 'jwt_token');
}

class SleepInsightWidget extends StatefulWidget {
  const SleepInsightWidget({super.key});

  @override
  State<SleepInsightWidget> createState() => _SleepInsightWidgetState();
}

class _SleepInsightWidgetState extends State<SleepInsightWidget> {
  List<double> sleepValues = [];

  Future<void> loadData() async {
    final result = await getPomoActivities();
    if (result['success']) {
      setState(() {
        sleepValues = List<double>.from(result['sleepList']);
      });
    }
  }

  String calculateAverageSleep() {
    if (sleepValues.isEmpty) return "No Data";

    double totalHours = sleepValues.fold(0, (sum, value) => sum + value);
    double averageHours = totalHours / sleepValues.length;

    int hours = averageHours.floor();
    int minutes = ((averageHours - hours) * 60).round();

    return "$hours hrs $minutes mins";
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return InsightWidgetBase(
      title: "Sleeping Insights",
      icon: Icons.nights_stay,
      values: sleepValues,
      averageText: calculateAverageSleep(),
    );
  }
}

class StudyInsightWidget extends StatefulWidget {
  const StudyInsightWidget({super.key});

  @override
  State<StudyInsightWidget> createState() => _StudyInsightWidgetState();
}

class _StudyInsightWidgetState extends State<StudyInsightWidget> {
  List<double> studyValues = [];

  Future<void> loadData() async {
    final result = await getPomoActivities();
    if (result['success']) {
      setState(() {
        studyValues = List<double>.from(result['studyList']);
      });
    }
  }

  String calculateAverageStudy() {
    if (studyValues.isEmpty) return "No Data";

    double totalHours = studyValues.fold(0, (sum, value) => sum + value);
    double averageHours = totalHours / studyValues.length;

    int hours = averageHours.floor();
    int minutes = ((averageHours - hours) * 60).round();

    return "$hours hrs $minutes mins";
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return InsightWidgetBase(
      title: "Study Insights",
      icon: Icons.book,
      values: studyValues,
      averageText: calculateAverageStudy(),
    );
  }
}

class SocialInsightWidget extends StatefulWidget {
  const SocialInsightWidget({super.key});

  @override
  State<SocialInsightWidget> createState() => _SocialInsightWidgetState();
}

class _SocialInsightWidgetState extends State<SocialInsightWidget> {
  List<double> socialValues = [];

  Future<void> loadData() async {
    final result = await getPomoActivities();
    if (result['success']) {
      setState(() {
        socialValues = List<double>.from(result['socialList']);
      });
    }
  }

  String calculateAverageSocial() {
    if (socialValues.isEmpty) return "No Data";

    double totalHours = socialValues.fold(0, (sum, value) => sum + value);
    double averageHours = totalHours / socialValues.length;

    int hours = averageHours.floor();
    int minutes = ((averageHours - hours) * 60).round();

    return "$hours hrs $minutes mins";
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return InsightWidgetBase(
      title: "Social Insights",
      icon: Icons.people,
      values: socialValues,
      averageText: calculateAverageSocial(),
    );
  }
}

class PhysicalInsightWidget extends StatefulWidget {
  const PhysicalInsightWidget({super.key});

  @override
  State<PhysicalInsightWidget> createState() => _PhysicalInsightWidgetState();
}

class _PhysicalInsightWidgetState extends State<PhysicalInsightWidget> {
  List<double> physicalValues = [];

  Future<void> loadData() async {
    final result = await getPomoActivities();
    if (result['success']) {
      setState(() {
        physicalValues = List<double>.from(result['physicalList']);
      });
    }
  }

  String calculateAveragePhysical() {
    if (physicalValues.isEmpty) return "No Data";

    double totalHours = physicalValues.fold(0, (sum, value) => sum + value);
    double averageHours = totalHours / physicalValues.length;

    int hours = averageHours.floor();
    int minutes = ((averageHours - hours) * 60).round();

    return "$hours hrs $minutes mins";
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return InsightWidgetBase(
      title: "Physical Insights",
      icon: Icons.fitness_center,
      values: physicalValues,
      averageText: calculateAveragePhysical(),
    );
  }
}

class InsightWidgetBase extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<double> values;
  final String averageText;

  const InsightWidgetBase({
    super.key,
    required this.title,
    required this.icon,
    required this.values,
    required this.averageText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF384454),
      ),
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text("Average ",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              Text(
                averageText,
                style: const TextStyle(
                  color: Color(0xFF49B583),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: values.isEmpty
                ? Center(
                    child: Text(
                      "No Data Available",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                : BarChart(
                    BarChartData(
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            reservedSize: 32,
                            getTitlesWidget: (value, meta) {
                              if (value % 1 == 0) {
                                return Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                            getTitlesWidget: (value, meta) {
                              if (value >= 0 && value < values.length) {
                                return Text(
                                  'Day ${(value.toInt() + 1)}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        rightTitles:
                            AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles:
                            AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      barGroups: values
                          .asMap()
                          .entries
                          .map(
                            (entry) => BarChartGroupData(
                              x: entry.key,
                              barRods: [
                                BarChartRodData(
                                  toY: entry.value,
                                  color: const Color(0xFF49B583),
                                  width: 10,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

Future<Map<String, dynamic>> getPomoActivities() async {
  try {
    final token = await _getToken();
    if (token == null) {
      print('No token found. Please log in.');
      return {
        'success': false,
        'message': 'User not authenticated.',
      };
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/pomo_activities'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['activities'] != null) {
      List<double> sleepList = [];
      List<double> studyList = [];
      List<double> socialList = [];
      List<double> physicalList = [];

      for (var activity in data['activities']) {
        switch (activity['activityType']) {
          case 'Sleep':
            sleepList.add(double.parse(activity['activityDuration']));
            break;
          case 'Study':
            studyList.add(double.parse(activity['activityDuration']));
            break;
          case 'Social':
            socialList.add(double.parse(activity['activityDuration']));
            break;
          case 'Physical':
            physicalList.add(double.parse(activity['activityDuration']));
            break;
        }
      }

      return {
        'success': true,
        'sleepList': sleepList,
        'studyList': studyList,
        'socialList': socialList,
        'physicalList': physicalList,
      };
    } else {
      return {
        'success': false,
        'message': 'Failed to retrieve activities or no data available.',
      };
    }
  } catch (e) {
    print('Error: $e');
    return {
      'success': false,
      'message': 'An error occurred.',
    };
  }
}