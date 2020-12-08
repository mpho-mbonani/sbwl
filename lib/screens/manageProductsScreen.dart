import 'package:SBWL/providers/productsProvider.dart';
import 'package:SBWL/widgets/manageProductItem.dart';
import 'package:SBWL/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'upsertProductScreen.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/addProducts';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productProvider =
    //     Provider.of<ProductsProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, previousState) =>
            previousState.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<ProductsProvider>(
                      builder: (ctx, productProvider, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productProvider.products.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              ManageProductItem(
                                id: productProvider.products[i].id,
                                title: productProvider.products[i].title,
                                imageUrl: productProvider.products[i].imageUrl,
                              ),
                              Divider()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
