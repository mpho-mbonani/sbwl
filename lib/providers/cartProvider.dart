import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _productItems = {};
  Map<String, CartItem> get productItems {
    return {..._productItems};
  }

  int get productsCount {
    return _productItems.length;
  }

  double get productItemsTotalAmount {
    double total = 0.0;
    _productItems.forEach((key, productItem) {
      total += productItem.price * productItem.quantity;
    });
    return total;
  }

  void addProduct(String productId, double price, String title) {
    if (_productItems.containsKey(productId)) {
      _productItems.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _productItems.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
}
