// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '../data/api/api_service.dart';
import '../data/model/restaurant_detail.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchAllRestaurantDetail();
  }

  RestaurantDetail? _restaurant;
  String _message = '';
  ResultState _state = ResultState.Loading;

  String get message => _message;
  RestaurantDetail? get result => _restaurant;
  ResultState get state => _state;

  Future<void> _fetchAllRestaurantDetail() async {
    try {
      final resto = await apiService.detailRestaurant(id);
      if (resto.restaurant.id.isEmpty) {
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