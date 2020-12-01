import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/ordersScreen.dart';
import 'providers/ordersProvider.dart';
import 'providers/cartProvider.dart';
import 'providers/productsProvider.dart';
import 'screens/manageProductsScreen.dart';
import 'screens/cartScreen.dart';
import 'screens/productDetailScreen.dart';
import 'screens/productsScreen.dart';
import 'screens/upsertProductScreen.dart';

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
        home: ProductsScreen(),
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
