import 'package:flutter/material.dart';
import 'package:srs_app/api_service.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when not needed
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 20.0), // Adjust the top padding as needed
          child: Text(
            'Change Password',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: 'Poetsen',
            ),
          ),
        ),
        backgroundColor: const Color(0xFF384454),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 20.0), // Adjust the top padding as needed
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
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
                              backgroundImage: AssetImage('assets/images/profile.jpg'),
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
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TransparentField(
                    label: 'Current password',
                    controller: currentPasswordController,
                  ),
                  const SizedBox(height: 20),
                  TransparentField(
                    label: 'New Password',
                    controller: newPasswordController,
                  ),
                  const SizedBox(height: 20),
                  TransparentField(
                    label: 'Confirm new password',
                    controller: confirmNewPasswordController,
                  ),
                  const SizedBox(height: 30),
                  ChangeButton(
                    currentPasswordController: currentPasswordController,
                    newPasswordController: newPasswordController,
                    confirmNewPasswordController: confirmNewPasswordController,
                  ),
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
  final TextEditingController controller;

  const TransparentField({
    Key? key,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.green,
      obscureText: label.toLowerCase().contains('password'),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(
          color: Colors.white54,
          fontFamily: 'Poetsen',
        ),
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
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmNewPasswordController;

   ChangeButton({
    Key? key,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmNewPasswordController,
  }) : super(key: key);

  // Initialize ApiService
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final String currentPassword = currentPasswordController.text.trim();
        final String newPassword = newPasswordController.text.trim();
        final String confirmNewPassword = confirmNewPasswordController.text.trim();

        // Optional: Add basic validation
        if (currentPassword.isEmpty || newPassword.isEmpty || confirmNewPassword.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill in all fields.')),
          );
          return;
        }

        if (newPassword != confirmNewPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('New passwords do not match.')),
          );
          return;
        }

        final result = await apiService.changePassword(
          currentPassword,
          newPassword,
          confirmNewPassword,
        );

        if (result['success']) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'])),
          );

          // Optionally, clear the text fields
          currentPasswordController.clear();
          newPasswordController.clear();
          confirmNewPasswordController.clear();

          // Navigate back to profile or another page
          Navigator.pushNamed(context, '/profile');
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'])),
          );
        }
      },
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
          fontFamily: 'Poetsen',
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  void _navigateTo(BuildContext context, String label) {
    if (label == 'Home') {
      Navigator.pushNamed(context, '/homepage');
    } else if (label == 'Tasks') {
      Navigator.pushNamed(context, '/taskspage');
    } else if (label == 'Pomo') {
      Navigator.pushNamed(context, '/pomopage');
    } else if (label == 'Log') {
      Navigator.pushNamed(context, '/logpage');
    } else if (label == 'Me') {
      Navigator.pushNamed(context, '/profile');
    }
  }

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: () => _navigateTo(context, 'Home'),
            ),
            BottomNavItem(
              icon: Icons.task_outlined,
              label: 'Tasks',
              onTap: () => _navigateTo(context, 'Tasks'),
            ),
            BottomNavItem(
              icon: Icons.access_time_outlined,
              label: 'Pomo',
              onTap: () => _navigateTo(context, 'Pomo'),
            ),
            BottomNavItem(
              icon: Icons.menu_book_outlined,
              label: 'Log',
              onTap: () => _navigateTo(context, 'Log'),
            ),
            BottomNavItem(
              icon: Icons.person_outline,
              label: 'Me',
              isActive: true,
              onTap: () => _navigateTo(context, 'Me'),
            ),
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
  final VoidCallback onTap;

  const BottomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.green : Colors.white,
          ),
          Text(
            label,
            style: TextStyle(color: isActive ? Colors.green : Colors.white),
          ),
        ],
      ),
    );
  }
}