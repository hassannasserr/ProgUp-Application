import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SleepInsightWidget extends StatefulWidget {
  const SleepInsightWidget({super.key});

  @override
  State<SleepInsightWidget> createState() => _SleepInsightWidgetState();
}

class _SleepInsightWidgetState extends State<SleepInsightWidget> {
  final List<double> values = [
    3, 1.2, 1.0, 2.8, 2.5, 2.8, 1, 3.2, 0.3, 3.6, 1.0, 3.9, 1.0, 0.3, 3.6, 1.0, 3.9, 1.0
  ];

  String calculateAverageSleep() {
    double totalHours = values.fold(0, (sum, value) => sum + value);
    double averageHours = totalHours / values.length;

    int hours = averageHours.floor();
    int minutes = ((averageHours - hours) * 60).round();

    return "$hours hrs $minutes mins";
  }

  @override
  Widget build(BuildContext context) {
    return InsightWidgetBase(
      title: "Sleeping Insights",
      icon: Icons.nights_stay,
      values: values,
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
  final List<double> values = [
    2.5, 3.0, 1.5, 3.2, 4.0, 2.0, 1.8, 2.6, 3.0, 2.9, 3.5, 2.2
  ];

  String calculateAverageStudy() {
    double totalHours = values.fold(0, (sum, value) => sum + value);
    double averageHours = totalHours / values.length;

    int hours = averageHours.floor();
    int minutes = ((averageHours - hours) * 60).round();

    return "$hours hrs $minutes mins";
  }

  @override
  Widget build(BuildContext context) {
    return InsightWidgetBase(
      title: "Study Insights",
      icon: Icons.book,
      values: values,
      averageText: calculateAverageStudy(),
    );
  }
}

class SocialActivityInsightWidget extends StatefulWidget {
  const SocialActivityInsightWidget({super.key});

  @override
  State<SocialActivityInsightWidget> createState() => _SocialActivityInsightWidgetState();
}

class _SocialActivityInsightWidgetState extends State<SocialActivityInsightWidget> {
  final List<double> values = [
    1.5, 2.0, 2.2, 3.0, 3.1, 2.5, 1.0, 2.8, 1.6, 3.0, 2.7, 2.3
  ];

  String calculateAverageSocial() {
    double totalHours = values.fold(0, (sum, value) => sum + value);
    double averageHours = totalHours / values.length;

    int hours = averageHours.floor();
    int minutes = ((averageHours - hours) * 60).round();

    return "$hours hrs $minutes mins";
  }

  @override
  Widget build(BuildContext context) {
    return InsightWidgetBase(
      title: "Social Activity Insights",
      icon: Icons.group,
      values: values,
      averageText: calculateAverageSocial(),
    );
  }
}

class PhysicalActivityInsightWidget extends StatefulWidget {
  const PhysicalActivityInsightWidget({super.key});

  @override
  State<PhysicalActivityInsightWidget> createState() => _PhysicalActivityInsightWidgetState();
}

class _PhysicalActivityInsightWidgetState extends State<PhysicalActivityInsightWidget> {
  final List<double> values = [
    1.0, 2.5, 1.8, 3.0, 2.2, 3.5, 2.0, 2.8, 1.5, 3.2, 2.7, 3.0
  ];

  String calculateAveragePhysical() {
    double totalHours = values.fold(0, (sum, value) => sum + value);
    double averageHours = totalHours / values.length;

    int hours = averageHours.floor();
    int minutes = ((averageHours - hours) * 60).round();

    return "$hours hrs $minutes mins";
  }

  @override
  Widget build(BuildContext context) {
    return InsightWidgetBase(
      title: "Physical Activity Insights",
      icon: Icons.fitness_center,
      values: values,
      averageText: calculateAveragePhysical(),
    );
  }
}

class OthersInsightWidget extends StatefulWidget {
  const OthersInsightWidget({super.key});

  @override
  State<OthersInsightWidget> createState() => _OthersInsightWidgetState();
}

class _OthersInsightWidgetState extends State<OthersInsightWidget> {
  final List<double> values = [
    0.8, 1.5, 1.0, 2.0, 2.8, 1.2, 1.5, 2.6, 1.8, 2.9, 1.0, 2.4
  ];

  String calculateAverageOthers() {
    double totalHours = values.fold(0, (sum, value) => sum + value);
    double averageHours = totalHours / values.length;

    int hours = averageHours.floor();
    int minutes = ((averageHours - hours) * 60).round();

    return "$hours hrs $minutes mins";
  }

  @override
  Widget build(BuildContext context) {
    return InsightWidgetBase(
      title: "Other Activities Insights",
      icon: Icons.miscellaneous_services,
      values: values,
      averageText: calculateAverageOthers(),
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
          // Header Row
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          // Average Row (calculated dynamically)
          Row(
            children: [
              const Text("Average ", style: TextStyle(color: Colors.white, fontSize: 20)),
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
          // Bar Chart
          Expanded(
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
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
                            style: const TextStyle(color: Colors.white, fontSize: 12),
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
                        int day = value.toInt() + 1;
                        return Text(
                          '$day',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
