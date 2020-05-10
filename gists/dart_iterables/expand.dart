/// solution / main
class Customer {
  final List<Order> pastOrders;

  Customer(this.pastOrders);
}

class Order {
  final List<Item> itemsPurchased;

  Order(this.itemsPurchased);
}

class Item {
  final String name;
  final int cost;

  Item(this.name, this.cost);
}

/// test
final Item lineItemSoap = Item('Soap', 2);
final Item lineItemRice = Item('Rice', 2);
final Item lineItemSoup = Item('Soup', 1);
final Item lineItemSocks = Item('Socks', 4);

final Order order1 = Order([lineItemRice, lineItemSoap]);
final Order order2 = Order([lineItemSocks, lineItemSoup]);

final Customer customer = Customer([order1, order2]);

void main() {
  final allLineItemsFromCustomer = extractItemsFromOrdersForCustomer(customer);
  if (allLineItemsFromCustomer is! List<Item>) {
    _result(false, ['the function did not return a List<Item> type']);
  }
  if (allLineItemsFromCustomer.length != 4) {
    _result(false, [
      'the function extractItemsFromOrdersForCustomer should have returned a list of length 4',
      'Got a list of length ${allLineItemsFromCustomer.length}.'
    ]);
  }

  _result(true, ['All tests passed!', 'Good job, fam']);
}

List<Item> extractItemsFromOrdersForCustomer(Customer customer) {
  final items = customer.pastOrders.expand((Order o) => o.itemsPurchased).toList();
  return items;
}

/// hint
///

/// mock _result
void _result(bool b, List<String> msgs) {}
