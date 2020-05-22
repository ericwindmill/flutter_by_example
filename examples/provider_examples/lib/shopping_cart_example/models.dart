import 'dart:async';

import 'package:flutter/material.dart';

class Product {
  final String name;
  final double cost;

  Product({this.name, this.cost});
}

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

class User {
  final String name;
  final Cart cart;

  User({this.name, this.cart});
}

class Store {
  StreamController<List<Product>> _streamController = StreamController<List<Product>>();
  Stream<List<Product>> get allProductsForSale => _streamController.stream;

  Store() {
    _streamController.add(<Product>[]);
    _initialize();
  }

  void _initialize() {
    MockDatabase().getProductsBatched().listen((List<Product> products) {
      _streamController.add(products);
    });
  }

  void dispose() {
    _streamController.close();
  }
}

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

  List<Product> _productsInDatabase = [
    Product(name: 'Carrot', cost: 1.0),
    Product(name: 'Potatoes', cost: 1.0),
    Product(name: 'Tomato', cost: 0.5),
    Product(name: 'Cheese', cost: 1.5),
    Product(name: 'Beans', cost: 1.5),
    Product(name: 'Lettuce', cost: 1.5),
    Product(name: 'Flour', cost: 1.5),
    Product(name: 'Honey', cost: 1.5),
    Product(name: 'Chocolate', cost: 1.5),
    Product(name: 'Asparagus', cost: 1.5),
    Product(name: 'Bread', cost: 1.5),
  ];
}
