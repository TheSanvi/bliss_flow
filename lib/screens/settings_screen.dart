import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Account Settings
          _buildSettingsSection("Account Settings", [
            _buildSettingsTile(Icons.lock, "Change Password"),
            _buildSettingsTile(Icons.person, "Edit Profile"),
            _buildSettingsTile(Icons.privacy_tip, "Privacy Settings"),
          ]),

          // Notifications
          _buildSettingsSection("Notifications", [
            _buildSettingsTile(Icons.notifications, "Notification Preferences"),
            _buildSettingsTile(Icons.do_not_disturb, "Do Not Disturb Mode"),
          ]),

          // App Preferences
          _buildSettingsSection("App Preferences", [
            _buildSettingsTile(Icons.color_lens, "Theme & Appearance"),
            _buildSettingsTile(Icons.language, "Language"),
            _buildSettingsTile(Icons.info_outline, "About App"),
          ]),

          const SizedBox(height: 20),

          // Logout Button
          Center(
            child: TextButton.icon(
              onPressed: () {
                // Logout function
              },
              icon: const Icon(Icons.exit_to_app, color: Colors.red),
              label: const Text("Logout",
                  style: TextStyle(color: Colors.red, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  // Section Title
  Widget _buildSettingsSection(String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[100],
          ),
          child: Column(children: tiles),
        ),
      ],
    );
  }

  // Settings Tile
  Widget _buildSettingsTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Navigate to respective screen
      },
    );
  }
}
