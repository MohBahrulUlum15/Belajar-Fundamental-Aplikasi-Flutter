import 'dart:convert';

class RestaurantSearch {
  bool error;
  int founded;
  List<RestaurantResult> restaurants;

  RestaurantSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearch.fromRawJson(String str) =>
      RestaurantSearch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantResult>.from(
            json["restaurants"].map((x) => RestaurantResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantResult {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  RestaurantResult({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantResult.fromRawJson(String str) =>
      RestaurantResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantResult.fromJson(Map<String, dynamic> json) => RestaurantResult(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
