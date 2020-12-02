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

  List<OrderProduct> get orders {
    return [..._orders];
  }

  Future<void> addOrder(
      List<CartProduct> cartProducts, double totalAmount) async {
    final url = 'https://xazululo-sbwl.firebaseio.com/orders.json';
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
