// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late Restaurant _restaurant;
  String _message = '';
  ResultState _state = ResultState.Loading;

  String get message => _message;
  Restaurant get result => _restaurant;
  ResultState get state => _state;

  Future<void> _fetchAllRestaurant() async {
    try {
      final resto = await apiService.listRestaurant();
      if (resto.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        _restaurant = resto;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      _message = 'Error --> $e';
    }
  }
}
