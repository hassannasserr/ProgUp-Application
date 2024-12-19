import 'package:flutter/material.dart';
import 'package:srs_app/Widgets/taskwidget.dart';

class Taskspage extends StatefulWidget {
  const Taskspage({super.key});

  @override
  State<Taskspage> createState() => _TaskspageState();
}

class _TaskspageState extends State<Taskspage> {
  // List of tasks
  final List<TaskContainer> tasks = [
    TaskContainer(taskName: "Task 1"),
    TaskContainer(taskName: "Task 2"),
    TaskContainer(taskName: "Task 3"),
    TaskContainer(taskName: "Task 4"),
    TaskContainer(taskName: "Task 5"),
  ];

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
                        "5 Tasks Today",
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
                    width: 120,
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
    );
  }
}
