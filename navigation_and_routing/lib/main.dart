import 'package:flutter/material.dart';
import 'package:navigation_and_routing/views/another_screen.dart';
import 'package:navigation_and_routing/views/first_screen.dart';
import 'package:navigation_and_routing/views/replacement_screen.dart';
import 'package:navigation_and_routing/views/return_data_screen.dart';
import 'package:navigation_and_routing/views/second_screen.dart';
import 'package:navigation_and_routing/views/second_screen_with_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        '/secondScreen': (context) => const SecondScreen(),
        '/secondScreenWithData': (context) => SecondScreenWithData(
            ModalRoute.of(context)?.settings.arguments as String),
        '/returnDataScreen': (context) => const ReturnDataScreen(),
        '/replacementScreen': (context) => const ReplacementScreen(),
        '/anotherScreen': (context) => const AnotherScreen(),
      },
    );
  }
}
