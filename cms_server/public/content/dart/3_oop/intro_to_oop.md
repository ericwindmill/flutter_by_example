---
title: "Intro to OOP"
author: "Eric Windmill"
category: "Dart"
subSection: "Object-Oriented Programming"
tags:
    - dart
    - object oriented programming
    - class
    - info
---

<span class='aside'>
The following is an excerpt from the book <a href="https://www.manning.com/books/flutter-in-action">Flutter in Action</a>.
</span>

Modern applications basically all do the same thing: they give us (smart humans) a way to process and collaborate over large data sets. Some apps are about communication, like social media and email. Some are about organization, such as calendars and note taking. Some are simply digital interfaces into a part of the real world that's hard for programmers to navigate, like dating apps. But they all do the same thing. They give users a nice way to interact with data.

Data represents the real world. All data describes something _real_. That's what object-oriented programming is all about: it gives us a nice way to model our data after real-world objects. It takes data, which dumb computers like, and adds some abstraction so smart humans can impose our will onto the computers. It makes code easy to read, easy to reason about, and highly reusable.

When writing Dart code, you'll likely want to create separate classes for everything that can represent a real-world "thing." _Thing_ is a carefully chosen word, because it's so vague. (This is a great example of something that would make a dumb computer explode but that a smart human can make some sense of.)

Consider if we were writing a point-of-sale (POS) system used to sell goods to customers. What kinds of classes do you think you'd need to represent "things" (or data)? What kind of "things" does a POS app need to know about? Perhaps we need classes to represent a `Customer`, `Business`, `Employee`, `Product`, and `Money`. Those are all classes that represent real-world things. But it gets a bit hairier from here.

Ponder some questions with me:

* We may want a class for `Transaction` and `Sale`. In real life, a transaction is a process or event. Should this be represented with a function or a class?
* If we're selling bananas, should we use a `Product` class and give it a property that describes what _type_ of product it is? Or should we have a `Banana` class?
* Should we define a top-level variable or a class that has only a single property? For instance, if we need to write a function that simply adds two numbers together, should we define a `Math` class with an `add` method, or just write the method as a static, global variable?

Ultimately, these decisions are up to you, the programmer. There is no single right answer.

My rule of thumb is, "When in doubt, make a new class." Recall those previous questions: should a transaction be represented by a function of `Business` or its own class? I'd say make it a class. And that brings me all the way back to why I used the vague word _thing_ earlier. A thing isn't just a physical object; it can be an idea, an event, a logical grouping of adjectives, and so on. In this example, I would make a class that looks like this:

```dart
class TransactionEvent {
  // properties and methods
}
```

And that might be it. It might have no properties and no methods. Creating classes for events makes the type safety of Dart that much more effective.

The bottom line is that you can (and, I'd argue, should) make a class that represents any "thing" that isn't obviously an action you can do or a word you'd use to describe some detail of a "thing." For instance, you (a human) can exchange money with someone. It makes sense to say "I exchange money." It doesn't make sense to say, "I transaction," even though a transaction is an idea. Having a `Transaction` class makes sense, but an `ExchangeMoney` class doesn't.
