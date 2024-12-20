import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  final String taskName;
  final Color color;
  // Constructor to accept the task name
  const TaskContainer({
    Key? key,
    required this.taskName,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth, // Automatically adjusts to parent width
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: color, // Navy blue color
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Task Title
          Expanded(
            child: Text(
              taskName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis, // Handles long task names
            ),
          ),
          // Icons Row
          Row(
            children: [
              // Delete Icon
              IconButton(
                onPressed: () {
                  print('Delete $taskName');
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ),
              ),
              // Circular Checkbox
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
              // Dropdown Arrow
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
