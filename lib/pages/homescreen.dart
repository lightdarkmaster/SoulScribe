import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soul Scribe', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlue,
        elevation: 8,
      ),
      body: const Center(
        child: Text('Hello Chan'),
      ),
    );
  }
}