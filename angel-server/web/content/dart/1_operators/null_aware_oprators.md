---
title: "Null Aware Operators"
author: "Eric"
category: "Dart"
subSection: "Operators"
order: 4
tags:
    - dart
    - operators
---

<span class='lesson-intro-statement'>
The following is an excerpt from the book <a href="">Flutter in Action</a>.
</span>

Null-aware operators are one of my favorite features in Dart. In any language, having variables and values fly around that are `null` can be problematic. It can crash your program. Programmers often have to write `if (response == null) return` at the top of a function to make asynchronous calls. That's not the worst thing ever, but it's not concise.

Null-aware operators in Dart help resolve this issue. They're operators to say, "If this object or value is `null`, then forget about it: stop trying to execute this code."

The number-one rule of writing Dart code is to be concise but not pithy. Anytime you can write less code without sacrificing readability, you probably should. The three null-aware operators that Dart provides are `?.`, `??`, and `??=`.

### The ?. operator

Suppose you want to call an API and get some information about a `User`. And maybe you're not sure whether the user information you want to fetch even exists. You can do a standard null check like this:

```dart
void getUserAge(String username) async {
  final request = new UserRequest(username);
  final response = await request.get();
  User user = new User.fromResponse(response);
  // null check
  if (user != null) {
    this.userAge = user.age;
  }
  // etc.
}
```

That's fine. It works. But the null-aware operators make it much easier. The following operator basically says, "Hey, assign `userAge` to `user.age`. But if the `user` object is `null`, that's okay. Just assign `userAge` to `null`, rather than throwing an error":

```dart
void getUserAge(String username) async {
  final request = UserRequest(username);
  final response = await request.get();
  User user = new User.fromResponse(response);

  // delightfully shorter null check
  this.userAge = user?.age; 
  // etc.
}
```

If `user` is indeed `null`, then your program will assign `userAge` to `null`, but it won't throw an error, and everything will be fine. If you removed the `?.` operator, it would be an error to call `age` on a `null User` object. Plus, your code is more concise and still readable.

> It's worth pointing out that if any code below the line `this.userAge = user?.age;` relied on `useAge` not being `null`, the result would be an error.

### The ?? operator

The second null-aware operator is perhaps even more useful. Suppose you want the same `User` information, but many fields for the user aren't required in your database. There's no guarantee that there will be an age for that user. Then you can use the double question mark (`??`) to assign a "fallback" or default value.

This operator says, "Hey program, do this operation with this value or variable. But if that value or variable is `null`, then use this backup value." It allows you to assign a default value at any given point in your process, and it's super handy:

```dart
void getUserAge(String username) async {
  final request = new UserRequest(username);
  final response = request.get();
  User user = new User.fromResponse(response);
  
  // If user.age is null, defaults to 18
  this.userAge = user.age ?? 18;  <1>
  // etc.
}
```


### The ??= operator

This last null-safe operator accomplishes a goal pretty similar to the previous one, but the opposite. While writing this, I was thinking about how I rarely use this operator in real life. So I decided to do a little research. And wouldn't you know it? I should be using it. It's great.

This operator basically says, "Hey, if this object is `null`, then assign it to this value. If it's not, just return the object as is":

----
int x = 5
x ??= 3;
----

In the second line, `x` will not be assigned 3, because it already has a value. But like the other null-aware operators, this one seeks to make your code more concise.