import 'package:SBWL/providers/productsProvider.dart';
import 'package:SBWL/widgets/manageProductItem.dart';
import 'package:SBWL/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'upsertProductScreen.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/addProducts';
  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Manage Products'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(UpsertProductScreen.routeName);
              })
        ],
      ),
      drawer: Menu(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productProvider.all.length,
          itemBuilder: (_, i) => Column(
            children: [
              ManageProductItem(
                id: productProvider.all[i].id,
                title: productProvider.all[i].title,
                imageUrl: productProvider.all[i].imageUrl,
              ),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
