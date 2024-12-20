import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // الحصول على التاريخ الحالي
    String currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2C),
        elevation: 0,
        title: Row(
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
      body: Column(
        children: [
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: const [
                TaskCard(title: 'Task 1', color: Color(0xFF145A32)), // لون أغمق
                TaskCard(title: 'Task 2', color: Color(0xFF1A5276)), // لون أغمق
                TaskCard(title: 'Task 3', color: Color(0xFF512E5F)), // لون أغمق
              ],
            ),
          ),
          // شريط التنقل السفلي
          BottomNavigationBar(
            backgroundColor: const Color(0xFF1E1E2C),
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
              BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Stats'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final Color color;

  const TaskCard({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          'Task details go here...',
          style: TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.check_circle, color: Colors.white),
      ),
    );
  }
}