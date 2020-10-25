import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final double cost;
  final String imageUrl;
  final String category;
  bool isFavourite;

  ProductProvider(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.cost,
      this.category,
      this.isFavourite = false});

  void toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
