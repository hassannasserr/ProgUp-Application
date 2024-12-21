import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  final String taskName;
  final Color color;

  const TaskContainer({
    super.key,
    required this.taskName,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              taskName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  print('Delete $taskName');
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  print('Done $taskName');
                },
                icon: const Icon(
                  Icons.circle_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskData {
  static final List<TaskItem> alltasks = [
    TaskItem("Math Homework", Color(0xFF283c64)),
    TaskItem("Read History Chapter", Color(0xFF283c64)),
    TaskItem("Write Essay", Color(0xFF283c64)),
    TaskItem("Call John", Color(0xFF386454)),
    TaskItem("Birthday Party", Color(0xFF386454)),
    TaskItem("Volunteer Work", Color(0xFF386454)),
    TaskItem("Morning Jog", Color(0xFF702c54)),
    TaskItem("Yoga Class", Color(0xFF702c54)),
    TaskItem("Gym Workout", Color(0xFF702c54)),
    TaskItem("Grocery Shopping", Colors.grey),
    TaskItem("Car Maintenance", Colors.grey),
    TaskItem("Plan Vacation", Colors.grey),
  ];
  static final List<TaskItem> studyTasks = [
    TaskItem("Math Homework", Color(0xFF283c64)),
    TaskItem("Read History Chapter", Color(0xFF283c64)),
    TaskItem("Write Essay", Color(0xFF283c64)),
  ];

  static final List<TaskItem> socialTasks = [
    TaskItem("Call John", Color(0xFF386454)),
    TaskItem("Birthday Party", Color(0xFF386454)),
    TaskItem("Volunteer Work", Color(0xFF386454)),
  ];

  static final List<TaskItem> physicalTasks = [
    TaskItem("Morning Jog", Color(0xFF702c54)),
    TaskItem("Yoga Class", Color(0xFF702c54)),
    TaskItem("Gym Workout", Color(0xFF702c54)),
  ];

  static final List<TaskItem> otherTasks = [
    TaskItem("Grocery Shopping", Colors.grey),
    TaskItem("Car Maintenance", Colors.grey),
    TaskItem("Plan Vacation", Colors.grey),
  ];
}

class TaskItem {
  final String name;
  final Color color;

  TaskItem(this.name, this.color);
}

class TaskListView extends StatelessWidget {
  final List<TaskItem> tasks;

  const TaskListView({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TaskContainer(taskName: task.name, color: task.color),
        );
      },
    );
  }
}
