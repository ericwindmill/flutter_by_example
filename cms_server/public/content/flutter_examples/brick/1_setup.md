---
title: "Brick Offline First With Rest"
author: "Tim Shedor"
category: "Flutter UI Example Apps"
subSection: "Brick"
tags:
    - flutter
    - Brick
---

[Brick](https://github.com/greenbits/brick) is a data persistence library in Flutter. It filters data from multiple sources through a single entrypoint - for example, when requesting a list of users, Brick will poll users in-memory, users in SQLite, and, if all else fails, users in Firestore. All of this happens through a consistent query interface and a bunch of generated code, leaving your app to focus on simply _using_ the data.

This tutorial will walk through creating models, interacting with an API endpoint, and finally, rendering data.

As every API varies, one has to be stubbed to plainly illustrate the example.

Save each API response in a `_api` folder in the root of a new Flutter app:

1. `_api/customer.json`
    ```json
    {
      "customer": {
        "id": 1,
        "pizza_ids": [
          1
        ],
        "firstName": "Wallace",
        "lastName": "Wallaceton"
      }
    }
    ```
1. `_api/customers.json`
    ```json
    {
      "customers": [
        {
          "id": 1,
          "pizza_ids": [
            1
          ],
          "firstName": "Wallace",
          "lastName": "Wallaceton"
        }
      ]
    }
    ```
1. `_api/pizza.json`
    ```json
    {
      "pizza": {
        "id": 1,
        "customer_id": 1,
        "frozen": false,
        "toppings": [
          "pepperoni",
          "olives"
        ]
      }
    }
    ```
1. `_api/pizzas.json`
    ```json
    {
      "pizzas": [
        {
          "id": 1,
          "customer_id": 1,
          "frozen": false,
          "toppings": [
            "pepperoni",
            "olives"
          ]
        }
      ]
    }
    ```

Now add `shelf: any` to your pubspec.yaml. And lastly, create the file that will power our local API server:

`server.dart`
```dart
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'dart:io';

void main() {
  var handler = const shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(_echoRequest);

  io.serve(handler, 'localhost', 8080).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
  });
}

Future<shelf.Response> _echoRequest(shelf.Request request) async {
  final endpoints = ["customers", "pizza", "pizzas"];

  return await endpoints
      .fold(shelf.Response.notFound("Request ${request.url} does not match a known endpoint"),
          (acc, endpoint) async {
    final resp = await _jsonForRequest(request, endpoint);
    if (resp != null) return shelf.Response.ok(resp, headers: {"Content-Type": "application/json"});
    return acc;
  });
}

Future<String> _jsonForRequest(shelf.Request request, String fileName) async {
  if (!request.url.toString().startsWith(fileName)) return null;
  return await File("_api/$fileName.json").readAsString();
}
```

Now that our API is stubbed, we can do the regular Brick install:

1. Add the packages to `pubspec.yaml`:
    ```yaml
    dependencies:
      brick_offline_first: any
    dev_dependencies:
      brick_offline_first_with_rest_build:
        git:
          url: https://github.com/greenbits/brick.git
          path: packages/brick_offline_first_with_rest_build
      build_runner: any
    ```
1. Setup Brick's expected folders:
    ```shell
    mkdir -p lib/app/adapters lib/app/db lib/app/models;
    ```

Now we can get to the fun part.
