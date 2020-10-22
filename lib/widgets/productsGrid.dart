import 'package:SBWL/models/product.dart';
import 'package:SBWL/providers/productsProvider.dart';
import 'package:SBWL/widgets/productItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).items;
    return GridView.builder(
      padding: EdgeInsets.all(8),
      itemCount: products.length,
      itemBuilder: (ctx, i) =>
          ProductItem(products[i].id, products[i].title, products[i].imageUrl),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
    );
  }
}
