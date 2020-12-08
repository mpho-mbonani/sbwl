import 'package:SBWL/providers/cartProvider.dart';
import 'package:SBWL/providers/productsProvider.dart';
import 'package:SBWL/screens/cartScreen.dart';
import 'package:SBWL/widgets/badge.dart';
import 'package:SBWL/widgets/menu.dart';
import 'package:SBWL/widgets/productsGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favourites, All }

class ProductsScreen extends StatefulWidget {
  static const routeName = '/products';
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _showFavourites = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: Menu(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showFavourites),
    );
  }
}
