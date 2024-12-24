import 'package:flutter/material.dart';
import 'package:srs_app/api_service.dart';
import 'package:srs_app/Widgets/taskwidget.dart';

class SocialActivityPage extends StatefulWidget {
  @override
  State<SocialActivityPage> createState() => _SocialActivityPageState();
}

class _SocialActivityPageState extends State<SocialActivityPage> {
  int socialHours = 0;
  int stressLevel = 0; // Default value for stress level (0 = Stressed)
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    // Getting arguments from the route and ensuring it's not null, if null, using default values
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final int sleepHour = args?['sleepHour'] ?? 8; // Default to 8 if null
    final int sleepMinute = args?['sleepMinute'] ?? 0; // Default to 0 if null
    final String sleepPeriod =
        args?['sleepPeriod'] ?? 'AM'; // Default to 'AM' if null

    final int wakeUpHour = args?['wakeUpHour'] ?? 7; // Default to 7 if null
    final int wakeUpMinute = args?['wakeUpMinute'] ?? 0; // Default to 0 if null
    final String wakeUpPeriod =
        args?['wakeUpPeriod'] ?? 'AM'; // Default to 'AM' if null

    String formatTime(int hour, int minute, String period) {
      return '$hour:${minute.toString().padLeft(2, '0')} $period';
    }

    String asleepTime = formatTime(sleepHour, sleepMinute, sleepPeriod);
    String awakeTime = formatTime(wakeUpHour, wakeUpMinute, wakeUpPeriod);

    // List of stress levels in text (Low, Moderate, High)
    final List<String> stressLevels = ["Low", "Moderate", "High"];

    // Images for stress levels
    final List<String> stressImages = [
      "assets/images/stressed.png",
      "assets/images/calm.png",
      "assets/images/motivated.png",
    ];

    // Labels for stress levels
    final List<String> stressLabels = [
      'Stressed', // Stressed
      'Calm', // Calm
      'Motivated', // Motivated
    ];

    // Map for mapping user selection to stress levels
    final Map<int, String> stressMap = {
      0: "High", // Stressed -> High
      1: "Moderate", // Calm -> Moderate
      2: "Low", // Motivated -> Low
    };

    return Scaffold(
      backgroundColor: const Color(0xFF24282e),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const Text(
              "How do you feel today?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display image based on stress level
                Image.asset(
                  stressImages[stressLevel],
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),
                Text(
                  stressLabels[stressLevel],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Slider(
                    value: stressLevel.toDouble(),
                    min: 0,
                    max: 2,
                    divisions: 2,
                    onChanged: (value) {
                      setState(() {
                        stressLevel = value.toInt();
                      });
                    },
                    activeColor: const Color.fromARGB(255, 70, 175, 98),
                    inactiveColor: Colors.white38,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 11, vertical: 0),
              child: Text(
                "Share your activity hours!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (socialHours > 0) socialHours--;
                    });
                  },
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "$socialHours",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (socialHours < 10) socialHours++;
                    });
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF46AF62),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () async {
                // Use the stressMap to get the appropriate stress level text
                String selectedStressLevel = stressMap[stressLevel] ?? "Low";
                print(
                    "Social Hours: $socialHours, Stress Level: $selectedStressLevel");

                final result = await api.addActivity(
                  asleepTime,
                  awakeTime,
                  selectedStressLevel, // Pass the selected stress level text
                  socialHours.toString(),
                );

                if (result['success']) {
                  final predictions = await api.createSchedule();

                  if (predictions['success']) {
                    bool isLoading = true;
                    setState(() {
                      TaskData.alltasks =
                          (predictions['tasks_scheduled'] as List).map((task) {
                        Color taskColor;
                        switch (task['Type']) {
                          case 'Study':
                            taskColor = Colors.blue;
                            break;
                          case 'Social':
                            taskColor = Colors.green;
                            break;
                          case 'Work':
                            taskColor = Colors.red;
                            break;
                          default:
                            taskColor = Colors.grey;
                        }

                        // Ensure task['TaskID'] is not null and is a valid integer
                        int taskId = task['TaskID'] != null
                            ? int.tryParse(task['TaskID'].toString()) ?? 0
                            : 0;
                        print("Task ID: $taskId");

                        // Ensure task['TaskName'] is not null and is a valid string
                        String taskName = task['TaskName'] != null
                            ? task['TaskName'].toString()
                            : 'Unnamed Task';
                        print("Task Name: $taskName");

                        // Ensure task['TaskDetails'] is not null and is a valid string
                        String taskDescription = task['TaskDetails'] != null
                            ? task['TaskDetails'].toString()
                            : '';
                        print("Task Description: $taskDescription");

                        // Ensure task['Taskpriority'] is not null and is a valid integer
                        int taskPriority = task['Taskpriority'] != null
                            ? int.tryParse(task['Taskpriority'].toString()) ?? 0
                            : 0;
                        print("Task Priority: $taskPriority");

                        // Ensure task['Type'] is not null and is a valid string
                        String taskType =
                            task['Type'] != null ? task['Type'].toString() : '';
                        print("Task Type: $taskType");

                        return TaskItem(
                          taskId,
                          taskName,
                          taskDescription,
                          taskPriority,
                          taskType,
                          color: taskColor,
                        );
                      }).toList();
                      isLoading = false;
                    });

                    // Show the predicted tasks finished in a dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Predictions"),
                          content: Text(
                              "Number of Predicted Tasks Finished: ${predictions['predicted_tasks_finished']}"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pushNamed(context, '/homepage');
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (predictions['action_required'] == 'add_tasks') {
                    // Handle the case where no tasks are available to schedule
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("No Tasks Available"),
                          content: Text(
                              "the number of tasks you can do is ${predictions['predicted_tasks_finished']} You have no tasks to schedule. Would you like to add tasks?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pushNamed(context, '/taskspage');
                              },
                              child: const Text("Add Tasks"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Handle other errors
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: Text(predictions['message']),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  // Handle error (e.g., show a dialog with the error message)
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: Text(result['message']),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text(
                "Start Scheduling",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
