import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/authProvider.dart';
import 'screens/authScreen.dart';
import 'screens/ordersScreen.dart';
import 'providers/ordersProvider.dart';
import 'providers/cartProvider.dart';
import 'providers/productsProvider.dart';
import 'screens/manageProductsScreen.dart';
import 'screens/cartScreen.dart';
import 'screens/productDetailScreen.dart';
import 'screens/productsScreen.dart';
import 'screens/upsertProductScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: (_) => ProductsProvider('', '', []),
          update: (ctx, authProvider, previousState) => ProductsProvider(
              authProvider.token,
              authProvider.userId,
              previousState == null ? [] : previousState.products),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          create: (_) => OrdersProvider('', '', []),
          update: (ctx, authProvider, previousState) => OrdersProvider(
              authProvider.token,
              authProvider.userId,
              previousState == null ? [] : previousState.orders),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, authProvider, _) => (MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SBWL',
          theme: ThemeData(
            primarySwatch: Colors.lime,
          ),
          home: authProvider.isAuthenticated ? ProductsScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            ManageProductsScreen.routeName: (context) => ManageProductsScreen(),
            UpsertProductScreen.routeName: (context) => UpsertProductScreen()
          },
        )),
      ),
    );
  }
}
