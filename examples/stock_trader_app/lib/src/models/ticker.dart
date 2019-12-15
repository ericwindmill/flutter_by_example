import 'dart:convert';

import 'package:stock_trader_app/src/models/stock.dart';

class Ticker {
  final DateTime from;
  final List<Stock> stocks;

  Ticker({
    this.from,
    this.stocks,
  });

  /// Parse tutorial
  factory Ticker.fromString(String data) {
    final decoded = jsonDecode(data);
    final stocks = decoded['stocks'].map((s) => Stock.fromMap(s)).toList().cast<Stock>();
    return Ticker(
      from: DateTime.tryParse(decoded['from']),
      stocks: stocks,
    );
  }
}
