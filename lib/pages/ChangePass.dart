import 'package:flutter/material.dart';

class ChangePass extends StatelessWidget {
  const ChangePass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF384454),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context ,'/profile');
          },
        ),
      ),
      backgroundColor: const Color(0xFF24282e),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 130,
                  decoration: const BoxDecoration(
                    color: Color(0xFF384454),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/images/small_white_logo.png',
                        height: 60,
                      ),
                      const SizedBox(height: 5),
                      const Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
                            ),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.orange,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color(0xFF384454),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Column(
                children: [
                  SizedBox(height: 10),
                  TransparentField(label: 'Current password'),
                  SizedBox(height: 20),
                  TransparentField(label: 'New Password'),
                  SizedBox(height: 20),
                  TransparentField(label: 'Confirm new password'),
                  SizedBox(height: 30),
                  ChangeButton(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class TransparentField extends StatelessWidget {
  final String label;

  const TransparentField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.green,
      obscureText: label.toLowerCase().contains('password'),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white54),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}

class ChangeButton extends StatelessWidget {
  const ChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'Change',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF384454),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(icon: Icons.home_outlined, label: 'Home'),
            BottomNavItem(icon: Icons.task_outlined, label: 'Tasks'),
            BottomNavItem(icon: Icons.access_time_outlined, label: 'Pomo'),
            BottomNavItem(icon: Icons.menu_book_outlined, label: 'Log'),
            BottomNavItem(icon: Icons.person_outline, label: 'Me', isActive: true),
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
        Icon(icon, color: isActive ? Colors.green : Colors.white),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.green : Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}