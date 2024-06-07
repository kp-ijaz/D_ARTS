import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, String> profileData;

  ProfilePage({required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: profileData.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('${entry.key}: ${entry.value}'),
            );
          }).toList(),
        ),
      ),
    );
  }
}
