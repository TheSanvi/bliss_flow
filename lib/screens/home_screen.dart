import 'package:bliss_flow/screens/emergency_screen.dart';
import 'package:bliss_flow/screens/hydration_screen.dart';
import 'package:bliss_flow/screens/journaling_screen.dart';
import 'package:bliss_flow/screens/profile_screen.dart';
import 'package:bliss_flow/screens/settings_screen.dart';
import 'package:bliss_flow/screens/sleep_tracking_Screen.dart';
import 'package:flutter/material.dart';
import 'package:bliss_flow/widgets/bottom_nav_bar.dart';
import 'package:bliss_flow/screens/mood_screen.dart';

import 'package:bliss_flow/screens/meditation_screen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreenContent(),
    MoodScreen(),
    ProfileScreen(),
    SettingsScreen(),
    EmergencyScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

// ✅ Home Screen Content
class HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                    const Text(
                      'Good evening',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Monday, February 10',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('https://placeholder.com/user'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Mood Tracker
            _buildSectionTitle('How are you feeling today?'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _containerDecoration(const Color(0xFF7C4DFF).withOpacity(0.1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMoodIcon('😊', 'Great'),
                  _buildMoodIcon('🙂', 'Good'),
                  _buildMoodIcon('😐', 'Okay'),
                  _buildMoodIcon('😔', 'Down'),
                  _buildMoodIcon('😢', 'Awful'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quote Card
            _buildSectionTitle('Daily Motivation'),
            _buildQuoteCard(),
            const SizedBox(height: 24),

            // Quick Actions with Navigation
            _buildSectionTitle('Quick Actions'),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.spaceBetween,
              children: [
                _buildQuickActionCard(
                    context, 'Journal', Icons.edit_note, 'Write your thoughts', Colors.blue,  JournalScreen()),
                _buildQuickActionCard(
                    context, 'Meditate', Icons.self_improvement, '10 min session', Colors.purple, const MeditationScreen()),
                _buildQuickActionCard(
                    context, 'Hydration', Icons.water_drop, 'Track water intake', Colors.cyan,  HydrationScreen()),
                _buildQuickActionCard(
                    context, 'Sleep', Icons.bedtime, 'Track sleep quality', Colors.indigo, const SleepScreen()),
              ],
            ),
            const SizedBox(height: 24),

            // Weekly Overview
            _buildSectionTitle('Weekly Overview'),
            _buildOverviewCard('Mood Trend', 'Improving', Icons.trending_up, Colors.green),
            _buildOverviewCard('Meditation', '22 mins', Icons.timer, Colors.purple),
            _buildOverviewCard('Hydration', '1.8L/2L', Icons.water_drop, Colors.blue),
          ],
        ),
      ),
    );
  }

  // ✅ Navigation Functionality Added
  Widget _buildQuickActionCard(BuildContext context, String title, IconData icon, String subtitle, Color color, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: _containerDecoration(color.withOpacity(0.1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Mood Icons
  Widget _buildMoodIcon(String emoji, String label) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3)),
            ],
          ),
          child: Text(emoji, style: const TextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // Overview Card
  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: _containerDecoration(Colors.white),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: _containerDecoration(color.withOpacity(0.1)),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(value, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  // Quote Card
  Widget _buildQuoteCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _containerDecoration(Colors.white),
      child: Column(
        children: const [
          Text(
            '"The only way to do great work is to love what you do."',
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text('- Steve Jobs', style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  // Common Container Decoration
  BoxDecoration _containerDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3)),
      ],
    );
  }
}
