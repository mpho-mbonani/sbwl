import 'package:flutter/material.dart';

class ManageProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ManageProductItem({Key key, this.title, this.imageUrl})
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
                icon: Icon(Icons.edit), color: Colors.grey, onPressed: () {}),
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
