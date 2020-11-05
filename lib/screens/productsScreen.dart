import 'package:SBWL/providers/cartProvider.dart';
import 'package:SBWL/screens/cartScreen.dart';
import 'package:SBWL/widgets/badge.dart';
import 'package:SBWL/widgets/menu.dart';
import 'package:SBWL/widgets/productsGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favourites, All }

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _showFavourites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('SBWL'),
        actions: [
          _showFavourites
              ? IconButton(
                  icon: Icon(Icons.grid_view),
                  onPressed: () => {
                        FilterOptions.All,
                        setState(() {
                          _showFavourites = false;
                        })
                      })
              : IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () => {
                        FilterOptions.Favourites,
                        setState(() {
                          _showFavourites = true;
                        })
                      }),
          Consumer<CartProvider>(
            builder: (_, cart, badgeChild) => Badge(
              child: badgeChild,
              value: cart.productsCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: Menu(),
      body: ProductsGrid(_showFavourites),
    );
  }
}
