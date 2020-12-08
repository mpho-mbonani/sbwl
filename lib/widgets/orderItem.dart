import 'dart:math';

import 'package:SBWL/providers/cartProvider.dart';
import 'package:SBWL/providers/ordersProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final OrderProduct order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    List<CartProduct> _products = widget.order.products;
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(_products.length * 20.0 + 10, 180),
              child: ListView(
                children: _products
                    .map((product) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${product.quantity}x R ${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ))
                    .toList(),
              ),
            ),
          ListTile(
            title: Text('R ${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
