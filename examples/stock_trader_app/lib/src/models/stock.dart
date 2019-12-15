class Stock {
  final String symbol;
  final double value;

  Stock(this.symbol, this.value);

  factory Stock.fromMap(Map<String, dynamic> data) {
    return Stock(
        data['symbol'],
        data['value']
    );
  }
}