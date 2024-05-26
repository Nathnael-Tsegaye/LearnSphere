import 'package:flutter/material.dart';
import 'package:test/pwIp/changepassword.dart';

class settings extends StatelessWidget {
  const settings({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy and Security',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Change password'),
              onTap: () {
                  Navigator.pushNamed(context, '/changepassw');
                },
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}