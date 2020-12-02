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

  Future<void> toggleFavourite() async {
    final currentStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final patchUrl = 'https://xazululo-sbwl.firebaseio.com/products/$id.json';
    try {
      final response = await http.patch(patchUrl,
          body: json.encode({'isFavourite': isFavourite}));
      if (response.statusCode >= 400) {
        _setFavourite(currentStatus);
      }
    } catch (error) {
      _setFavourite(currentStatus);
    }
  }
}
