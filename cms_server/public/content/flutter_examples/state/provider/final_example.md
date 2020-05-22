---
title: "The final example (A shopping cart app)"
author: "Eric Windmill"
category: "Flutter State and Logic Example Apps"
subSection: "Provider"
tags:
    - flutter
    - state management
    - provider
    - proxy provider
    - stream provider
---

There is no new information here, but rather an app that uses multiple providers, over multiple screens. That in mind, this lesson is broken down into two parts: the full app, running in DartPad, followed by some explanations for some of the parts that may be harder to grok.

<iframe style="height:800px" src="https://dartpad.dev/embed-flutter.html?theme=dark&run=true&split=60&id=b0cdc975cdb48076fc3016586693b92c"></iframe>

### Breaking down interesting parts

The app isn't all that interesting, but there are a few code examples that will help drive home the ideas of provider.

- First, let's take a look at the models, so the rest of the code makes sense

```dart
// The product class does nothing fancy
class Product {
  final String name;
  final double cost;

  Product({this.name, this.cost});
}

// This class tracks the products that 
// the user wants to buy, and it's a [ChangeNotifier]
class Cart with ChangeNotifier {
  List<Product> products = [];

  double get total {
    return products.fold(0.0, (double currentTotal, Product nextProduct) {
      return currentTotal + nextProduct.cost;
    });
  }

  void addToCart(Product product) => products.add(product);
  void removeFromCart(Product product) {
    products.remove(product);
    notifyListeners();
  }
}

// The user class does nothing fancy.
class User {
  final String name;
  final Cart cart;

  User({this.name, this.cart});
}

class Store {
  // Perhaps we're going to use a StreamProvider?
  StreamController<List<Product>> _streamController = StreamController<List<Product>>();
  Stream<List<Product>> get allProductsForSale => _streamController.stream;
  
  // rest of class
}

// This class is a singleton that mocks out two pieces of functionality:
// Logging in a user
// And fetching products from a realtime data base (like FireStore)
class MockDatabase {
  static final MockDatabase _instance = MockDatabase._internal();

  factory MockDatabase() {
    return _instance;
  }

  MockDatabase._internal();

  Future<User> login() async {
    return await Future.delayed(Duration(seconds: 1), () {
      return User(name: 'Yohan', cart: Cart());
    });
  }

  // Imagine this is like calling Firestore.get('products').listen(...);
  // Anytime there are new products in the databse, they'll be pushed down
  // to the app.
  Stream<List<Product>> getProductsBatched() async* {
    List<Product> allProducts = [];

    var i = 0;
    while (i < 10) {
      await Future.delayed(Duration(seconds: 1), () {
        allProducts.add(_productsInDatabase[i]);
      });
      i++;
      yield allProducts;
    }
  }
  // rest of class...

}

```

- The app starts with a `MultiProvider` to provide some models to the entire app.

```dart
void main() async {
  // creating a use right off the bat is 
  // contrived so I can use a `.value` constructor.
  final user = await MockDatabase().login();

  runApp(
    MultiProvider(
      providers: [
        // The user provider uses a value constructor because the value
        // already exists, and we want to make sure we're using the same user
        Provider<User>.value(value: user),

        // Store and Cart are both needed on the home page,
        // so they're provided right off the bat
        Provider<Store>(create: (_) => Store()),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
      ],
      child: MyApp(),
    ),
  );
}
```

Nothin' too fancy there. Let's move into the `Scaffold.body` property of the `build` method for the `ProductsPage`, where we're going to use a `StreamProvider`

```dart
// The StreamProvider is providing a single property from the Cart,
// not the Cart itself. Thus, StreamProvider<List<Product>>
body: StreamProvider<List<Product>>(
  initialData: [],
  // using Provider to fetch a model and return a property from it? Fancy!
  create: (_) => Provider.of<Store>(context).allProductsForSale,
  catchError: (BuildContext context, error) => <Product>[],
  // List equality has nothing to do with the elements in the list
  // Therefor, in order to tell Flutter that list has changed, we need to compare a 
  // property of the list that will be different when elements are added or removed.
  updateShouldNotify: (List<Product> last, List<Product> next) => last.length == next.length,
  builder: (BuildContext context, Widget child) {
    final items = context.watch<List<Product>>(); // context.watch rules
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
            // notice that this calls a method on `Cart`, 
            // but Cart isn't used anywhere else on this page.
            // This is an example of one model being shared across screens,
            // And I promise its far easier than passing values from one 
            // screen to another during navigation
            context.read<Cart>().addToCart(item);
          },
        );
      },
    );
```

- Lastly, let's peak at the other page:

```dart
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<User>().name + 's Cart'),
      ),
      // Consumer + a ChangeNotifier (cart) will ensure that 
      // That this portion of the tree rebuilds when Cart.notifyListeners() is called.
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
                        // context.read is the easiest way to call 
                        // methods on a provided model
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
                  // remember, context.select allows you to 
                  // listen to specific properties, and ignore the rest of a class
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
```

Hopefully this slightly more robust example shows you how different classes from Provider all work along side each-other, even across pages. 

But, that's it. You've solved my Provider puzzle! Checkout [Provider docs](https://pub.dev/packages/provider) for even more classes and updates to the package.




