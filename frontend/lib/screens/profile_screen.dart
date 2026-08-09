import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_spend_ai/screens/settings_screen.dart';

import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> logout(BuildContext context) async {
    await storage.delete(key: "token");

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Widget profileTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Color color = Colors.white,
  }) {
    return Card(
      color: const Color(0xff111827),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        leading: Icon(icon, color: Colors.cyanAccent),
        title: Text(
          title,
          style: TextStyle(color: color, fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
          size: 18,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff050505),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.cyanAccent,
              child: Icon(Icons.person, size: 60, color: Colors.black),
            ),

            const SizedBox(height: 20),

            const Text(
              "SmartSpend User",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "user@example.com",
              style: TextStyle(color: Colors.white54),
            ),

            const SizedBox(height: 35),

            profileTile(icon: Icons.person_outline, title: "Edit Profile"),

            profileTile(icon: Icons.lock_outline, title: "Change Password"),

            profileTile(
              icon: Icons.settings,
              title: "Settings",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),

            profileTile(icon: Icons.info_outline, title: "About App"),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                icon: const Icon(Icons.logout),
                label: const Text("Logout", style: TextStyle(fontSize: 18)),
                onPressed: () => logout(context),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Version 1.0.0",
              style: TextStyle(color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }
}
