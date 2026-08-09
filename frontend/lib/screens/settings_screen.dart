import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final settingsProvider = context.watch<SettingsProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(title: const Text("Settings"), centerTitle: true),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Appearance",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          Card(
            child: SwitchListTile(
              activeColor: Colors.cyanAccent,
              value: themeProvider.isDark,
              title: const Text("Dark Mode"),
              secondary: const Icon(Icons.dark_mode),
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Notifications",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          Card(
            child: SwitchListTile(
              activeColor: Colors.greenAccent,
              value: settingsProvider.notification,
              title: const Text("Enable Notifications"),
              secondary: const Icon(Icons.notifications),
              onChanged: (value) {
                settingsProvider.toggleNotification(value);
              },
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Currency",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          Card(
            child: ListTile(
              leading: const Icon(Icons.currency_rupee),

              title: Text(settingsProvider.currency),

              trailing: DropdownButton<String>(
                value: settingsProvider.currency,
                underline: const SizedBox(),

                items: const [
                  DropdownMenuItem(value: "₹ INR", child: Text("₹ INR")),
                  DropdownMenuItem(value: "\$ USD", child: Text("\$ USD")),
                  DropdownMenuItem(value: "€ EUR", child: Text("€ EUR")),
                ],

                onChanged: (value) {
                  if (value != null) {
                    settingsProvider.changeCurrency(value);
                  }
                },
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("Version"),
              subtitle: Text("1.0.0"),
            ),
          ),

          const SizedBox(height: 40),

          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Settings saved successfully ✅"),
                  ),
                );
              },
              icon: const Icon(Icons.check),
              label: const Text(
                "Save Settings",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
