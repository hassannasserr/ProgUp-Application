import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:srs_app/api_service.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  final ApiService api = ApiService();

  Future<void> _fetchUserDetails() async {
    try {
      final userDetails = await api.getUserDetails();
      print(userDetails);

      if (userDetails != null && userDetails['success']) {
        setState(() {
          userName = userDetails['user']?['Fname'] + ' ' + userDetails['user']?['Lname'] ?? 'No name';
          userEmail = userDetails['user']?['Email'] ?? 'No email';
        });
      } else {
        setState(() {
          userName = 'Error loading name';
          userEmail = 'Error loading email';
        });
      }
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        userName = 'Error';
        userEmail = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24282e),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            // Profile header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poetsen',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Image.asset(
                    'assets/images/small_white_logo.png',
                    height: 50,
                    width: 50,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            // Profile picture
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white10,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Name and Email with lines
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Text(
                    userName.isEmpty ? 'Loading...' : 'Name : ' + userName,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontFamily: 'Poetsen',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: Colors.white70,
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    userEmail.isEmpty ? 'Loading...' : 'Email: ' + userEmail,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontFamily: 'Poetsen',

                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: Colors.white70,
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Action buttons
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/changepass');
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontFamily: 'Poetsen',

                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        // Handle logout functionality
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontFamily: 'Poetsen',

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        focusNode: _focusNode,
        obscureText: widget.isPassword && _isObscured,
        keyboardType: widget.inputType,
        readOnly: true,
        decoration: InputDecoration(
          //change text color
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Icon(widget.icon),
          hintText: widget.hint,
          labelText: widget.label,
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _isObscured ? Icons.visibility_off : Icons.visibility,
              color: _isFocused ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 20),
          ],
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
    return GestureDetector(
      onTap: () {
        // Navigate to the respective page
        if (label == 'Home') {
          Navigator.pushNamed(context, '/homepage');
        } else if (label == 'Tasks') {
          Navigator.pushNamed(context, '/taskspage');
        } else if (label == 'Pomo') {
          Navigator.pushNamed(context, '/pomo');
        } else if (label == 'Log') {
          Navigator.pushNamed(context, '/insights');
        } else if (label == 'Me') {
          Navigator.pushNamed(context, '/profile');
        }
      },
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
