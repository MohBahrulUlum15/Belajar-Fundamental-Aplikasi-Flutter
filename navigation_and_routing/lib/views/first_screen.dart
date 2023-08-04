import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Navigation & Routing "),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {},
              child: const Text('Go to Second Screen'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Navigation with Data'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Return Data from Another Screen'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Replace Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
