import 'package:SBWL/providers/authProvider.dart';
import 'package:SBWL/providers/cartProvider.dart';
import 'package:SBWL/providers/productProvider.dart';
import 'package:SBWL/screens/productDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final authentication = Provider.of<AuthProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        // for more options
        // header: GridTileBar(
        //   leading: IconButton(icon: Icon(Icons.tab_outlined), onPressed: () {}),
        //   trailing: IconButton(icon: Icon(Icons.face), onPressed: () {}),
        // ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png '),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.white60,
          leading: Consumer<ProductProvider>(
            builder: (ctx, product, _) => IconButton(
                icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.black,
                ),
                onPressed: () {
                  product.toggleFavourite(
                      authentication.token, authentication.userId);
                }),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                cart.addProduct(product.id, product.price, product.title);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Added Item to The Cart'),
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      }),
                ));
              }),
        ),
      ),
    );
  }
}
