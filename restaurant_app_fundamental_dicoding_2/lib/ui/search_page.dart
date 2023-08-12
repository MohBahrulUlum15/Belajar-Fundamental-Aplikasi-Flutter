// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_fundamental_dicoding/common/styles.dart';
import 'package:restaurant_app_fundamental_dicoding/data/model/restaurant_search.dart';
import 'package:restaurant_app_fundamental_dicoding/ui/detail_restaurant_page.dart';
import '../providers/restaurant_search_provider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          "Restaurant App",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildSearchBar(context),
            const SizedBox(height: 10),
            Expanded(
              child: _buildRestaurantList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, _) {
        return Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: ListTile(
            leading: const Icon(
              Icons.search,
              size: 30,
              color: Colors.lightBlue,
            ),
            title: TextField(
              controller: _controller,
              onChanged: (String value) {
                if (value.isNotEmpty) {
                  state.fetchAllRestaurantSearch(value);
                }
              },
              cursorColor: Colors.lightBlue,
              decoration: const InputDecoration(
                hintText: "Cari Restoran",
                border: InputBorder.none,
              ),
            ),
            trailing: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                _controller.clear();
              },
              icon: const Icon(Icons.cancel_outlined, size: 30),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRestaurantList(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == StateResultSearch.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == StateResultSearch.HasData) {
          return ListView.builder(
            itemCount: state.result!.restaurants.length,
            itemBuilder: (context, index) {
              var resto = state.result!.restaurants[index];
              return _buildItems(context, resto);
            },
          );
        } else if (state.state == StateResultSearch.NoData) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: lightColor),
            ),
          );
        } else if (state.state == StateResultSearch.Error) {
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
        } else {
          return const Center();
        }
      },
    );
  }

  Widget _buildItems(BuildContext context, RestaurantResult restaurant) {
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
}
