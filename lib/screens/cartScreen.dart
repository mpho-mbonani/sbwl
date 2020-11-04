import 'package:SBWL/providers/cartProvider.dart';
import 'package:SBWL/providers/ordersProvider.dart';
import 'package:SBWL/screens/ordersScreen.dart';
import 'package:SBWL/widgets/cartItem.dart';
import 'package:SBWL/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('The Cart'),
      ),
      drawer: Menu(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.productsCount,
              itemBuilder: (context, i) => CartItem(
                  id: cart.productItems.values.toList()[i].id,
                  productId: cart.productItems.keys.toList()[i],
                  title: cart.productItems.values.toList()[i].title,
                  quantity: cart.productItems.values.toList()[i].quantity,
                  price: cart.productItems.values.toList()[i].price),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Chip(
                    label: Text(
                        'R ${cart.productItemsTotalAmount.toStringAsFixed(2)}'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    child: Text('Order'),
                    onPressed: () {
                      Provider.of<OrdersProvider>(context, listen: false)
                          .addOrder(
                        cart.productItems.values.toList(),
                        cart.productItemsTotalAmount,
                      );
                      cart.clearCart();
                      Navigator.of(context)
                          .pushReplacementNamed(OrdersScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
