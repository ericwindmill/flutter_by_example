---
title: "Looping: for-in and forEach"
author: "Eric Windmill"
category: "Dart"
subSection: "Iterables, Iterators, and Collections"
tags:
    - dart
    - loops
    - iterables
---

<div class='aside'>
For most of the remainder of the section, I'll be using `List`, as its the most common iterable, but most of the knowledge could be applied to all iterables, including `Set`. 
</div>

Lists (and iterables and sets) are the primary objects that you'll _loop_ over. You can see basic examples of `for`, `while` and `do-while` loops in the Loops lesson in the Control Flow section. Here, let's take a deeper look at two other looping mechanisms: `for-in` loops and the `forEach` method on iterables.

Both are used for the same purpose: performing an action on _each_ element in the list. Importantly, both are used primarily for _side effects_. The original list will not be changed, nor will you be returned any new value from these methods.  

### for-in loops

For-in loops function similarly to standard `for` loops, but there are two differences: 
    1. It easier to write. 
    2. You won't have access, by default, to the index of the element in the list.

For-in loops are preferable to for loops to me, because they are cleaner, but they don't really solve any problem that standard for loops wont.

This example shows the syntax for for-in loops, but as you can see there is no built-in way to get the index of the element in the list. It

```run-dartpad:theme-light:run-false:split-60
void main() {
   List<int> ages = [29, 27, 42];
   for (var age in ages) {
     print(age);
  }
}
```

### forEach

`List.forEach` is a looping mechanism that is more difficult to grasp (if you aren't familiar with call backs), and provides very little benefit over using a for-loop.

It's best to just look at some code:

```run-dartpad:theme-light:run-false:split-60
void main() {
   List<int> ages = [29, 27, 42];
    // the arguement that forEach expects is 
    // a *call back*. This function will be called on
    // each element
   ages.forEach((int age) => print(age));
}
```

That looks a bit more complex, but does the _exact_ same thing as the first example using `for-in` loop. In fact, look at this example comparing the two.


```run-dartpad:theme-light:run-false:split-60
void main() {
   List<int> ages = [29, 27, 42];
    
    // should print 30, 28, 43
    for (var age in ages) {
        _addAndPrint(age);
    }

    // should print 30, 28, 43
    ages.forEach((int age) => _addAndPrint(age));
}

void _addAndPrint(int number) {
    print(1 + number);
}
```

While for-each is more complex to write, it's often favored because of how terse the code looks. For our purposed, it's important because many of the future methods we'll explore on lists and iterables follows this same pattern. 

<div class='aside'>
These methods that operate on collections are often called _functional_ methods in JavaScript, Dart, and beyond. If you hear someone talking about _functional_ programming in JS, they're likely talking about these specific methods, and not about pure functional programming. These methods are like a piece of functional programming languages that's been borrowed by languages that aren't necessarily functional.
In any case, they're used _a lot_ in UI development, so it's good to know them. 
</div>

### Try looping

<iframe style="height:400px;" src="https://dartpad.dev/embed-inline.html?id=510e84f2bf31e395073aff739046d02f&split=60&theme=dark"></iframe>


