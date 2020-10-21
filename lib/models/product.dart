import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final double cost;
  final String imageUrl;
  final String category;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      this.cost,
      this.category,
      @required this.imageUrl});
}
