import 'package:flutter/material.dart';
import '../api_service.dart'; // Ensure this import path is correct

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // API service instance
  final ApiService api = ApiService();

  // Loading state for the button
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24282e),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section with logo and title
            Container(
              height: 400,
              width: double.infinity,
              color: const Color(0xFF384454),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Image.asset(
                      'assets/images/login.png',
                      height: 320,
                      width: 400,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(400, 100),
                            painter: TrianglePainter(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Login form fields
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // Email field
                  TextField(
                    controller: emailController, // Bind to controller
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password field
                  TextField(
                    controller: passwordController, // Bind to controller
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forget');
                        },
                        child: const Text(
                          'Forgot?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
            // 'Login' button with loading indicator
            isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : ElevatedButton(
                  onPressed: () async {
                    // Basic validation
                    if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all fields')),
                    );
                    return;
                    }

                    // Show loading indicator
                    setState(() => isLoading = true);

                    try {
                    // Try to login
                    Map<String, dynamic> result = await api.login(
                      emailController.text,
                      passwordController.text,
                    );

                    if (result['success']) {
                      // Login successful
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          result['message'] ?? 'Login successful!')),
                      );

                      // Access user data if needed
                       Map<String, dynamic> userData = result['user'];
                       bool firstLoginToday = result['firstLoginToday'];

                      // Navigate based on firstLoginToday attribute
                     if (firstLoginToday) {
      Navigator.pushReplacementNamed(context, '/sleep');
    } else {
      Navigator.pushReplacementNamed(context, '/homepage');
    }
                    } else {
                      // Login failed
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                          Text(result['message'] ?? 'Login failed')),
                      );
                    }
                    } catch (e) {
                    // Handle any errors
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                          Text('An error occurred. Please try again.')),
                    );
                    } finally {
                    // Hide loading indicator
                    setState(() => isLoading = false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF384454),
                    minimumSize: const Size(360, 50),
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),
            // Link to signup page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account? ',
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF24282e)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
