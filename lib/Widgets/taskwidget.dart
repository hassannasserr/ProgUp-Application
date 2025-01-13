import 'package:flutter/material.dart';
import 'package:srs_app/api_service.dart';

class TaskContainer extends StatelessWidget {
  final String taskName;
  Color color;
  final int taskid;
  final void Function(int) onDelete;
  final void Function(int) onClose;

  TaskContainer({
    super.key,
    required this.taskName,
    required this.color,
    required this.taskid,
    required this.onDelete,
    required this.onClose,
  });

  final ApiService api = ApiService();

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to delete this task?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                Navigator.of(context).pop();
                final result = await api.deleteTask(taskid);
                if (result['success']) {
                  onDelete(taskid);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result['message']),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result['message']),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _closeTask(BuildContext context) async {
    final result = await api.closeTask(taskid);
    if (result['success']) {
      onClose(taskid);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
        ),
      );
    }
  }

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
                  _showDeleteConfirmationDialog(context);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ),
              ),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return IconButton(
                    onPressed: () {
                      _closeTask(context);
                      setState(() {
                        color = Colors.green;
                      });
                    },
                    icon: Icon(
                      color == Colors.green ? Icons.check_circle_outline : Icons.circle_outlined,
                      color: Colors.white,
                    ),
                  );
                },
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

  TaskItem(
      this.id, this.name, this.description, this.taskpriority, this.tasktype,
      {this.color = Colors.red});
}

class TaskListView extends StatefulWidget {
  final List<TaskItem> tasks;

  const TaskListView({super.key, required this.tasks});

  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  void _deleteTask(int taskId) {
    setState(() {
      widget.tasks.removeWhere((task) => task.id == taskId);
    });
  }

  void _closeTask(int taskId) {
    setState(() {
      final task = widget.tasks.firstWhere((task) => task.id == taskId);
      task.color = Colors.green; // Change the color to indicate completion
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        final task = widget.tasks[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TaskContainer(
            taskName: task.name,
            color: task.color,
            taskid: task.id,
            onDelete: _deleteTask,
            onClose: _closeTask,
          ),
        );
      },
    );
  }
}
