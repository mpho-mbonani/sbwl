import 'package:SBWL/providers/productsProvider.dart';
import 'package:SBWL/widgets/productItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavourites;
  ProductsGrid(this.showFavourites);
  @override
  Widget build(BuildContext context) {
    final products = showFavourites
        ? Provider.of<ProductsProvider>(context).favourites
        : Provider.of<ProductsProvider>(context).all;
    return GridView.builder(
      padding: EdgeInsets.all(8),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
    );
  }
}
