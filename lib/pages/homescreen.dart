import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soulscribe/pages/add_diary.dart';
import 'package:soulscribe/pages/drawer.dart';
import 'package:soulscribe/pages/initialCards/greetings_card.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Database _database;
  List<Map<String, dynamic>> _entries = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'diary.db'),
      version: 1,
    );
    _fetchDiaryEntries();
  }

  Future<void> _fetchDiaryEntries() async {
    final List<Map<String, dynamic>> entries = await _database.query('diary');
    print(entries); // Debugging output
    setState(() {
      _entries = entries;
    });
  }

  Future<void> _deleteEntry(int id) async {
    await _database.delete('diary', where: 'id = ?', whereArgs: [id]);
    _fetchDiaryEntries();
  }

  Future<void> _editEntry(int id, Map<String, dynamic> updatedEntry) async {
    await _database
        .update('diary', updatedEntry, where: 'id = ?', whereArgs: [id]);
    _fetchDiaryEntries();
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
            'Soul Scribe',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0, // Remove the shadow to ensure smooth gradient
          backgroundColor:
              Colors.transparent, // Ensure the AppBar uses the gradient
        ),
      ),
    ),
    drawer: const CustomDrawer(),
    body: _entries.isEmpty
        ? const Center(
            child: Text('No diary entries yet. Add some entries!'),
          )
        : ListView(
            children: [
              // Add the GreetingCard at the top
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: GreetingCard(),
              ),
              ..._entries.map((entry) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry['title'] ?? 'No Title',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry['date'] != null
                              ? DateFormat('yyyy-MM-dd – HH:mm a')
                                  .format(DateTime.parse(entry['date']))
                              : 'No Date',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry['body'] ?? 'No Content',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        if (entry['mood'] != null)
                          Text('Mood: ${entry['mood']}',
                              style: const TextStyle(fontSize: 14)),
                        if (entry['gratitude'] != null)
                          Text('Gratitude: ${entry['gratitude']}',
                              style: const TextStyle(fontSize: 14)),
                        if (entry['goals'] != null)
                          Text('Goals: ${entry['goals']}',
                              style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () async {
                                // Add navigation to an edit page or show a dialog to edit entry
                                final updatedEntry = {
                                  'title': 'Updated Title',
                                  'body': 'Updated Content',
                                  'mood': entry['mood'],
                                  'gratitude': entry['gratitude'],
                                  'goals': entry['goals'],
                                  'date': entry['date'],
                                };
                                await _editEntry(entry['id'], updatedEntry);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteEntry(entry['id']),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
    floatingActionButton: Container(
      decoration: BoxDecoration(
        shape:
            BoxShape.circle, // Ensures the border matches the circular shape
        border: Border.all(
          color: Colors.black54, // Outline color
          width: 2.0, // Thickness of the outline
        ),
      ),
      child: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDiary()),
          );
          _fetchDiaryEntries(); // Refresh entries when returning
        },
        backgroundColor: const Color.fromARGB(255, 255, 251, 21),
        shape: const CircleBorder(), // Ensures the button remains circular
        child: const Icon(Icons.add, color: Colors.black),
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  );
}

}
