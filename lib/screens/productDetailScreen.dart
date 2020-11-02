import 'package:SBWL/providers/productsProvider.dart';
import 'package:SBWL/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/productDetail';
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductsProvider>(context, listen: false)
        .getbyId(ModalRoute.of(context).settings.arguments as String);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(product.title),
      ),
      drawer: Menu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text('R ${product.price}'),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
