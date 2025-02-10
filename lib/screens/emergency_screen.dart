import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SOS Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Emergency Call Function
                },
                child: const Text(
                  "Send SOS Alert",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Emergency Contacts
            _buildSectionTitle("Emergency Contacts"),
            _buildContactTile("Mom", "+91 9876543210"),
            _buildContactTile("Best Friend", "+91 8765432109"),
            _buildContactTile("Doctor", "+91 7654321098"),

            const SizedBox(height: 24),

            // Quick Actions
            _buildSectionTitle("Quick Actions"),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildActionCard(Icons.local_hospital, "Find Nearby Hospitals"),
                _buildActionCard(Icons.directions_car, "Call an Ambulance"),
                _buildActionCard(Icons.shield, "Report an Incident"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Emergency Contact Tile
  Widget _buildContactTile(String name, String phone) {
    return ListTile(
      leading: const Icon(Icons.phone, color: Colors.red),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(phone),
      trailing: const Icon(Icons.call, color: Colors.green),
      onTap: () {
        // Call Function
      },
    );
  }

  // Quick Action Card
  Widget _buildActionCard(IconData icon, String label) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.red),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
