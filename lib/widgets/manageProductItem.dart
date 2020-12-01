import 'package:SBWL/providers/productsProvider.dart';
import 'package:SBWL/screens/upsertProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ManageProductItem({Key key, this.id, this.title, this.imageUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 120,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                color: Colors.grey,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(UpsertProductScreen.routeName, arguments: id);
                }),
            VerticalDivider(),
            IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () async {
                  try {
                    await Provider.of<ProductsProvider>(context, listen: false)
                        .deleteProduct(id);
                  } catch (error) {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text('Deleting Failed'),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
