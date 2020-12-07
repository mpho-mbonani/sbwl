import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  ProductProvider(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavourite = false});

  void _setFavourite(bool value) {
    isFavourite = value;
    notifyListeners();
  }

  Future<void> toggleFavourite(String authToken, String userId) async {
    final currentStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        'https://xazululo-sbwl.firebaseio.com/userFavourites/$userId/$id.json?auth=$authToken';
    try {
      final response = await http.put(url, body: json.encode(isFavourite));
      if (response.statusCode >= 400) {
        _setFavourite(currentStatus);
      }
    } catch (error) {
      _setFavourite(currentStatus);
    }
  }
}
