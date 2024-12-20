import 'package:flutter/material.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF24282e),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                // logo
                children: [
                  Image.asset(
                    'assets/images/small_white_logo.png',
                    height: 80,
                    width: 80,
                  ),
                  const SizedBox(height: 10),
                  //  name and picture
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        // name
                        child: Text(
                          'SharShora Elamora',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'AbhayaLibre',
                          ),
                        ),
                      ),
                      // profile picture
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white10,
                              backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
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
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  //email field
                  ProfileField(
                    icon: Icons.email_outlined,
                    hint: 'sherryezz04@gamil',
                    label: 'Your Email',
                    inputType: TextInputType.emailAddress,
                  ),
                  //phone number field
                  ProfileField(
                    icon: Icons.phone_outlined,
                    hint: '01229933092',
                    label: 'Phone Number',
                    inputType: TextInputType.phone,
                  ),
                  //password field
                  ProfileField(
                    icon: Icons.lock_outline,
                    hint: '••••••••',
                    label: 'Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  // change password and logout buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/changepass');

                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            backgroundColor: Colors.transparent,
                            side: BorderSide(color: Colors.green),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        OutlinedButton(
                          onPressed: () {
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red),
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class ProfileField extends StatefulWidget {
  final IconData icon;
  final String hint;
  final String label;
  final bool isPassword;
  final TextInputType inputType;

  const ProfileField({
    Key? key,
    required this.icon,
    required this.hint,
    required this.label,
    this.isPassword = false,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  _ProfileFieldState createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<ProfileField> {
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        focusNode: _focusNode,
        obscureText: widget.isPassword && _isObscured,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          hintText: widget.hint,
          labelText: widget.label,
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _isObscured ? Icons.visibility_off : Icons.visibility,
              color: _isFocused ? Colors.green : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          )
              : null,
          labelStyle: TextStyle(
            color: _isFocused ? Colors.green : Colors.white70,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
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
            BottomNavItem(icon: Icons.task_outlined, label: 'Tasks'),
            BottomNavItem(icon: Icons.access_time_outlined, label: 'Promo'),
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
    Key? key,
    required this.icon,
    required this.label,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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