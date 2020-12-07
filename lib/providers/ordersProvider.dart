import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../providers/cartProvider.dart';

class OrderProduct {
  final String id;
  final double amount;
  final List<CartProduct> products;
  final DateTime dateTime;

  OrderProduct(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class OrdersProvider with ChangeNotifier {
  List<OrderProduct> _orders = [];
  final String authToken;
  final String userId;

  OrdersProvider(this.authToken, this.userId, this._orders);

  List<OrderProduct> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://xazululo-sbwl.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderProduct> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData != null) {
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderProduct(
            id: orderId,
            amount: orderData['amount'],
            products: (orderData['products'] as List<dynamic>)
                .map((op) => CartProduct(
                      id: op['id'],
                      title: op['title'],
                      quantity: op['quantity'],
                      price: op['price'],
                    ))
                .toList(),
            dateTime: DateTime.parse(orderData['dateTime']),
          ),
        );
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    }
  }

  Future<void> addOrder(
      List<CartProduct> cartProducts, double totalAmount) async {
    // add error handling
    final url =
        'https://xazululo-sbwl.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'id': DateTime.now().toString(),
        'amount': totalAmount,
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price
                })
            .toList(),
        'dateTime': timeStamp.toIso8601String(),
      }),
    );
    _orders.insert(
      0,
      OrderProduct(
        id: json.decode(response.body)['name'],
        amount: totalAmount,
        products: cartProducts,
        dateTime: timeStamp,
      ),
    );
    notifyListeners();
  }
}
