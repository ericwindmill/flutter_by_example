---
title: "Adding a Model"
author: "Tim Shedor"
category: "Flutter State and Logic Example Apps"
subSection: "Brick: Offline First with Rest"
tags:
    - flutter
    - Brick
---

Now that we can query data, we need to have data to query. Models are unique to apps, containing the business logic layer required for the system to function. This is analogous to models in Rails or Phoenix.

We'll create a common customer model, saved in `lib/app/models/customer.dart`:

```dart
// import the classes to extend
import 'package:brick_offline_first/offline_first_with_rest.dart';
```

Brick works by generating files through Dart's [build_runner](https://pub.dev/packages/build_runner). To discover these files, all models **must** be in the `model/` directory and they **must** have a domain annotation. Since we're using `OfflineFirstWithRest`, we'll use the `ConnectOfflineFirstWithRest` annotation:

```dart
@ConnectOfflineFirstWithRest()
class Customer extends OfflineFirstWithRestModel {}
```

Since every API is different, the endpoints are very difficult to predict. For each `RestModel` that interacts with a `RestProvider`, an `endpoint:` must be defined. Brick accepts a **function body** (`{...}` or `=> ...;`) with the guaranteed arguments of `instance` (if an instance is provided, such as in an `upsert` or a `delete` call) and `query`. This is stringified as annotations must be constant and functions are not currently considered constant by Dart's type system. This code will be injected unwrapped into our [Adapter](https://github.com/greenbits/brick/tree/master/packages/brick_build#adapter):

```dart
@ConnectOfflineFirstWithRest(
  restConfig: RestSerializable(
    // these match the endpoints configured by our stub server in server.dart
    endpoint: r'''{
    if (query.action == QueryAction.upsert) {
      return "/customers";
    }

    // member endpoint
    if (query.action == QueryAction.get && instance != null) {
      return "/customer/${instance.id}";
    }

    return "/customers";
  }''',
  ),
)
```

The model should reflect the endpoint's data, or at least what we want to send to it. Examining `_api/customer.json`, we apply the JSON property keys as model members:

```dart
class Customer extends OfflineFirstWithRestModel {
  @Sqlite(unique: true)
  final int id;

  final String firstName;

  final String lastName;

  Customer({
    this.id,
    this.firstName,
    this.lastName,
  });
}
```

Our endpoint response includes a `pizza_ids` property, but as we haven't created the `Pizza` model yet, we'll add that member when we're ready.

Our complete `Customer` model:

```dart
import 'package:brick_offline_first/offline_first_with_rest.dart';

@ConnectOfflineFirstWithRest(
  restConfig: RestSerializable(
    endpoint: r'''{
    if (query.action == QueryAction.upsert) {
      return "/customers";
    }

    // member endpoint
    if (query.action == QueryAction.get && instance != null) {
      return "/customer/${instance.id}";
    }

    return "/customers";
  }''',
  ),
)
class Customer extends OfflineFirstWithRestModel {
  @Sqlite(unique: true)
  final int id;

  final String firstName;

  final String lastName;

  Customer({
    this.id,
    this.firstName,
    this.lastName,
  });
}
```
