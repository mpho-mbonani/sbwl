import 'package:SBWL/screens/productDetail.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        // for more options
        // header: GridTileBar(
        //   leading: IconButton(icon: Icon(Icons.tab_outlined), onPressed: () {}),
        //   trailing: IconButton(icon: Icon(Icons.face), onPressed: () {}),
        // ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetail.routeName, arguments: id);
            },
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
              icon: Icon(
                Icons.favorite_border_outlined,
                color: Colors.black,
              ),
              onPressed: () {}),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
              ),
              onPressed: () {}),
        ),
      ),
    );
  }
}
