import 'package:SBWL/providers/ordersProvider.dart';
import 'package:SBWL/widgets/menu.dart';
import 'package:SBWL/widgets/orderItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<OrdersProvider>(context, listen: false)
          .fetchAndSetOrders()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Orders'),
      ),
      drawer: Menu(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: ordersProvider.orders.length,
              itemBuilder: (ctx, i) => OrderItem(ordersProvider.orders[i]),
            ),
    );
  }
}
