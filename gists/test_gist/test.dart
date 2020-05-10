var items = [
  'Salad',
  'Popcorn',
];

void main() {
  final upperCased = listToUpperCase(items);
  for (var item in upperCased) {
    if (item == 'SALAD' || item == 'POPCORN') {
      continue;
    } else {
      _result(false, [""]);
    }
  }
  _result(true, [""]);
}