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
  static List<TaskItem> alltasks = [];

}

class TaskItem {
  final int id;
  final String name;
  final String description;
  final int taskpriority;
  final String tasktype;
  Color color;

  TaskItem(this.id, this.name, this.description, this.taskpriority, this.tasktype, {this.color = Colors.red});
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
