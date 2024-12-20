import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:srs_app/Widgets/taskwidget.dart';
class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);
  @override
  _TasksPageState createState() => _TasksPageState();
}
class _TasksPageState extends State<TasksPage> {
    @override
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
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Today',
                          style: const TextStyle(
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
                        return AddTaskDialog();
                       },
                      );
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Add Task',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // لون الزر الأخضر
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // حواف دائرية
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
                            ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: index == 3 ? Colors.green : Colors.transparent,
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
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      Color containerColor;
                      if (index % 3 == 0) {
                    containerColor = Color(0xFF283c64);
                    } else if (index % 3 == 1) {
                    containerColor = Color(0xFF386454);
                    } else {
                     containerColor = Color(0xFF702c54);
                    }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TaskContainer(
                      taskName: tasks[index],
                      color: containerColor,
                    ), // TaskContainer
                      );
                    },
                  ),
                // شريط التنقل السفلي
              ],
            ),
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
            BottomNavItem(icon: Icons.home_outlined, label: 'Home'),
            BottomNavItem(icon: Icons.task_outlined, label: 'Tasks', isActive: true),
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
              Navigator.pushNamed(context, '/homepage');
            } else if (label == 'Tasks') {
              Navigator.pushNamed(context, '/taskspage');
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

class AddTaskDialog extends StatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  String taskName = '';
  String taskType = '';
  String taskDetails = '';
  DateTime? taskDeadline;

  final List<String> taskTypes = ['Study', 'Project', 'Assignment', 'Others'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // Set the width to 80% of the screen width
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF384454),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add Task', style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white), // Set the input text color to white
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                      labelStyle: TextStyle(color: Colors.white), // Set the label text color to white
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Set the underline color to white
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Set the underline color to white when focused
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
                        child: Text(type, style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    dropdownColor: Color(0xFF384454), // Set the background color of the dropdown menu
                    decoration: InputDecoration(
                      labelText: 'Task Type',
                      labelStyle: TextStyle(color: Colors.white), // Set the label text color to white
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Set the underline color to white
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Set the underline color to white when focused
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
                    style: TextStyle(color: Colors.white), // Set the input text color to white
                    decoration: InputDecoration(
                      labelText: 'Task Details',
                      labelStyle: TextStyle(color: Colors.white), // Set the label text color to white
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Set the underline color to white
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Set the underline color to white when focused
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
                    style: TextStyle(color: Colors.white), // Set the input text color to white
                    decoration: InputDecoration(
                      labelText: 'Task Deadline',
                      labelStyle: TextStyle(color: Colors.white), // Set the label text color to white
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Set the underline color to white
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Set the underline color to white when focused
                      ),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != taskDeadline) {
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
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Add your task saving logic here
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}