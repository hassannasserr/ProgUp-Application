import 'package:flutter/material.dart';
import 'package:srs_app/Widgets/taskwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _TaskspageState();
}

class _TaskspageState extends State<HomePage> {
  // List of tasks
  final List<TaskContainer> tasks = [
    TaskContainer(taskName: "Task 1"),
    TaskContainer(taskName: "Task 2"),
    TaskContainer(taskName: "Task 3"),
    TaskContainer(taskName: "Task 4"),
    TaskContainer(taskName: "Task 5"),
    TaskContainer(taskName: "Task 6"),
    TaskContainer(taskName: "Task 7"),
    TaskContainer(taskName: "Task 8"),
    TaskContainer(taskName: "Task 9"),
    
  ];
  int get taskCount => tasks.length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF24282e),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70),
              // Greeting Text
              Text(
                "Hello Abdo",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Task Count and Logo Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You've got",
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$taskCount Tasks Today",
                        style: TextStyle(
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
              SizedBox(height: 20),
              // Task Containers List
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: tasks[index], // TaskContainer
                  );
                },
              ),
              Center(
                child: Container(
                   width: 300, // Automatically adjusts to parent width
                   height: 50,
                  decoration: BoxDecoration(
                   color: const Color(0xFF24282e), // Navy blue color
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  border: Border.all(color: Colors.pink, width: 2),
                 ),
                 child: Center(
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
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Bottom Navigation Bar
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFF384454),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(icon: Icons.home_outlined, label: 'Home', isActive: true),
            BottomNavItem(icon: Icons.task_outlined, label: 'Tasks'),
            BottomNavItem(icon: Icons.access_time_outlined, label: 'Promo'),
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
    Key? key,
    required this.icon,
    required this.label,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            // Navigate to the respective page
            if (label == 'Home') {
              Navigator.pushNamed(context, '/taskspage');
            } else if (label == 'Tasks') {
              //Navigator.pushNamed(context, '/taskspage');
              print("Tasks");
            } else if (label == 'Promo') {
             // Navigator.pushNamed(context, '');
             print("Promo");
            } else if (label == 'Log') {
              //Navigator.pushNamed(context, '/log');
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