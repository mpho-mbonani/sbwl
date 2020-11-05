import 'package:SBWL/providers/productProvider.dart';
import 'package:SBWL/providers/productsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpsertProductScreen extends StatefulWidget {
  static const routeName = '/upsertProduct';
  @override
  _UpsertProductScreenState createState() => _UpsertProductScreenState();
}

class _UpsertProductScreenState extends State<UpsertProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  String productTitle;
  double productPrice;
  String productDescription;
  String productImageUrl;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpeg') &&
              !_imageUrlController.text.endsWith('.jpg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      ProductProvider upsertedProduct = ProductProvider(
        id: null,
        title: productTitle,
        price: productPrice,
        description: productDescription,
        imageUrl: productImageUrl,
      );
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(upsertedProduct);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Product Details'),
        actions: [
          IconButton(icon: Icon(Icons.upload_sharp), onPressed: _saveForm)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  productTitle = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'please provide title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  productPrice = double.parse(value);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'please provide price';
                  } else if (double.tryParse(value) == null) {
                    return 'please provide valid number';
                  } else if (double.parse(value) <= 0) {
                    return 'please provide price above zero';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 2,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  productDescription = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'please provide description';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter an image URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please provide image url';
                        } else if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'please provide valid url';
                        } else if (!value.endsWith('.png') &&
                            !value.endsWith('.jpeg') &&
                            !value.endsWith('.jpg')) {
                          return 'please provide valid image url';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        productImageUrl = value;
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
