import 'package:flutter/material.dart';
import 'package:srs_app/Widgets/taskwidget.dart';
import 'package:srs_app/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _TaskspageState();
}

class _TaskspageState extends State<HomePage> {
  bool isLoading = true;
  int tasklength = 0;
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _fetchUserDetails();
    
  }
    final ApiService api = ApiService();

  Future<void> _fetchUserDetails() async {
    try {
      final userDetails = await api.getUserDetails();
      print(userDetails);

      if (userDetails != null && userDetails['success']) {
        setState(() {
          userName = userDetails['user']?['Fname'] + ' ' + userDetails['user']?['Lname'] ?? 'No name';
        });
      } else {
        setState(() {
          userName = 'Error loading name';
        });
      }
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        userName = 'Error';
      });
    }
  }


  Future<void> _loadTasks() async {
  final apiService = ApiService(); // Assuming this is the service with the function
  final response = await apiService.getSchedule();
  print("API Response: $response"); // Debugging output
  print('test');
  print('rr');
  if (response['success'] == true) {
    // Print the retrieved data
    print('object');
    print("Tasks Data: ${response['tasks_scheduled']}");
    setState(() {
      TaskData.alltasks = (response['tasks_scheduled'] as List).map((task) {
        // ... your existing code to parse each task ...

        // For example:
        Color taskColor;
        switch (task['Type']) {
          case 'Study':
            taskColor = Colors.blue;
            break;
          case 'Physical':
            taskColor = Colors.green;
            break;
          case 'Social':
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

        // Ensure task['TaskPriority'] is not null and is a valid integer
        int taskPriority = task['TaskPriority'] != null
            ? int.tryParse(task['TaskPriority'].toString()) ?? 0
            : 0;
        print("Task Priority: $taskPriority");

        // Ensure task['Type'] is not null and is a valid string
        String taskType = task['Type'] != null ? task['Type'].toString() : '';
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
      tasklength = TaskData.alltasks.length;
      print("All Tasks: ${TaskData.alltasks}");
      isLoading = false;
    });
  } else {
    print("Error: ${response['message']}"); // In case of an error
    setState(() {
      isLoading = false;
    });
  }
}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24282e),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              // Greeting Text
             Text(
                "Hello $userName",
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Task Count and Logo Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "You've got",
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$tasklength Tasks Today",
                        style: const TextStyle(
                          fontSize: 36,
                          color: Color(0xFF50b484),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/small_white_logo.png',
                    height: 120,
                    width: 100,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Task Containers List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: TaskData.alltasks.length,
                itemBuilder: (context, index) {
                  late TaskItem task;
                  task = TaskData.alltasks[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TaskContainer(
                      taskName: task.name,
                      color: task.color,
                    ),
                  );
                },
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to the RecommendationsPage
                    Navigator.pushNamed(context, '/recommendations');
                  },
                  child: Container(
                    width: 300, // Automatically adjusts to parent width
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF24282e), // Navy blue color
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                      border: Border.all(color: Colors.pink, width: 2),
                    ),
                    child: const Center(
                      child: Text(
                        "Reccomendations",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Bottom Navigation Bar
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xFF384454),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
                icon: Icons.home_outlined, label: 'Home', isActive: true),
            BottomNavItem(icon: Icons.task_outlined, label: 'Tasks'),
            BottomNavItem(icon: Icons.access_time_outlined, label: 'Pomo'),
            BottomNavItem(icon: Icons.menu_book_outlined, label: 'Log'),
            BottomNavItem(icon: Icons.person_outline, label: 'Me'),
          ],
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            // Navigate to the respective page
            if (label == 'Home') {
              Navigator.pushNamed(context, '/homepage');
            } else if (label == 'Tasks') {
              Navigator.pushNamed(context, '/taskspage');
              print("Tasks");
            } else if (label == 'Pomo') {
              Navigator.pushNamed(context, '/pomo');
            } else if (label == 'Log') {
              Navigator.pushNamed(context, '/insights');
              print("Log");
            } else if (label == 'Me') {
              Navigator.pushNamed(context, '/profile');
            }
          },
          child: Icon(
            icon,
            color: isActive ? Colors.green : Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: isActive ? Colors.green : Colors.white),
        ),
      ],
    );
  }
}
