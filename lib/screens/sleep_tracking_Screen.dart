import 'package:flutter/material.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({Key? key}) : super(key: key);

  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  TimeOfDay sleepTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay wakeTime = const TimeOfDay(hour: 6, minute: 30);

  Future<void> _selectTime(BuildContext context, bool isSleepTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isSleepTime ? sleepTime : wakeTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isSleepTime) {
          sleepTime = pickedTime;
        } else {
          wakeTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sleep Tracker"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Sleep Time
            _buildTimeCard("Sleep Time", sleepTime, () => _selectTime(context, true)),

            const SizedBox(height: 24),

            // Wake Time
            _buildTimeCard("Wake Time", wakeTime, () => _selectTime(context, false)),

            const SizedBox(height: 24),

            // Total Sleep Duration
            _buildSleepDuration(),
          ],
        ),
      ),
    );
  }

  // Time Card Widget
  Widget _buildTimeCard(String title, TimeOfDay time, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      trailing: GestureDetector(
        onTap: onTap,
        child: Text(
          "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.blue),
        ),
      ),
    );
  }

  // Sleep Duration Widget
  Widget _buildSleepDuration() {
    int totalSleepHours = wakeTime.hour - sleepTime.hour;
    int totalSleepMinutes = wakeTime.minute - sleepTime.minute;

    if (totalSleepMinutes < 0) {
      totalSleepHours -= 1;
      totalSleepMinutes += 60;
    }

    if (totalSleepHours < 0) {
      totalSleepHours += 24;
    }

    return Center(
      child: Column(
        children: [
          Text(
            "$totalSleepHours hrs $totalSleepMinutes mins",
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const Text("Total Sleep Duration", style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }
}
