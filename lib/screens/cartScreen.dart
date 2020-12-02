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
                  OrderButton(cart: cart),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final CartProvider cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoading ? CircularProgressIndicator() : Text('Order'),
      onPressed: (widget.cart.productItemsTotalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<OrdersProvider>(context, listen: false)
                  .addOrder(
                widget.cart.productItems.values.toList(),
                widget.cart.productItemsTotalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clearCart();
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
    );
  }
}
