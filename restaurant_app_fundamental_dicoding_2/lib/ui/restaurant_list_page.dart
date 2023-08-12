// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_fundamental_dicoding/providers/restaurant_provider.dart';
import '../common/styles.dart';
import '../data/model/restaurant.dart';
import 'detail_restaurant_page.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, restaurantProvider, child) {
          if (restaurantProvider.state == ResultState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (restaurantProvider.state == ResultState.Error) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.network_check,
                    size: 40.0,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    " Gagal Memuat Data\nHarap Periksa Koneksi Internet kamu",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: lightColor),
                  ),
                ],
              ),
            );
          } else if (restaurantProvider.state == ResultState.NoData) {
            return const Center(
              child: Text('No restaurants available.'),
            );
          } else {
            List<RestaurantElement> restaurants =
                restaurantProvider.result.restaurants;
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                RestaurantElement restaurant = restaurants[index];
                return _buildItems(context, restaurant);
              },
            );
          }
        },
      ),
    );
  }
}

Widget _buildItems(BuildContext context, RestaurantElement restaurant) {
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
            arguments: restaurant.id);
      },
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      leading: Hero(
        tag: restaurant.pictureId,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
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
