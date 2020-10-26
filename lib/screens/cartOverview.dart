import 'package:SBWL/providers/cartProvider.dart';
import 'package:SBWL/widgets/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartOverview extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('The Cart'),
      ),
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
                    label: Text('R ${cart.productItemsTotalAmount}'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Order'),
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
