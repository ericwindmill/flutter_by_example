---
title: "Rendering Models"
author: "Tim Shedor"
category: "Flutter State and Logic Example Apps"
subSection: "Brick: Offline First with Rest"
tags:
    - flutter
    - Brick
---

Now that the repository can fetch and create the model using generated code, the model needs to be rendered. First, the repository needs to be initially configured to set its base API URL:

```dart
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // be sure to run `dart server.dart` before using this example
    Repository.configure('http://localhost:8080');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container()
  }
}
```

The Repository also needs to run some setup code. In our case with `OfflineFirstWithRest`, that's SQLite migrations. We'll add a `migrated` member to track whether this setup has been completed:

```dart
class _MyHomePageState extends State<MyHomePage> {
  var migrated = false;
  @override
  void initState() {
    // be sure to run `dart server.dart` before using this example
    Repository.configure('http://localhost:8080');
    // Note that subsequent boots of the app will use cached data
    // To clear this, wipe data on android or tap-press on iOS and delete the app
    Repository().initialize().then((_) => setState(() => migrated = true));
    super.initState();
  }
```

And in our widget, a toggle to prevent data fetching while the database is being migrated:

```dart
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: migrated ? Container() : Text("Migrating database..."),
  );
}
```

Brick should be accessed outside a widget to prevent duplicate refetching on every rerender. However, to keep this complicated example straightforward, fetching will be handled by a `FutureBuilder` widget:

```dart
FutureBuilder(
  future: Repository().get<Customer>(),
  builder: (context, AsyncSnapshot<List<Customer>> customerList) {
    final customers = customerList.data;
  },
),
```

Next, in anticipation of receiving a list of customers, we'll create a widget that accepts an instance of the model and renders its basic properties:

```dart
class CustomerTile extends StatelessWidget {
  final Customer customer;

  CustomerTile(this.customer);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('id: ${customer.id}'),
        Text('name: ${customer.firstName} ${customer.lastName}'),
      ],
    );
  }
}
```

Finally we combine everything and render a `ListView` of `CustomerTile`s:

```dart
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var migrated = false;
  @override
  void initState() {
    // be sure to run `dart server.dart` before using this example
    Repository.configure('http://localhost:8080');
    // Note that subsequent boots of the app will use cached data
    // To clear this, wipe data on android or tap-press on iOS and delete the app
    Repository().initialize().then((_) => setState(() => migrated = true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: migrated
          ? Container(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder(
                future: Repository().get<Customer>(),
                builder: (context, AsyncSnapshot<List<Customer>> customerList) {
                  final customers = customerList.data;

                  return ListView.builder(
                    itemCount: customers?.length ?? 0,
                    itemBuilder: (ctx, index) => CustomerTile(customers[index]),
                  );
                },
              ),
            )
          : Text("Migrating database..."),
    );
  }
}

class CustomerTile extends StatelessWidget {
  final Customer customer;

  CustomerTile(this.customer);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('id: ${customer.id}'),
        Text('name: ${customer.firstName} ${customer.lastName}'),
        Text('pizzas:'),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              for (var pizza in customer.pizzas) Text('id: ${pizza.id}\nfrozen: ${pizza.frozen}'),
            ],
          ),
        )
      ],
    );
  }
}
```
