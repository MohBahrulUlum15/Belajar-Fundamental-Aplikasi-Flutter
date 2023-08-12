import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_fundamental_dicoding/data/model/restaurant_detail.dart';
import 'package:restaurant_app_fundamental_dicoding/data/model/restaurant_search.dart';

import '../model/restaurant.dart';

class ApiService {
  final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<T> _getResponse<T>(String endpoint) async {
    final response = await http.get(Uri.parse(_baseUrl + endpoint));
    if (response.statusCode == 200) {
      return json.decode(response.body) as T;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Restaurant> listRestaurant() async {
    return Restaurant.fromJson(await _getResponse<Map<String, dynamic>>('list'));
  }

  Future<RestaurantDetail> detailRestaurant(String id) async {
    return RestaurantDetail.fromJson(await _getResponse<Map<String, dynamic>>('detail/$id'));
  }

  Future<RestaurantSearch> searchingRestaurant(String query) async {
    return RestaurantSearch.fromJson(await _getResponse<Map<String, dynamic>>('search?q=$query'));
  }
}