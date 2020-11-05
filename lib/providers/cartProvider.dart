import 'package:flutter/material.dart';

class CartProduct {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartProduct(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class CartProvider with ChangeNotifier {
  Map<String, CartProduct> _productItems = {};
  Map<String, CartProduct> get productItems {
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
          (existingCartItem) => CartProduct(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _productItems.putIfAbsent(
        productId,
        () => CartProduct(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _productItems.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_productItems.containsKey(productId)) {
      return;
    } else if (_productItems[productId].quantity > 1) {
      _productItems.update(
          productId,
          (existingCartProduct) => CartProduct(
                id: existingCartProduct.id,
                title: existingCartProduct.title,
                price: existingCartProduct.price,
                quantity: existingCartProduct.quantity - 1,
              ));
    } else {
      _productItems.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _productItems = {};
    notifyListeners();
  }
}
