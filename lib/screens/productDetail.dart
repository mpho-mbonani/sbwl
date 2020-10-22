import 'package:SBWL/providers/productsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/productDetail';
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductsProvider>(context, listen: false)
        .getbyId(ModalRoute.of(context).settings.arguments as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
