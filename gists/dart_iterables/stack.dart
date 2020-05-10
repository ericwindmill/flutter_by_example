/// solution
class Stack<T> {
  List<T> _internal = <T>[];

  T peek() => _internal.last;

  T pop() => _internal.removeLast();

  void push(T value) => _internal.add(value);
}

/// test
void main() {
  final stack = Stack<int>();
  stack.push(1);
  stack.push(2);
  if (stack.peek() != 2) {
    _result(false, ["peek did not return the top element in the stack"]);
  }
  if (stack._internal.length != 2) {
    _result(false, ["expected stack of length 2 after adding two elements and peeking"]);
  }
  final popped = stack.pop();
  if (popped != 2) {
    _result(false, ["expected the last element added to the stack when `push` is called."]);
  }

  _result(true, ["Good work, fam"]);
}

/// hint
// Peek should show the element that was added least recently, but not remove it.

/// mock _result
void _result(bool b, List<String> msgs) {}
