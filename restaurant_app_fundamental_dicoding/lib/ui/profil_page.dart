import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = "/profile_page";

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Profile'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.lightBlue,
              backgroundImage:
                  AssetImage('assets/images/profile.png'),
            ),
            SizedBox(height: 16),
            Text(
              'Ahmad Wildan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Web & Mobile Developer',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text('ahmadwildan.smakensa@gmail.com'),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: ListTile(
                leading: Icon(Icons.link),
                title: Text('kakanda.tech'),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Jember, Jawa Timur - Indonesia'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
