/// solution
/// (main.dart is derived from solution)
List<int> getOddNumsOver10(List<int> nums) {
  return nums.skipWhile((int n) => n < 11).where((int i) => i % 2 != 0).toList();
}

/// test
List<int> sortedNums = [2, 5, 7, 10, 12, 19, 92, 106];

void main() {
  final oddNumsOver10 = getOddNumsOver10(sortedNums);
  if (oddNumsOver10.contains(2) ||
      oddNumsOver10.contains(5) ||
      oddNumsOver10.contains(7) ||
      oddNumsOver10.contains(10)) {
    _result(false, ['the function getOddNumsOver10 should not contain any numbers less than 11']);
  }

  if (oddNumsOver10.any((int i) => i % 2 == 0)) {
    _result(false, ['the function getOddsOver10 should not contain any even numbers']);
  }

  _result(true, ['All tests passed.', 'yeet']);
}

/// hint.txt
/// This will require using `where` and `skipWhile` together

/// mock _result for local dev purposes
void _result(bool success, [List<String> messages]) {
  final joinedMessages = messages?.map((m) => m.toString())?.join(',') ?? '';
  print('success: $success, "messages": $joinedMessages');
}
