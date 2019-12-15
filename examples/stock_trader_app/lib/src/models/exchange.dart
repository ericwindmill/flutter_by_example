import 'package:stock_trader_app/src/models/stock.dart';
import 'package:stock_trader_app/src/models/ticker.dart';

// singleton example
class StockExchange {
  List<Ticker> tickers;

  Future<List<Stock>> getStocks() async {}

  Future<Stock> buyStock(Stock stock) {}

  Future<bool> sellStock(Stock stock) {}
}
