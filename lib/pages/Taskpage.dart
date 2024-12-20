import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:srs_app/Widgets/taskwidget.dart';
class TasksPage extends StatelessWidget {
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
