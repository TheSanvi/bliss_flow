import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  Database? _database;
  String selectedMood = "Happy";
  int streakCount = 0;
  TextEditingController journalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'journal.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE journal(id INTEGER PRIMARY KEY, mood TEXT, entry TEXT, date TEXT, streak INTEGER)",
        );
      },
      version: 1,
    );
    _loadStreak();
  }

  Future<void> _loadStreak() async {
    final List<Map<String, dynamic>> maps = await _database!.query('journal');
    if (maps.isNotEmpty) {
      setState(() {
        streakCount = maps.last['streak'] ?? 0;
      });
    }
  }

  Future<void> _saveJournalEntry() async {
    await _database!.insert(
      'journal',
      {
        'mood': selectedMood,
        'entry': journalController.text,
        'date': DateTime.now().toString(),
        'streak': streakCount + 1,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    setState(() {
      streakCount++;
    });
  }

  String _getReflectionPrompt() {
    switch (selectedMood) {
      case 'Excited':
        return "What are you excited about?";
      case 'Happy':
        return "What made you smile today?";
      case 'Calm':
        return "What brought you peace today?";
      case 'Sad':
        return "What's troubling you today?";
      case 'Stressed':
        return "What's been on your mind lately?";
      default:
        return "How was your day?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monday',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Text(
                        'February 10, 2025',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Mood Selection
              Text('How are you feeling today?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['Excited', 'Happy', 'Calm', 'Sad', 'Stressed']
                    .map((mood) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMood = mood;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: selectedMood == mood
                              ? Colors.blue.shade100
                              : Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.sentiment_satisfied_alt,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(mood),
                    ],
                  ),
                ))
                    .toList(),
              ),
              SizedBox(height: 24),

              // Journal Entry
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Reflection',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _getReflectionPrompt(),
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    TextField(
                      controller: journalController,
                      maxLines: 5,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Streak Tracking
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Writing Stats',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Words today',
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text('${journalController.text.split(" ").length}',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.favorite, color: Colors.red, size: 16),
                          SizedBox(width: 4),
                          Text('$streakCount day streak',
                              style: TextStyle(color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _saveJournalEntry,
                  child: Text('Save Entry'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
