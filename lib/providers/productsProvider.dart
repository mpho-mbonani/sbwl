import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'productProvider.dart';

class ProductsProvider with ChangeNotifier {
  String url = 'https://xazululo-sbwl.firebaseio.com/products.json';
  List<ProductProvider> _products = [];

  List<ProductProvider> get favourites {
    return _products
        .where((ProductProvider productProvider) => productProvider.isFavourite)
        .toList();
  }

  List<ProductProvider> get all {
    return [..._products];
  }

  ProductProvider getbyId(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<ProductProvider> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          ProductProvider(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              price: prodData['price'],
              isFavourite: prodData['isFavourite'],
              imageUrl: prodData['imageUrl']),
        );
      });
      _products = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(ProductProvider product) async {
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'isFavourite': product.isFavourite,
          }));

      _products.add(
        ProductProvider(
          id: json.decode(response.body)['name'],
          title: product.title,
          price: product.price,
          description: product.description,
          imageUrl: product.imageUrl,
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void updateProduct(String id, ProductProvider product) {
    final productIndex = _products.indexWhere((prod) => prod.id == id);
    _products[productIndex] = product;
    notifyListeners();
  }

  void deleteProduct(String id) {
    _products.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
