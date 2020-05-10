/// solution
class User {
  final String name;
  final List<Role> roles;

  User(this.name, this.roles);
}

enum Role {
  engineer,
  manager,
  QA,
}

bool userCanTest(User u) {
  return u.roles.any((Role r) => r == Role.QA);
}

bool isSuperUser(User u) {
  return Role.values.every((Role r) => u.roles.contains(r));
}

/// test
void main() {
  var user1 = User("Sarah", [Role.engineer, Role.QA]);
  var user2 = User("Ali", [Role.QA, Role.engineer, Role.manager]);

  final user1CanTest = userCanTest(user1);
  final user2HasEvery = isSuperUser(user2);

  if (!user1CanTest) _result(false, ["canTestUser didn't return true"]);
  if (!user2HasEvery) _result(false, ["isSuperUser didn't return true"]);

  _result(true, ["Good work, fam"]);
}

/// hint
/// try using `any` on user.roles and `every` on Role.values

/// mock _result
void _result(bool b, List<String> msgs) {}
