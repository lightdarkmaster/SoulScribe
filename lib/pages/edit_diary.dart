import 'package:flutter/material.dart';
import 'package:soulscribe/pages/homescreen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EditDiaryScreen extends StatefulWidget {
  final Map<String, dynamic> entry;
  const EditDiaryScreen({super.key, required this.entry});

  @override
  // ignore: library_private_types_in_public_api
  _EditDiaryScreenState createState() => _EditDiaryScreenState();
}

class _EditDiaryScreenState extends State<EditDiaryScreen> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  late TextEditingController _moodController;
  late TextEditingController _gratitudeController;
  late TextEditingController _goalsController;
  late Database _database;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
    _titleController = TextEditingController(text: widget.entry['title']);
    _bodyController = TextEditingController(text: widget.entry['body']);
    _moodController = TextEditingController(text: widget.entry['mood']);
    _gratitudeController = TextEditingController(text: widget.entry['gratitude']);
    _goalsController = TextEditingController(text: widget.entry['goals']);
  }

  // Initialize the database
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

  // Update the entry in the database
  Future<void> _updateEntry(int id, Map<String, dynamic> updatedEntry) async {
    await _database.update(
      'diary',
      updatedEntry,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

Future<void> _saveEntry() async {
  final updatedEntry = {
    'title': _titleController.text,
    'body': _bodyController.text,
    'mood': _moodController.text,
    'gratitude': _gratitudeController.text,
    'goals': _goalsController.text,
    'date': widget.entry['date'], // Keep the original date
  };

  // Update the entry in the database
  await _updateEntry(widget.entry['id'], updatedEntry);

  // Navigate to another page
  Navigator.push(
    context as BuildContext,
    MaterialPageRoute(
      builder: (context) => const Homescreen(), // Replace with your target screen
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Diary Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: 'Body'),
              maxLines: 5,
            ),
            TextField(
              controller: _moodController,
              decoration: const InputDecoration(labelText: 'Mood'),
            ),
            TextField(
              controller: _gratitudeController,
              decoration: const InputDecoration(labelText: 'Gratitude'),
            ),
            TextField(
              controller: _goalsController,
              decoration: const InputDecoration(labelText: 'Goals'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEntry,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
