import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  const CartItem({Key key, this.id, this.price, this.quantity, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                child: FittedBox(
                  child: Text('R$price'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: R ${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
