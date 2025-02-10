import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/journaling_screen.dart';
import 'screens/meditation_screen.dart';
import 'screens/hydration_screen.dart';
import 'screens/mood_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/emergency_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BlissFlow',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
      //   '/journaling': (context) => JournalingScreen(),
      //   '/meditation': (context) => MeditationScreen(),
      //   '/hydration': (context) => HydrationScreen(),
        '/mood': (context) => MoodScreen(),
      //   '/profile': (context) => ProfileScreen(),
      //   '/settings': (context) => SettingsScreen(),
      //   '/emergency': (context) => EmergencyScreen(),
      },
    );
  }
}
