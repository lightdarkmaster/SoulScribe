import 'package:flutter/material.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({super.key});

  bool _isDay() {
    final currentHour = DateTime.now().hour;
    return currentHour >= 6 && currentHour < 18; // Day is between 6:00 AM and 6:00 PM  18
  }

  @override
  Widget build(BuildContext context) {
    final isDay = _isDay();
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width, // Full screen width
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDay
                ? [const Color(0xFFFFF176), const Color(0xFFFFD54F)] // Daytime gradient (light yellow)
                : [const Color(0xFF512DA8), const Color(0xFF673AB7)], // Evening gradient (purple tones)
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isDay ? Icons.wb_sunny_rounded : Icons.nights_stay_rounded,
              size: 48.0,
              color: isDay ? Colors.orange : Colors.white,
            ),
            const SizedBox(height: 8.0),
            Text(
              isDay ? "Greetings!" : "Good Evening!",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: isDay ? Colors.black : Colors.white,
                fontFamily: 'Swansea',
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              isDay
                  ? "Hope you have a bright and wonderful day!"
                  : "Relax and enjoy your peaceful evening!",
              style: TextStyle(
                fontSize: 15.0,
                color: isDay ? Colors.black87 : Colors.white70,
                fontFamily: 'Swansea',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
