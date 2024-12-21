import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wakeuppage extends StatefulWidget {
  const Wakeuppage({super.key});

  @override
  State<Wakeuppage> createState() => _SleepTimePageState();
}

class _SleepTimePageState extends State<Wakeuppage> {
  int selectedHour = 6;
  int selectedMinute = 0;
  int selectedSecond = 0;
  String selectedPeriod = "PM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24282e),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo_main.png',
                  height: 300,
                  width: 400,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Please let us know when did you Wake UP today",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AbhayaLibre',                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Set Time",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: CupertinoPicker(
                      itemExtent: 50,
                      scrollController: FixedExtentScrollController(
                          initialItem: selectedHour - 1),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedHour = index + 1;
                        });
                      },
                      children: List.generate(
                        12,
                        (index) => Center(
                          child: Text(
                            "${index + 1}".padLeft(2, '0'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    ":",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(
                    width: 50,
                    child: CupertinoPicker(
                      itemExtent: 50,
                      scrollController:
                          FixedExtentScrollController(initialItem: 0),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedMinute = index;
                        });
                      },
                      children: List.generate(
                        60,
                        (index) => Center(
                          child: Text(
                            index.toString().padLeft(2, '0'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    ":",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(
                    width: 50,
                    child: CupertinoPicker(
                      itemExtent: 50,
                      scrollController:
                          FixedExtentScrollController(initialItem: 0),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedSecond = index;
                        });
                      },
                      children: List.generate(
                        60,
                        (index) => Center(
                          child: Text(
                            index.toString().padLeft(2, '0'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: CupertinoPicker(
                      itemExtent: 50,
                      scrollController: FixedExtentScrollController(
                          initialItem: selectedPeriod == "AM" ? 0 : 1),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedPeriod = index == 0 ? "AM" : "PM";
                        });
                      },
                      children: const [
                        Center(
                          child: Text(
                            "AM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "PM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white, width: 0.15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedHour = 6;
                      selectedMinute = 0;
                      selectedSecond = 0;
                      selectedPeriod = "AM";
                    });
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 70, 175, 98),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    print(
                        "Selected Time: $selectedHour:${selectedMinute.toString().padLeft(2, '0')}:${selectedSecond.toString().padLeft(2, '0')} $selectedPeriod");
                        Navigator.pushNamed(context, '/stresspage');
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
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
