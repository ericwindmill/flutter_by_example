import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models.dart';

void main() async {
  final user = await MockDatabase().login();

  runApp(
    MultiProvider(
      providers: [
        Provider<User>.value(value: user),
        Provider<Store>(create: (_) => Store()),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
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
        updateShouldNotify: (List<Product> last, List<Product> next) => last.length == next.length,
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
                subtitle: Text('cost: ${item.cost.toString() ?? 'free'}'),
                trailing: Text('Add to Cart'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<User>().name + 's Cart'),
      ),
      body: Consumer<Cart>(
        builder: (BuildContext context, Cart cart, Widget child) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: cart.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (cart.products.isEmpty) {
                      return Text('no products in cart');
                    }
                    final item = cart.products[index];
                    return ListTile(
                      title: Text(item.name ?? ''),
                      subtitle: Text('cost: ${item.cost.toString() ?? 'free'}'),
                      trailing: Text('tap to remove from cart'),
                      onTap: () {
                        context.read<Cart>().removeFromCart(item);
                      },
                    );
                  },
                ),
              ),
              Divider(),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'TOTAL: ${context.select((Cart c) => c.total)}',
                  style: Theme.of(context).textTheme.headline3,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
