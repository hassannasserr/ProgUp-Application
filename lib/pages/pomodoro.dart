import 'dart:async';
import 'package:flutter/material.dart';
import 'package:srs_app/Widgets/taskwidget.dart';
import 'package:srs_app/api_service.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  double sessionTime = 50;
  double breakTime = 10;
  double longBreakTime = 20;
  int sessionCount = 4; // Default session count for long break
  int completedSessions = 0;

  Duration remainingTime = const Duration(minutes: 25);
  Timer? timer;
  bool isRunning = false;
  bool isSession = true; // Track if it's session or break time

  void startTimer() {
    if (timer != null && timer!.isActive) return;

    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds <= 0) {
        timer.cancel();
        setState(() {
          isRunning = false;
        });
        handleTimerEnd(); // Handle timer completion
      } else {
        setState(() {
          remainingTime -= const Duration(seconds: 1);
        });
      }
    });
  }

  void handleTimerEnd() {
    if (isSession) {
      completedSessions++;
      if (completedSessions == sessionCount) {
        // Start long break
        remainingTime = Duration(minutes: longBreakTime.toInt());
        completedSessions = 0; // Reset completed sessions
      } else {
        // Start short break
        remainingTime = Duration(minutes: breakTime.toInt());
      }
    } else {
      // End break, start session
      remainingTime = Duration(minutes: sessionTime.toInt());
    }
    setState(() {
      isSession = !isSession; // Toggle between session and break
    });
    startTimer();
  }

  void pauseTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
      setState(() {
        isRunning = false;
      });
    }
  }

  void resetTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    setState(() {
      remainingTime = Duration(minutes: sessionTime.toInt());
      isRunning = false;
      isSession = true;
      completedSessions = 0;
    });
  }

  void pomoSettings() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF384454),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Session",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Slider(
                    value: sessionTime,
                    min: 25,
                    max: 120,
                    divisions: 95,
                    label: sessionTime.toStringAsFixed(0),
                    onChanged: (value) {
                      setDialogState(() {
                        sessionTime = value;
                      });
                      setState(() {
                        remainingTime = Duration(minutes: sessionTime.toInt());
                      });
                    },
                  ),
                  const Text(
                    "Short Break",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Slider(
                    value: breakTime,
                    min: 5,
                    max: 30,
                    divisions: 25,
                    label: breakTime.toStringAsFixed(0),
                    onChanged: (value) {
                      setDialogState(() {
                        breakTime = value;
                      });
                    },
                  ),
                  const Text(
                    "Long Break",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Slider(
                    value: longBreakTime,
                    min: 10,
                    max: 40,
                    divisions: 30,
                    label: longBreakTime.toStringAsFixed(0),
                    onChanged: (value) {
                      setDialogState(() {
                        longBreakTime = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setDialogState(() {
                            if (sessionCount > 0) sessionCount--;
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      Text(
                        sessionCount.toString(),
                        style:
                            const TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          setDialogState(() {
                            if (sessionCount < 8) sessionCount++;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Variables to store selected task name and color
  String selectedTaskName = "Select Task";
  Color selectedTaskColor = const Color(0xff49B583); // Default green color

  // Function to select task type (study or physical)
  void selectType() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF384454),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedTaskName = "Study";
                    selectedTaskColor = Colors.green; // Study button color
                  });
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Study", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedTaskName = "Physical";
                    selectedTaskColor = Colors.blue; // Physical button color
                  });
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Physical", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  Color getTimerColor() {
    if (isSession) {
      return Colors.grey; // Session: Red
    } else {
      return (completedSessions == 0)
          ? Colors.yellow
          : Colors.blue; // Long Break: Yellow, Short Break: Blue
    }
  }

  String formatDuration(Duration duration) {
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24282e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF24282e),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/homepage');
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Image.asset(
          'assets/images/small_white_logo.png',
          height: 70,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: pomoSettings,
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CircularProgressIndicator(
                    value: remainingTime.inSeconds /
                        (isSession
                            ? sessionTime * 60
                            : (completedSessions == sessionCount
                                ? longBreakTime * 60
                                : breakTime * 60)),
                    strokeWidth: 5,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(getTimerColor()),
                  ),
                ),
                Text(
                  formatDuration(remainingTime),
                  style: TextStyle(
                    color: getTimerColor(),
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 180),
                IconButton(
                  onPressed: isRunning ? pauseTimer : null,
                  icon: Icon(
                    Icons.pause,
                    color: isRunning ? Colors.white : Colors.grey,
                    size: 35,
                  ),
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: !isRunning ? startTimer : null,
                  icon: const Icon(
                    Icons.play_circle_fill_outlined,
                    color: Color(0xff49B583),
                    size: 50,
                  ),
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: resetTimer,
                  icon: const Icon(
                    Icons.stop,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            ElevatedButton(
              onPressed: selectType,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedTaskColor, // Use the selected task's color
              ),
              child: Text(
                selectedTaskName, // Use the selected task's name
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}