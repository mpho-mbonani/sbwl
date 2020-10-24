import 'package:SBWL/providers/product.dart';
import 'package:SBWL/widgets/productsGrid.dart';
import 'package:flutter/material.dart';

class ProductOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SBWL'),
      ),
      body: ProductsGrid(),
    );
  }
}
