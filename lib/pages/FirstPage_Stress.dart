import 'package:flutter/material.dart';
import 'package:srs_app/api_service.dart';

class SocialActivityPage extends StatefulWidget {
  const SocialActivityPage({super.key});

  @override
  State<SocialActivityPage> createState() => _SocialActivityPageState();
}

class _SocialActivityPageState extends State<SocialActivityPage> {
  int socialHours = 0;
  int stressLevel = 0; // Default value for stress level (0 = Stressed)
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    // Getting arguments from the route and ensuring it's not null, if null, using default values
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final int sleepHour = args?['sleepHour'] ?? 8; // Default to 8 if null
    final int sleepMinute = args?['sleepMinute'] ?? 0; // Default to 0 if null
    final String sleepPeriod = args?['sleepPeriod'] ?? 'AM'; // Default to 'AM' if null

    final int wakeUpHour = args?['wakeUpHour'] ?? 7; // Default to 7 if null
    final int wakeUpMinute = args?['wakeUpMinute'] ?? 0; // Default to 0 if null
    final String wakeUpPeriod = args?['wakeUpPeriod'] ?? 'AM'; // Default to 'AM' if null

    String formatTime(int hour, int minute, String period) {
      return '$hour:${minute.toString().padLeft(2, '0')} $period';
    }

    String asleepTime = formatTime(sleepHour, sleepMinute, sleepPeriod);
    String awakeTime = formatTime(wakeUpHour, wakeUpMinute, wakeUpPeriod);

    // List of stress levels in text (Low, Moderate, High)
    final List<String> stressLevels = ["Low", "Moderate", "High"];

    // Images for stress levels
    final List<String> stressImages = [
      "assets/images/stressed.png",
      "assets/images/calm.png",
      "assets/images/motivated.png",
    ];

    // Labels for stress levels
    final List<String> stressLabels = [
      'Stressed',   // Stressed
      'Calm',       // Calm
      'Motivated',  // Motivated
    ];

    // Map for mapping user selection to stress levels
    final Map<int, String> stressMap = {
      0: "High",      // Stressed -> High
      1: "Moderate",  // Calm -> Moderate
      2: "Low",       // Motivated -> Low
    };

    return Scaffold(
      backgroundColor: const Color(0xFF24282e),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const Text(
              "How do you feel today?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display image based on stress level
                Image.asset(
                  stressImages[stressLevel],
                  width: 100, 
                  height: 100,
                ),
                const SizedBox(height: 10),
                Text(
                  stressLabels[stressLevel],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Slider(
                    value: stressLevel.toDouble(),
                    min: 0,
                    max: 2,
                    divisions: 2,
                    onChanged: (value) {
                      setState(() {
                        stressLevel = value.toInt();
                      });
                    },
                    activeColor: const Color.fromARGB(255, 70, 175, 98),
                    inactiveColor: Colors.white38,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 11, vertical: 0),
              child: Text(
                "Share your activity hours!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
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
                    color: Colors.white,
                  ),
                ),
                Text(
                  "$socialHours",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (socialHours < 10) socialHours++;
                    });
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF46AF62),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () async {
                // Use the stressMap to get the appropriate stress level text
                String selectedStressLevel = stressMap[stressLevel] ?? "Low";
                print("Social Hours: $socialHours, Stress Level: $selectedStressLevel");

                final result = await api.addActivity(
                  asleepTime,
                  awakeTime,
                  selectedStressLevel, // Pass the selected stress level text
                  socialHours.toString(),
                );

                if (result['success']) {
                  Navigator.pushNamed(context, '/homepage');
                } else {
                  // Handle error (e.g., show a dialog with the error message)
                  print(result['message']);
                }
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
