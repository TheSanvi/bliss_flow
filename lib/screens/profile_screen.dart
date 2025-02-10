import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info (Without Avatar)
            const Text(
              "Jane Doe",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text("janedoe@gmail.com",
                style: TextStyle(color: Colors.grey[600], fontSize: 16)),
            const SizedBox(height: 12),

            // Edit Profile Button
            ElevatedButton.icon(
              onPressed: () {
                // Edit profile action
              },
              icon: const Icon(Icons.edit, size: 16),
              label: const Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),

            // Account Settings Section
            _buildSettingsSection("Account Settings", [
              _buildSettingsTile(Icons.lock, "Change Password"),
              _buildSettingsTile(Icons.notifications, "Notification Settings"),
              _buildSettingsTile(Icons.privacy_tip, "Privacy Settings"),
            ]),

            // App Settings Section
            _buildSettingsSection("App Settings", [
              _buildSettingsTile(Icons.color_lens, "Theme & Appearance"),
              _buildSettingsTile(Icons.help_outline, "Help & Support"),
            ]),

            const SizedBox(height: 24),

            // Logout Button
            Center(
              child: TextButton.icon(
                onPressed: () {
                  // Logout action
                },
                icon: const Icon(Icons.exit_to_app, color: Colors.red),
                label: const Text("Logout",
                    style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Settings Section Title
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
