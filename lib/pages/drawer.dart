import 'package:flutter/material.dart';
import 'package:soulscribe/pages/add_diary.dart';
import 'package:soulscribe/pages/homescreen.dart'; // Ensure this import exists

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 215, 147),
              Color.fromARGB(255, 255, 215, 147),
              Color.fromARGB(255, 129, 255, 240),
            ], // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Custom header with image background
            Container(
              height: 200, // Set the height for the header
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/icons/header.gif'), // Your image here
                  fit: BoxFit.cover, // Ensures the image covers the entire space
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken), // Optional overlay for readability
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SoulScribe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ListTile with borders, spacing, and colors
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color for the ListTile
                  border: Border.all(color: Colors.grey), // Add border
                  borderRadius: BorderRadius.circular(8.0), // Optional rounded corners
                ),
                child: ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Homescreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade50, // Background color for the ListTile
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  title: const Text('Add Diary'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddDiary(),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightGreen.shade50, // Background color for the ListTile
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
