import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';


class MeditationScreen extends StatefulWidget {
  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String _selectedSound = 'rain.mp3';
  final List<String> _soundOptions = ['rain.mp3', 'ocean.mp3', 'forest.mp3'];
  final List<Map<String, dynamic>> _popularMeditations = [
    {"title": "Deep Sleep", "icon": Icons.nightlight_round},
    {"title": "Morning Boost", "icon": Icons.wb_sunny},
    {"title": "Stress Release", "icon": Icons.self_improvement},
  ];

  @override
  void initState() {
    super.initState();
    _loadSessionData();
  }

  Future<void> _loadSessionData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _seconds = prefs.getInt('session_duration') ?? 0;
    });
  }

  Future<void> _saveSessionData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('session_duration', _seconds);
  }

  void _startTimer() {
    setState(() => _isRunning = true);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() => _seconds++);
      _saveSessionData();
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _seconds = 0;
    });
    _saveSessionData();
  }

  void _toggleSound() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource('sounds/$_selectedSound'));
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 18) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget _controlButton(IconData icon, VoidCallback? onPressed) {
    return IconButton(
      icon: Icon(icon, color: Colors.white, size: 36),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade900, Colors.greenAccent.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _getGreeting(),
                  style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                ),
                SizedBox(height: 20),
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 12.0,
                  percent: (_seconds % 60) / 60.0,
                  center: Text(
                    _formatTime(_seconds),
                    style: GoogleFonts.lato(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  progressColor: Colors.white,
                  backgroundColor: Colors.white24,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _controlButton(Icons.play_arrow, _isRunning ? null : _startTimer),
                    _controlButton(Icons.pause, _isRunning ? _pauseTimer : null),
                    _controlButton(Icons.stop, _stopTimer),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
