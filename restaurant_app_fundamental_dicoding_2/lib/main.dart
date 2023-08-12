import 'package:flutter/material.dart';
import 'package:restaurant_app_fundamental_dicoding/common/styles.dart';
import 'package:restaurant_app_fundamental_dicoding/ui/detail_restaurant_page.dart';
import 'package:restaurant_app_fundamental_dicoding/ui/home_page.dart';
import 'package:restaurant_app_fundamental_dicoding/ui/splashscreen_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.lightBlue,
              onPrimary: Colors.white,
              secondary: secondaryColor,
            ),
        textTheme: myTextTheme,
      ),
      initialRoute: SplashScreenPage.routeName,
      routes: {
        SplashScreenPage.routeName: (context) => const SplashScreenPage(),
        HomePage.routeName: (context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
