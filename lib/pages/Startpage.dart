import 'package:flutter/material.dart';

class Startpage extends StatelessWidget {
  const Startpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFF24282e),
      body: Column(
        children: [
          const SizedBox(height: 350),
          Center(
            child: SizedBox(
              width: 300,
              child: Image.asset('assets/images/logo.jpg'),
            )
          ),
          const SizedBox(height: 200),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
             backgroundColor: const Color(0xFF49B583),
             minimumSize: const Size(230, 56),
             padding: const EdgeInsets.symmetric(horizontal: 50),
             
            ),
            
            child: const Text('Start', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      
    );
  }
}