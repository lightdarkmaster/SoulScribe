import 'package:flutter/material.dart';


const headerColor = Colors.blue;

class GradientColors {
  static const List<Color> gradient1 = [
    Color.fromARGB(255, 136, 202, 255),
    Color.fromARGB(255, 241, 160, 255),
  ];

  static const List<Color> gradient2 = [
    Color.fromARGB(255, 255, 210, 143),
    Color.fromARGB(255, 255, 166, 159),
  ];

  static const List<Color> gradient3 = [
    Color.fromARGB(255, 162, 255, 166),
    Color.fromARGB(255, 255, 246, 165),
  ];

  static const List<Color> gradient4 = [
    Color.fromARGB(255, 255, 180, 205),
    Color.fromARGB(255, 176, 188, 255),
  ];

  // Add more gradients as needed
static const List<List<Color>> gradients = [gradient1, gradient2, gradient3, gradient4];

}
