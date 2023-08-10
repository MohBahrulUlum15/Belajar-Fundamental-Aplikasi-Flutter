// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app_fundamental_dicoding/ui/detail_restaurant_page.dart';

import '../data/model/restaurant.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  late Future<Restaurants> _restaurantsFuture;
  late List<Restaurant> _restaurants;

  @override
  void initState() {
    super.initState();
    _restaurantsFuture = loadRestaurantData();
    _restaurants = [];
  }

  Future<Restaurants> loadRestaurantData() async {
    String jsonData =
        await rootBundle.loadString('assets/local_restaurant.json');
    Map<String, dynamic> jsonMap = json.decode(jsonData);
    Restaurants restaurants = Restaurants.fromJson(jsonMap);
    return restaurants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: FutureBuilder<Restaurants>(
        future: _restaurantsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData ||
              snapshot.data?.restaurants.isEmpty == true) {
            return const Center(
              child: Text('No restaurants available.'),
            );
          } else {
            _restaurants = snapshot.data!.restaurants;
            return ListView.builder(
              itemCount: _restaurants.length,
              itemBuilder: (context, index) {
                Restaurant restaurant = _restaurants[index];
                return _buildItems(context, restaurant);
              },
            );
          }
        },
      ),
    );
  }
}

Widget _buildItems(BuildContext context, Restaurant restaurant) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(2, 1),
            blurRadius: 10,
          ),
        ]),
    child: ListTile(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      leading: Hero(
        tag: restaurant.pictureId,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            restaurant.pictureId,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        restaurant.name,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 2.0),
        child: Text(
          restaurant.city,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      trailing: Text(
          style: Theme.of(context).textTheme.caption,
          'Rating: ${restaurant.rating.toStringAsFixed(1)}'),
    ),
  );
}
