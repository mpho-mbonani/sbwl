import 'package:SBWL/screens/productOverview.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SBWL',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: ProductOverview(),
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
