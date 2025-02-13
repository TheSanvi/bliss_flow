import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class HydrationScreen extends StatefulWidget {
  @override
  _HydrationScreenState createState() => _HydrationScreenState();
}

class _HydrationScreenState extends State<HydrationScreen> {
  int currentWaterIntake = 1200;
  int goal = 2000;

  List<int> pastDaysData = [1500, 1800, 1200, 2000, 1700]; // Last 5 days

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFa8c0ff), Color(0xFF3f2b96)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text("BlissFlow",
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 20),
                  _buildWaterProgress(),
                  SizedBox(height: 20),
                  _buildWaterButtons(),
                  SizedBox(height: 20),
                  _buildResetButton(),
                  SizedBox(height: 20),
                  _buildStreakSection(),
                  SizedBox(height: 20),
                  _buildHistoryChart(),
                  SizedBox(height: 20),
                  _buildAchievementsSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWaterProgress() {
    double percentage = (currentWaterIntake / goal) * 100;
    return Column(
      children: [
        Text("$currentWaterIntake ml / $goal ml",
            style: GoogleFonts.poppins(fontSize: 18, color: Colors.white)),
        SizedBox(height: 10),
        LinearProgressIndicator(
          value: currentWaterIntake / goal,
          backgroundColor: Colors.white.withOpacity(0.3),
          color: Colors.blueAccent,
          minHeight: 10,
        ),
        SizedBox(height: 10),
        Text("${percentage.toStringAsFixed(1)}% of daily goal",
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70)),
      ],
    );
  }

  Widget _buildWaterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [250, 500, 1000].map((amount) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                currentWaterIntake += amount;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text("+ $amount ml", style: GoogleFonts.poppins(fontSize: 14, color: Colors.white)),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          currentWaterIntake = 0;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text("Reset Progress", style: GoogleFonts.poppins(fontSize: 14, color: Colors.white)),
    );
  }

  Widget _buildStreakSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStreakBox("Current Streak", "7 Days"),
        _buildStreakBox("Best Record", "14 Days"),
      ],
    );
  }

  Widget _buildStreakBox(String title, String value) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70)),
          SizedBox(height: 5),
          Text(value, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildHistoryChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Past 5 Days", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: pastDaysData.asMap().entries.map((entry) {
                int index = entry.key;
                int value = entry.value;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: value.toDouble(),
                      color: Colors.blueAccent,
                      width: 20,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ],
                );
              }).toList(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 500,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      return Text('${value.toInt()} ml',
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white));
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri"];
                      return Text(days[value.toInt()],
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white));
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: true, drawVerticalLine: false),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Achievements", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ["Hydration Hero", "Perfect Week", "Early Bird"].map((achievement) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
              child: Text(achievement, style: GoogleFonts.poppins(fontSize: 14, color: Colors.white)),
            );
          }).toList(),
        ),
      ],
    );
  }
}
