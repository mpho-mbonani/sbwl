import 'package:SBWL/providers/cartProvider.dart';
import 'package:flutter/cupertino.dart';

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

  void addOrder(List<CartProduct> cartProducts, double totalAmount) {
    _orders.insert(
      0,
      OrderProduct(
        id: DateTime.now().toString(),
        amount: totalAmount,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
