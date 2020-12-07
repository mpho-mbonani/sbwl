import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'productProvider.dart';

class ProductsProvider with ChangeNotifier {
  final String authToken;
  String url;
  List<ProductProvider> _products = [];

  ProductsProvider(this.authToken, this._products) {
    this.url =
        'https://xazululo-sbwl.firebaseio.com/products.json?auth=$authToken';
  }

  List<ProductProvider> get favourites {
    return _products
        .where((ProductProvider productProvider) => productProvider.isFavourite)
        .toList();
  }

  List<ProductProvider> get products {
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

  Future<void> updateProduct(String id, ProductProvider product) async {
    final productIndex = _products.indexWhere((prod) => prod.id == id);
    final patchUrl =
        'https://xazululo-sbwl.firebaseio.com/products/$id.json?auth=$authToken';
    try {
      await http.patch(patchUrl,
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
          }));
      _products[productIndex] = product;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteProduct(String id) async {
    // test deleting product
    // move urls to configuration file
    final deleteUrl =
        'https://xazululo-sbwl.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _products.indexWhere((prod) => prod.id == id);
    var existingProduct = _products[existingProductIndex];
    _products.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(deleteUrl);
    if (response.statusCode >= 400) {
      _products.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw Exception();
    }
    existingProduct = null;
  }
}
