import 'dart:io';

import 'package:dicoding_news_app/views/article_list_page.dart';
import 'package:dicoding_news_app/views/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/styles.dart';

class NewsListPage extends StatefulWidget {
  static const routeName = '/home_page';

  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  int _bottomNavIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
      label: "Headline",
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: "Setting",
    ),
  ];

  final List<Widget> _listWidget = [
    const ArticleListPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
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

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body:
          _bottomNavIndex == 0 ? const ArticleListPage() : const SettingsPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Headline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  // Widget _buildIos(BuildContext context) {
  //   return CupertinoTabScaffold(
  //     tabBar: CupertinoTabBar(
  //       activeColor: secondaryColor,
  //       items: const [
  //         BottomNavigationBarItem(
  //           icon: Icon(CupertinoIcons.news),
  //           label: 'Headline',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(CupertinoIcons.settings),
  //           label: 'Settings',
  //         ),
  //       ],
  //     ),
  //     tabBuilder: (context, index) {
  //       switch (index) {
  //         case 1:
  //           return const SettingsPage();
  //         default:
  //           return const ArticleListPage();
  //       }
  //     },
  //   );
  // }

  Widget _buildIos(BuildContext context) {
  return CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      items: _bottomNavBarItems,
      activeColor: secondaryColor,
    ),
    tabBuilder: (context, index) {
      return _listWidget[index];
    },
  );
}
}
