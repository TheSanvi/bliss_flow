import 'package:flutter/material.dart';

class HydrationScreen extends StatefulWidget {
  const HydrationScreen({Key? key}) : super(key: key);

  @override
  _HydrationScreenState createState() => _HydrationScreenState();
}

class _HydrationScreenState extends State<HydrationScreen> {
  int waterIntake = 0; // Track water intake in ml

  void _increaseWaterIntake() {
    setState(() {
      waterIntake += 250; // Increment by 250ml (1 glass)
    });
  }

  void _resetWaterIntake() {
    setState(() {
      waterIntake = 0; // Reset water intake
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hydration Tracker"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),

            // Water Intake Display
            Text(
              "$waterIntake ml",
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const Text("Daily Water Intake", style: TextStyle(fontSize: 18, color: Colors.grey)),

            const SizedBox(height: 24),

            // Water Glass Icon
            Icon(Icons.local_drink, size: 100, color: Colors.blue),

            const SizedBox(height: 24),

            // Add Water Button
            ElevatedButton(
              onPressed: _increaseWaterIntake,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text("+ 250ml", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 16),

            // Reset Button
            TextButton(
              onPressed: _resetWaterIntake,
              child: const Text("Reset", style: TextStyle(fontSize: 16, color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
