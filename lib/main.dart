import 'package:SBWL/providers/cartProvider.dart';
import 'package:SBWL/providers/ordersProvider.dart';
import 'package:SBWL/providers/productsProvider.dart';
import 'package:SBWL/screens/manageProductsScreen.dart';
import 'package:SBWL/screens/cartScreen.dart';
import 'package:SBWL/screens/productDetailScreen.dart';
import 'package:SBWL/screens/productScreen.dart';
import 'package:SBWL/screens/upsertProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/ordersScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrdersProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SBWL',
        theme: ThemeData(
          primarySwatch: Colors.lime,
        ),
        home: ProductScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          ManageProductsScreen.routeName: (context) => ManageProductsScreen(),
          UpsertProductScreen.routeName: (context) => UpsertProductScreen()
        },
      ),
    );
  }
}
