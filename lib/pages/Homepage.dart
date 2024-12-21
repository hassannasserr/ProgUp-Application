import 'package:flutter/material.dart';
import 'package:srs_app/Widgets/taskwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _TaskspageState();
}

class _TaskspageState extends State<HomePage> {
  // List of tasks
    final List<String> tasks = [
    "Task 1",
    "Task 2",
    "Task 3",
    "Task 4",
    "Task 5",
    "Task 6",
    "Task 7",
    "Task 8",
    "Task 9",
  ];
  int get taskCount => tasks.length;
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
              const Text(
                "Hello Abdo",
                style: TextStyle(
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
                        "$taskCount Tasks Today",
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
                  itemCount: TaskData.studyTasks.length +
                      TaskData.socialTasks.length +
                      TaskData.physicalTasks.length +
                      TaskData.otherTasks.length,
                  itemBuilder: (context, index) {
                    late TaskItem task;
                    if (index < TaskData.studyTasks.length) {
                      task = TaskData.studyTasks[index];
                    } else if (index <
                        TaskData.studyTasks.length +
                            TaskData.socialTasks.length) {
                      task = TaskData
                          .socialTasks[index - TaskData.studyTasks.length];
                    } else if (index <
                        TaskData.studyTasks.length +
                            TaskData.socialTasks.length +
                            TaskData.physicalTasks.length) {
                      task = TaskData.physicalTasks[index -
                          TaskData.studyTasks.length -
                          TaskData.socialTasks.length];
                    } else {
                      task = TaskData.otherTasks[index -
                          TaskData.studyTasks.length -
                          TaskData.socialTasks.length -
                          TaskData.physicalTasks.length];
                    }

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
                  borderRadius: BorderRadius.circular(20), // Rounded corners
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
              ) ,
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
            BottomNavItem(icon: Icons.home_outlined, label: 'Home', isActive: true),
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