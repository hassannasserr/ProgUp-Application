import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SocialActivityPage extends StatefulWidget {
  @override
  State<SocialActivityPage> createState() => _SocialActivityPageState();
}

class _SocialActivityPageState extends State<SocialActivityPage> {
  int socialHours = 0;
  String stressLevel = "Low";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24282e),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Image.asset(
                'assets/images/logo_main.png',
                height: 300,
                width: 400,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 11, vertical: 0),
              child: Text(
                "If you will have social activities today, please let us know the expected hours for it",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0.01),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 49, 107, 165),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (socialHours > 0) socialHours--;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Color(0xFFA1A1A1),
                    ),
                  ),
                  Text(
                    "$socialHours",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 63, 62, 62),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        socialHours++;
                      });
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Color(0xFFA1A1A1),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "What’s your stress level today?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.symmetric(horizontal: 70),
              decoration: BoxDecoration(
                color: const Color(0xFF24282e),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 0.15),
              ),
              child: DropdownButton<String>(
                value: stressLevel,
                dropdownColor: const Color(0xFF24282e),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                isExpanded: true,
                style: const TextStyle(color: Colors.white),
                items: ["Low", "Medium", "High"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    stressLevel = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 70, 175, 98),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                print("Social Hours: $socialHours, Stress Level: $stressLevel");
                Navigator.pushNamed(context, '/homepage');
              },
              child: const Text(
                "Start Scheduling",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
