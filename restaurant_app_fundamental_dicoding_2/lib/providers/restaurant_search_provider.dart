// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:restaurant_app_fundamental_dicoding/data/model/restaurant_search.dart';

import '../data/api/api_service.dart';

enum StateResultSearch { Loading, NoData, HasData, Error }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService});

  RestaurantSearch? _resultRestaurantSearch;
  String _message = '';
  String _query = '';
  StateResultSearch _state = StateResultSearch.Loading;

  String get message => _message;
  String get query => _query;
  RestaurantSearch? get result => _resultRestaurantSearch;
  StateResultSearch get state => _state;

  Future<void> fetchAllRestaurantSearch(String query) async {
    try {
      _state = StateResultSearch.Loading;
      _query = query;

      final restaurantSearch = await apiService.searchingRestaurant(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = StateResultSearch.NoData;
        notifyListeners();
        _message = 'Restaurant Tidak dapat ditemukan';
      } else {
        _state = StateResultSearch.HasData;
        notifyListeners();
        _resultRestaurantSearch = restaurantSearch;
      }
    } catch (e) {
      _state = StateResultSearch.Error;
      notifyListeners();
      _message = 'Error --> $e';
    }
  }
}