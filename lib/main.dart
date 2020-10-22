import 'package:SBWL/providers/productsProvider.dart';
import 'package:SBWL/screens/productDetail.dart';
import 'package:SBWL/screens/productOverview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SBWL',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: ProductOverview(),
        routes: {
          ProductDetail.routeName: (context) => ProductDetail(),
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
      ),
      body: Center(
        child: Text('Let\'s build a SBWL!'),
      ),
    );
  }
}
