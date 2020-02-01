---
title: "Adding an Association"
author: "Tim Shedor"
category: "Flutter State and Logic Example Apps"
subSection: "Brick: Offline First with Rest"
tags:
    - flutter
    - Brick
---

Say our system tracks every pizza a customer orders. This is an association, with the pizza as a child model or the parent customer model. Brick automagically syncs and hydrates associations, removing all the painful boilerplate of writing this out manually.

First, we'll make the association model in `lib/app/models/pizza.dart`:

```dart
@ConnectOfflineFirst()
class Pizza extends OfflineFirstWithRestModel {
  /// Read more about `@Sqlite`: https://github.com/greenbits/brick/tree/master/packages/brick_sqlite#fields
  @Sqlite(unique: true)
  final int id;

  /// Read more about `@Rest`: https://github.com/greenbits/brick/tree/master/packages/brick_rest#fields
  @Rest(enumAsString: true)
  final List<Topping> toppings;

  final bool frozen;

  Pizza({
    this.id,
    this.toppings,
    this.frozen,
  });
}

enum Topping { olive, pepperoni }
```

We'll apply similar endpoint code to our `Pizza`:

```dart
@ConnectOfflineFirstWithRest(
  restConfig: RestSerializable(
    endpoint: r'''{
    if (query.action == QueryAction.upsert) {
      return "/pizzas";
    }

    if (query.action == QueryAction.get && query?.where != null) {
      final byId = Where.firstByField('id', query.where);
      // member endpoint
      if (byId.value != null) {
        return "/pizza/${byId.value}";
      }
    }

    if (query.action == QueryAction.get) {
      return "/pizzas";
    }

    return null;
  }''',
  ),
)
```

Great. Let's generate the new migration for `Pizza` as well as its adapter:

```shell
flutter pub run build_runner build
```

Our complete `Pizza` model:

```dart
import 'package:brick_offline_first/offline_first_with_rest.dart';

@ConnectOfflineFirstWithRest(
  restConfig: RestSerializable(
    endpoint: r'''{
    if (query.action == QueryAction.upsert) {
      return "/pizzas";
    }

    if (query.action == QueryAction.get && query?.where != null) {
      final byId = Where.firstByField('id', query.where);
      // member endpoint
      if (byId.value != null) {
        return "/pizza/${byId.value}";
      }
    }

    if (query.action == QueryAction.get) {
      return "/pizzas";
    }

    return null;
  }''',
  ),
)
class Pizza extends OfflineFirstWithRestModel {
  /// Read more about `@Sqlite`: https://github.com/greenbits/brick/tree/master/packages/brick_sqlite#fields
  @Sqlite(unique: true)
  final int id;

  /// Read more about `@Rest`: https://github.com/greenbits/brick/tree/master/packages/brick_rest#fields
  @Rest(enumAsString: true)
  final List<Topping> toppings;

  final bool frozen;

  Pizza({
    this.id,
    this.toppings,
    this.frozen,
  });
}

enum Topping { olive, pepperoni }
```

### Adding the Association to a Parent Model

The Customer model is now ready to have the Pizza association. Using the `@OfflineFirst` annotation, the key will specify the lookup field of the child model. The value will be the input source, including the deserializing variable name. `data` is always used when deserializing. Some APIs may return a nested map (such as `data['pizza']['ids']`). However, our API is simple and uses a top-level property. Note that `data['pizza_ids']` could be a JSON array or a single value, and these would be defined to `OfflineFirst(where:)` identically.

```dart
class Customer extends OfflineFirstWithRestModel {
  @OfflineFirst(where: {'id': "data['pizza_ids']"})
  // Specifying the `@Rest` name is necessary for upsert and delete methods
  @Rest(name: 'pizza_ids')
  final List<Pizza> pizzas;
}
```

A foreign key migration is now necessary on the parent model. Generate a new migration:

```shell
flutter pub run build_runner build
```

### Rendering

Back in our Flutter app, the `CustomerTile` widget needs to be adjusted to display the pizzas and their properties:

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

When we load the homepage, we should now see a list of users with their pizzas.
