/// solution
class Queue<T> {
  List<T> _internal = <T>[];

  T peek() => _internal.first;

  T dequeue() => _internal.removeAt(0);

  void enqueue(T value) => _internal.add(value);
}

/// test
void main() {
  final queue = Queue<int>();
  queue.enqueue(1);
  if (queue.peek() != 1) {
    _result(false, ["peek did not return the first element"]);
  }
  if (queue._internal.length != 1) {
    _result(false, ["expected queue of length 1 after adding one element and peeking"]);
  }
  final popped = queue.dequeue();
  if (popped != 1) {
    _result(false, ["expected the first element added to the queue when `dequeue` is called."]);
  }

  _result(true, ["Good work, fam"]);
}

/// hint
// Peek should show the element that was added least recently, but not remove it.

/// mock _result
void _result(bool b, List<String> msgs) {}