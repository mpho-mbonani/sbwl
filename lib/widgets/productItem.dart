import 'package:SBWL/providers/product.dart';
import 'package:SBWL/screens/productDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        // for more options
        // header: GridTileBar(
        //   leading: IconButton(icon: Icon(Icons.tab_outlined), onPressed: () {}),
        //   trailing: IconButton(icon: Icon(Icons.face), onPressed: () {}),
        // ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetail.routeName, arguments: product.id);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
              icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: Colors.black,
              ),
              onPressed: () {
                product.toggleFavourite();
              }),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
              ),
              onPressed: () {}),
        ),
      ),
    );
  }
}
