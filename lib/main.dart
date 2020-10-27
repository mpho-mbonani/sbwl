import 'package:SBWL/providers/cartProvider.dart';
import 'package:SBWL/providers/ordersProvider.dart';
import 'package:SBWL/providers/productsProvider.dart';
import 'package:SBWL/screens/cartScreen.dart';
import 'package:SBWL/screens/productDetailScreen.dart';
import 'package:SBWL/screens/productScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          primarySwatch: Colors.grey,
        ),
        home: ProductScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SBWL'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Let\'s build a SBWL!'),
      ),
    );
  }
}
