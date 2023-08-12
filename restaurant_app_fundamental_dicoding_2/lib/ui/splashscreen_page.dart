import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app_fundamental_dicoding/common/styles.dart';
import 'package:restaurant_app_fundamental_dicoding/ui/home_page.dart';

class SplashScreenPage extends StatefulWidget {
  static const routeName = "/splashscreen";

  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
        context,
        HomePage.routeName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(
                'assets/images/logo_restaurant.png',
              ),
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
