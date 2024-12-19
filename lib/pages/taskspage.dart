import 'package:flutter/material.dart';

class Taskspage extends StatefulWidget {
  const Taskspage({super.key});

  @override
  State<Taskspage> createState() => _TaskspageState();
}

class _TaskspageState extends State<Taskspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF24282e),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            children: [
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.only(right: 260.0),
                child: Text("Hello Abdo",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
              ),
              
                 Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:60.0),
                          child: Text("You've got",
                              style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                 Text("5 Tasks Today",
                      style: TextStyle(
                          fontSize: 36,
                          color: Color(0xFF50b484),
                          fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(width: 5),
                    Image.asset(
                      'assets/images/small_white_logo.png',
                      height: 120,
                      width: 150,
                    ),
                  ],
                ),
             
              
            ],
          ),
        ),
      ),
    );
  }
}
