import 'package:flutter/material.dart';
import 'package:soulscribe/pages/const/colors.dart';
import 'package:soulscribe/pages/drawer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AddDiary extends StatefulWidget {
  const AddDiary({super.key});

  @override
  State<AddDiary> createState() => _AddDiaryState();
}

class _AddDiaryState extends State<AddDiary> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _moodController = TextEditingController();
  final TextEditingController _gratitudeController = TextEditingController();
  final TextEditingController _goalsController = TextEditingController();

  late Database _database;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'diary.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE diary(id INTEGER PRIMARY KEY, date TEXT, title TEXT, body TEXT, mood TEXT, gratitude TEXT, goals TEXT)');
      },
      version: 1,
    );
  }

  Future<void> _saveDiaryEntry() async {
    final date = DateTime.now().toIso8601String();
    final title = _titleController.text;
    final body = _bodyController.text;
    final mood = _moodController.text;
    final gratitude = _gratitudeController.text;
    final goals = _goalsController.text;

    await _database.insert(
      'diary',
      {
        'date': date,
        'title': title,
        'body': body,
        'mood': mood,
        'gratitude': gratitude,
        'goals': goals,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(content: Text('Diary entry saved!')),
    );

    _clearFields();
  }

  void _clearFields() {
    _titleController.clear();
    _bodyController.clear();
    _moodController.clear();
    _gratitudeController.clear();
    _goalsController.clear();
  }

  void _cancelDiaryEntry() {
    Navigator.pop(context as BuildContext); // Close the page and return to the previous one
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 212, 162),
                Color.fromARGB(255, 255, 212, 162),
                Color.fromARGB(255, 129, 255, 240),
              ], // Define gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: const Text(
              'Add Diary',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0, // Remove the shadow to ensure smooth gradient
            backgroundColor:
                Colors.transparent, // Ensure the AppBar uses the gradient
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _bodyController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Body',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _moodController,
                decoration: const InputDecoration(
                  labelText: 'Mood',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _gratitudeController,
                decoration: const InputDecoration(
                  labelText: 'Gratitude',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _goalsController,
                decoration: const InputDecoration(
                  labelText: 'Goals for Tomorrow',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _saveDiaryEntry,
                      style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 147, 232, 255), // Red color for cancel
                      ),
                      child: const Text('  Save  '),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _cancelDiaryEntry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 154, 147), // Red color for cancel
                      ),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _moodController.dispose();
    _gratitudeController.dispose();
    _goalsController.dispose();
    super.dispose();
  }
}
