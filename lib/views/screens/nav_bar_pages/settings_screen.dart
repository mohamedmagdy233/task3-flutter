import 'package:flutter/material.dart';
import 'package:flutter_group_1/core/settings_util.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String userPhone = "";

  @override
  void initState() {
    super.initState();
    getUserPhoneNumber();
  }

  Future<void> getUserPhoneNumber() async {
    userPhone = await SettingsUtil.getCachedUserPhone();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<SettingsItem> settingsItems = [
      SettingsItem(
        icon: Icons.edit,
        title: "Edit Profile",
        subtitle: "Manage your account",
        onTap: () {
          // Handle Edit Profile
          // Add navigation or show a dialog for editing the profile
        },
      ),
      SettingsItem(
        icon: Icons.settings,
        title: "App Settings",
        subtitle: "Manage your Settings",
        onTap: () {
          // Handle App Settings
          // Add navigation or show a dialog for managing app settings
        },
      ),
      SettingsItem(
        icon: Icons.info,
        title: "About app",
        subtitle: "Data about developer and application",
        onTap: () {
          // Handle About App
          // Add navigation or show a dialog with app information
        },
      ),
    ];

    return ListView.builder(
      itemCount: settingsItems.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue, // Background color
                child: Icon(
                  Icons.person,
                  color: Colors.white, // Icon color
                  size: 60,
                ),
              ),
              const SizedBox(height: 5),
              Center(child: Text("User phone: $userPhone")),
              const SizedBox(height: 20),
            ],
          );
        } else {
          final settingsItem = settingsItems[index - 1];
          return InkWell(
            onTap: settingsItem.onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.grey[300], // Background color
                child: ListTile(
                  leading: Icon(
                    settingsItem.icon,
                    color: Colors.blue, // Icon color
                  ),
                  title: Text(settingsItem.title),
                  subtitle: Text(settingsItem.subtitle),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class SettingsItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}
