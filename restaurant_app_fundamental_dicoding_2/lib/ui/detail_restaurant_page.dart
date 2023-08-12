// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_fundamental_dicoding/common/styles.dart';
import 'package:restaurant_app_fundamental_dicoding/data/api/api_service.dart';
import 'package:restaurant_app_fundamental_dicoding/data/model/restaurant_detail.dart';
import 'package:restaurant_app_fundamental_dicoding/providers/restaurant_detail_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final String restaurantId;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) =>
          RestaurantDetailProvider(apiService: ApiService(), id: restaurantId),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, restaurantDetailProvider, child) {
          if (restaurantDetailProvider.state == ResultState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (restaurantDetailProvider.state == ResultState.Error) {
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
          } else if (restaurantDetailProvider.state == ResultState.NoData) {
            return const Center(
              child: Text('No restaurants available.'),
            );
          } else {
            RestaurantData? restaurantData =
                restaurantDetailProvider.result?.restaurant;
            return NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [];
              },
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300,
                    floating: false,
                    pinned: true,
                    // title: Text(restaurant.name),
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        restaurantData!.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      expandedTitleScale: 1,
                      centerTitle: true,
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Hero(
                            tag: restaurantData.pictureId,
                            child: Image.network(
                              "https://restaurant-api.dicoding.dev/images/medium/${restaurantData.pictureId}",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    restaurantData.city,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    restaurantData.rating.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                restaurantData.description,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Foods Menu:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 6),
                                    Column(
                                      children: restaurantData.menus.foods
                                          .map((food) => Row(
                                                children: [
                                                  const Icon(
                                                    Icons.food_bank,
                                                    size: 24,
                                                    color: lightColor,
                                                  ),
                                                  const SizedBox(width: 4,),
                                                  Text(food.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1),
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Drinks Menu:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 6),
                                    Column(
                                      children: restaurantData.menus.drinks
                                          .map((drink) => Row(
                                            children: [
                                              const Icon(
                                                    Icons.local_drink,
                                                    size: 24,
                                                    color: lightColor,
                                                  ),
                                                  const SizedBox(width: 4,),
                                              Text(drink.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1),
                                            ],
                                          ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    ));
  }
}
