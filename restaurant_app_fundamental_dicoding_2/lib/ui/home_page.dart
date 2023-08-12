import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_fundamental_dicoding/common/styles.dart';
import 'package:restaurant_app_fundamental_dicoding/data/api/api_service.dart';
import 'package:restaurant_app_fundamental_dicoding/providers/restaurant_provider.dart';
import 'package:restaurant_app_fundamental_dicoding/providers/restaurant_search_provider.dart';
import 'package:restaurant_app_fundamental_dicoding/ui/profil_page.dart';
import 'package:restaurant_app_fundamental_dicoding/ui/restaurant_list_page.dart';
import 'package:restaurant_app_fundamental_dicoding/ui/search_page.dart';
import 'package:restaurant_app_fundamental_dicoding/ui/setting_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<SalomonBottomBarItem> _bottomNavBarItems = [
    SalomonBottomBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
        title: const Text(
          "Home",
        )),
    SalomonBottomBarItem(
        icon: Icon(Platform.isIOS
            ? CupertinoIcons.search
            : Icons.search),
        title: const Text(
          "Search",
        )),
    SalomonBottomBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
        title: const Text(
          "Setting",
        )),
    SalomonBottomBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.person : Icons.person),
        title: const Text(
          "Profile",
        )),
  ];

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: const RestaurantListPage(),
    ),
    ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(apiService: ApiService()),
      child: const SearchPage(),
    ),
    const SettingsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (value) {
          setState(() {
            _bottomNavIndex = value;
          });
        },
      ),
    );
  }
}
