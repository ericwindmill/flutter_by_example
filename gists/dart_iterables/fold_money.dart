/// solution
/// (main.dart is derived from solution)
class User {
  final String name;
  final int money;

  User(this.name, this.money);
}

int combineFriendsMoney(List<User> friends) {
  return friends.fold(0, (int newTotal, User friend) {
    return newTotal + friend.money;
  });
}

/// test
final scott = User('Scott', 10);
final ellen = User('Ellen', 12);
final morgen = User('Morgen', 15);
final phoebe = User('Phoebe', 9);

final friends = [scott, ellen, morgen, phoebe];

void main() {
  final friendsMoneyCombined = combineFriendsMoney(friends);
  if (friendsMoneyCombined != 46) {
    _result(false, ["amount expected from combineFriendsMoney was wrong"]);
  }

  _result(true, ['All Tests Passed woo woo']);
}

/// hint.txt
/// Try using 'fold' to derive a value of a different type.

/// mock _result for local dev purposes
void _result(bool success, [List<String> messages]) {
  final joinedMessages = messages?.map((m) => m.toString())?.join(',') ?? '';
  print('success: $success, "messages": $joinedMessages');
}
