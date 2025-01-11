import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:srs_app/Widgets/taskwidget.dart';
import 'package:srs_app/api_service.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }
  Future<void> _loadTasks() async {
    final apiService = ApiService();
    final response = await apiService.createSchedule();

    if (response['success'] == true) {
      setState(() {
        TaskData.alltasks = (response['tasks_scheduled']!=null?response['tasks_scheduled'] as List:[]).map((task) {
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

          // Ensure task['id'] is not null and is a valid integer
          int taskId = task['TaskID'] != null
              ? int.tryParse(task['TaskID'].toString()) ?? 0
              : 0;
          print("Task ID: $taskId");

          // Ensure task['name'] is not null and is a valid string
          String taskName = task['TaskName'] != null
              ? task['TaskName'].toString()
              : 'Unnamed Task';
          print("Task Name: $taskName");

          // Ensure task['description'] is not null and is a valid string
          String taskDescription =
              task['TaskDetails'] != null ? task['TaskDetails'].toString() : '';
          print("Task Description: $taskDescription");

          // Ensure task['priority'] is not null and is a valid integer
          int taskPriority = task['Taskpriority'] != null
              ? int.tryParse(task['Taskpriority'].toString()) ?? 0
              : 0;
          print("Task Priority: $taskPriority");

          // Ensure task['type'] is not null and is a valid string
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
        
        print("All Tasks: ${TaskData.alltasks}");
        isLoading = false;
       
      });
       } else {
      print("Error: ${response['message']}");
      setState(() {
        isLoading = false;
      });
    }
  }
 /* Future<void> _loadTasks() async {
    final apiService = ApiService(); // Assuming this is the service with the function
    final response = await apiService.getTasks();

    if (response['success'] == true) {
      // Print the retrieved data
      print("Tasks Data: ${response['tasks']}");
      setState(() {
        TaskData.alltasks = (response['tasks'] as List).map((task) {
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

          // Ensure task['id'] is not null and is a valid integer
          int taskId = task['TaskID'] != null ? int.tryParse(task['TaskID'].toString()) ?? 0 : 0;
          print("Task ID: $taskId");

          // Ensure task['name'] is not null and is a valid string
          String taskName = task['TaskName'] != null ? task['TaskName'].toString() : 'Unnamed Task';
          print("Task Name: $taskName");

          // Ensure task['description'] is not null and is a valid string
          String taskDescription = task['TaskDetails'] != null ? task['TaskDetails'].toString() : '';
          print("Task Description: $taskDescription");

          // Ensure task['priority'] is not null and is a valid integer
          int taskPriority = task['Taskpriority'] != null ? int.tryParse(task['Taskpriority'].toString()) ?? 0 : 0;
          print("Task Priority: $taskPriority");

          // Ensure task['type'] is not null and is a valid string
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
        print("All Tasks: ${TaskData.alltasks}");
        isLoading = false;
      });
    } else {
      print("Error: ${response['message']}"); // In case of an error
      setState(() {
        isLoading = false;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    // الحصول على التاريخ الحالي
    String currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // التاريخ وكلمة "Today" على اليسار
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentDate,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      // زر "Add Task" على اليمين
                      ElevatedButton.icon(
                        onPressed: () {
                          // أضف وظيفة عند الضغط على الزر
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AddTaskDialog();
                            },
                          ).then((_) {
                            _loadTasks(); // Reload tasks after adding a new task
                          });
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Add Task',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // لون الزر الأخضر
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // حواف دائرية
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // شريط الأيام
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      7,
                      (index) => Column(
                        children: [
                          Text(
                            [
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat',
                              'Sun'
                            ][index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: index == 3
                                  ? Colors.green
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              (14 + index).toString(),
                              style: TextStyle(
                                color: index == 3 ? Colors.white : Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // قائمة المهام
                isLoading
                    ? const CircularProgressIndicator()
                    : ListView.builder(
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
                              taskid: task.id,
                              onDelete: () {
                                setState(() {
                                  TaskData.alltasks.removeAt(index);
                                });
                              },
                              onClose: () {
                                // Add your onClose logic here
                              },
                            ),
                          );
                        },
                      ),

                // شريط التنقل السفلي
              ],
            ),
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
            BottomNavItem(icon: Icons.home_outlined, label: 'Home'),
            BottomNavItem(
                icon: Icons.task_outlined, label: 'Tasks', isActive: true),
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
              print("Promo");
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

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  String taskName = '';
  String taskType = '';
  String taskDetails = '';
  DateTime? taskDeadline;
  int? taskPriority;

  final List<String> taskTypes = ['Study', 'Social', 'Physical', 'Others'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width *
            0.8, // Set the width to 80% of the screen width
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF384454),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add Task',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    style: const TextStyle(
                        color:
                            Colors.white), // Set the input text color to white
                    decoration: const InputDecoration(
                      labelText: 'Task Name',
                      labelStyle: TextStyle(
                          color: Colors
                              .white), // Set the label text color to white
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Set the underline color to white
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Set the underline color to white when focused
                      ),
                    ),
                    onSaved: (value) {
                      taskName = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a task name';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: taskType.isEmpty ? null : taskType,
                    borderRadius: BorderRadius.circular(20.0),
                    //change the color of the dropdown menu border

                    items: taskTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type,
                            style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    dropdownColor: const Color(
                        0xFF384454), // Set the background color of the dropdown menu
                    decoration: const InputDecoration(
                      labelText: 'Task Type',
                      labelStyle: TextStyle(
                          color: Colors
                              .white), // Set the label text color to white
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Set the underline color to white
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Set the underline color to white when focused
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        taskType = value ?? '';
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a task type';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    style: const TextStyle(
                        color:
                            Colors.white), // Set the input text color to white
                    decoration: const InputDecoration(
                      labelText: 'Task Details',
                      labelStyle: TextStyle(
                          color: Colors
                              .white), // Set the label text color to white
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Set the underline color to white
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Set the underline color to white when focused
                      ),
                    ),
                    onSaved: (value) {
                      taskDetails = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter task details';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    style: const TextStyle(
                        color:
                            Colors.white), // Set the input text color to white
                    decoration: const InputDecoration(
                      labelText: 'Task Deadline',
                      labelStyle: TextStyle(
                          color: Colors
                              .white), // Set the label text color to white
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Set the underline color to white
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Set the underline color to white when focused
                      ),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != taskDeadline) {
                        setState(() {
                          taskDeadline = picked;
                        });
                      }
                    },
                    readOnly: true,
                    controller: TextEditingController(
                      text: taskDeadline == null
                          ? ''
                          : "${taskDeadline!.toLocal()}".split(' ')[0],
                    ),
                    validator: (value) {
                      if (taskDeadline == null) {
                        return 'Please select a task deadline';
                      }
                      return null;
                    },
                  ),
                  // ...existing code...
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Task Priority',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    value: taskPriority,
                    items: List.generate(5, (index) => index + 1)
                        .map((priority) => DropdownMenuItem(
                              value: priority,
                              child: Text(
                                priority.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        taskPriority = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please choose a priority';
                      }
                      return null;
                    },
                  ),
// ...existing code...
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // Call the addTask method from ApiService
                      final response = await ApiService().addTask(
                        taskName,
                        taskDetails,
                        taskDeadline!.toIso8601String(),
                        taskType,
                        taskPriority!,
                      );

                      if (response['success']) {
                        // Task added successfully
                        await _updateTasks();
                        Navigator.of(context).pop();
                      } else {                        // Handle the error
                        print('Failed to add task: ${response['message']}');
                      }
                    }
                  },
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _updateTasks() async {
    final apiService = ApiService();
    final response = await apiService.createSchedule();

    if (response['success'] == true) {
      setState(() {
        TaskData.alltasks = (response['tasks_scheduled']!=null?response['tasks_scheduled'] as List:[]).map((task) {
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

          // Ensure task['id'] is not null and is a valid integer
          int taskId = task['TaskID'] != null
              ? int.tryParse(task['TaskID'].toString()) ?? 0
              : 0;
          print("Task ID: $taskId");

          // Ensure task['name'] is not null and is a valid string
          String taskName = task['TaskName'] != null
              ? task['TaskName'].toString()
              : 'Unnamed Task';
          print("Task Name: $taskName");

          // Ensure task['description'] is not null and is a valid string
          String taskDescription =
              task['TaskDetails'] != null ? task['TaskDetails'].toString() : '';
          print("Task Description: $taskDescription");

          // Ensure task['priority'] is not null and is a valid integer
          int taskPriority = task['Taskpriority'] != null
              ? int.tryParse(task['Taskpriority'].toString()) ?? 0
              : 0;
          print("Task Priority: $taskPriority");

          // Ensure task['type'] is not null and is a valid string
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
        
        print("All Tasks: ${TaskData.alltasks}");
       
      });
    } else {print("Error: ${response['message']}");
    }
  }
}
