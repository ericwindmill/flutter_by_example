import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models.dart';

void main() async {
  final user = await MockDatabase().login();

  runApp(
    MultiProvider(
      providers: [
        Provider<Cart>(create: (_) => Cart()),
        Provider<User>.value(value: user),
        Provider<Store>(create: (_) => Store()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductsPage(),
    );
  }
}

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery Store"),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return CartPage();
                      },
                    ),
                  );
                },
              ),
              Positioned(
                top: 10.0,
                left: 10.0,
                child: Container(
                  height: 10.0,
                  width: 10.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: StreamProvider<List<Product>>(
        initialData: [],
        create: (_) => Provider.of<Store>(context).allProductsForSale,
        catchError: (BuildContext context, error) => <Product>[],
        child: Container(),
        builder: (BuildContext context, Widget child) {
          final items = context.watch<List<Product>>();
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              if (items.isEmpty) {
                return Text('no products for sale, check back later');
              }
              final item = items[index];
              return ListTile(
                title: Text(item.name ?? ''),
                trailing: Text(item.cost.toString() ?? ''),
                onTap: () {
                  context.read<Cart>().addToCart(item);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => User(name: 'Yohan'),
      builder: (BuildContext context, Widget body) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.watch<User>().name + 's Cart'),
          ),
          body: body,
        );
      },
      child: Container(),
    );
  }
}
