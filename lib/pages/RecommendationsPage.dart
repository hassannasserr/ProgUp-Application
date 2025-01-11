import 'package:flutter/material.dart';
import 'package:srs_app/api_service.dart';
class Recommendation {
  final String text;
  final String degree;

  Recommendation({required this.text, required this.degree});
}

class RecommendationsPage extends StatefulWidget {
  final String sleepAverage;
  final String studyAverage;
  final String physicalAverage;
  final String socialAverage;
  
  const RecommendationsPage({
    super.key,
    required this.sleepAverage,
    required this.studyAverage,
    required this.physicalAverage,
    required this.socialAverage,
  });

  @override
  State<RecommendationsPage> createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  // Colors for each section
  final Map<String, Color> sectionColors = {
    "Sleep Recommendations": const Color(0xFF386454),
    "Physical Activity Recommendations": const Color(0xFF456789),
    "Study Recommendations":  Colors.green,
    "Social Activity Recommendations":  Colors.red,
  };

  final List<Recommendation> sleepRecommendations = [
    Recommendation(text: "Maintain a consistent sleep schedule.", degree: "Moderate"),
    Recommendation(text: "Avoid screens 1 hour before bedtime.", degree: "Moderate"),
    Recommendation(text: "Try relaxation techniques before sleep.", degree: "Moderate"),
    Recommendation(text: "Ensure your bedroom is dark and quiet.", degree: "High"),
    Recommendation(text: "Use a white noise machine for better sleep.", degree: "High"),
    Recommendation(text: "Increase physical activity during the day.", degree: "Low"),
    Recommendation(text: "Reduce caffeine intake in the evening.", degree: "Low"),
    Recommendation(text: "Practice deep breathing before bed.", degree: "Low"),
    Recommendation(text: "Keep your bedroom cool and ventilated.", degree: "High"),
    Recommendation(text: "Avoid heavy meals before bedtime.", degree: "High"),
];

final List<Recommendation> physicalActivityRecommendations = [
    Recommendation(text: "Walk for 30 minutes daily.", degree: "Moderate"),
    Recommendation(text: "Stretch regularly to maintain flexibility.", degree: "Moderate"),
    Recommendation(text: "Try yoga or pilates sessions.", degree: "Moderate"),
    Recommendation(text: "Incorporate strength training twice a week.", degree: "High"),
    Recommendation(text: "Join a local sports or activity club.", degree: "High"),
    Recommendation(text: "Take frequent short breaks during work.", degree: "Low"),
    Recommendation(text: "Use stairs instead of elevators.", degree: "Low"),
    Recommendation(text: "Do light stretching every morning.", degree: "Low"),
    Recommendation(text: "Participate in group fitness classes.", degree: "High"),
    Recommendation(text: "Go for a bike ride on weekends.", degree: "High"),
];

final List<Recommendation> studyRecommendations = [
    Recommendation(text: "Dedicate at least 30 minutes to review notes daily.", degree: "Moderate"),
    Recommendation(text: "Focus on one topic at a time.", degree: "Moderate"),
    Recommendation(text: "Use color-coded notes for better organization.", degree: "Moderate"),
    Recommendation(text: "Use flashcards for quick revisions.", degree: "High"),
    Recommendation(text: "Take short breaks between study sessions.", degree: "High"),
    Recommendation(text: "Break study sessions into small chunks.", degree: "Low"),
    Recommendation(text: "Review previous lessons for retention.", degree: "Low"),
    Recommendation(text: "Create a quiet and distraction-free study area.", degree: "Low"),
    Recommendation(text: "Test yourself regularly on studied topics.", degree: "High"),
    Recommendation(text: "Form a study group with peers.", degree: "High"),
];

final List<Recommendation> socialActivityRecommendations = [
    Recommendation(text: "Call a family member or friend once a week.", degree: "Low"),
    Recommendation(text: "Watch movies or shows with family at home.", degree: "Low"),
    Recommendation(text: "Play online games with friends.", degree: "Low"),
    Recommendation(text: "Join online forums or communities.", degree: "Moderate"),
    Recommendation(text: "Send messages to check on your friends.", degree: "Moderate"),
    Recommendation(text: "Participate in virtual book clubs.", degree: "Moderate"),
    Recommendation(text: "Attend occasional virtual events.", degree: "High"),
    Recommendation(text: "Plan outdoor activities with friends.", degree: "High"),
    Recommendation(text: "Host a small gathering at your place.", degree: "High"),
    Recommendation(text: "Volunteer for local community events.", degree: "High"),
];


  List<Recommendation> _filterRecommendations(List<Recommendation> recommendations, String degree) {
    return recommendations.where((rec) => rec.degree == degree).toList().take(5).toList();
  }
  String userName = '';
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
        });
      } else {
        setState(() {
          userName = 'Error loading name';
        });
      }
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        userName = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sleepFiltered = _filterRecommendations(sleepRecommendations, widget.sleepAverage);
    final studyFiltered = _filterRecommendations(studyRecommendations, widget.studyAverage);
    final physicalFiltered = _filterRecommendations(physicalActivityRecommendations, widget.physicalAverage);
    final socialFiltered = _filterRecommendations(socialActivityRecommendations, widget.socialAverage);

    return Scaffold(
      backgroundColor: const Color(0xFF24282e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF24282e),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/taskspage');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    "Hello $userName",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AbhayaLibre',
                    ),
                  ),
                  Image.asset(
                    'assets/images/small_white_logo.png',
                    height: 70,
                    width: 70,
                  ),
                ],
              ),
              const Text(
                "Here is Your Recommendations",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'AbhayaLibre',
                ),
              ),
              const SizedBox(height: 5),
              _buildSection("Sleep Recommendations", sleepFiltered),
              _buildSection("Physical Activity Recommendations", physicalFiltered),
              _buildSection("Study Recommendations", studyFiltered),
              _buildSection("Social Activity Recommendations", socialFiltered),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Recommendation> recommendations) {
    final Color color = sectionColors[title] ?? Colors.grey; //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        ...recommendations.map((rec) => _buildRecommendationCard(rec.text, color: color)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poetsen',
      ),
    );
  }

  Widget _buildRecommendationCard(String text, {Color color = const Color(0xFF283c64)}) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontFamily: 'AbhayaLibre',
        ),
      ),
    );
  }
}