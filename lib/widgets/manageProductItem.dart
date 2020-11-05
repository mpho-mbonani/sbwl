import 'package:SBWL/screens/upsertProductScreen.dart';
import 'package:flutter/material.dart';

class ManageProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ManageProductItem({Key key, this.id, this.title, this.imageUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}
