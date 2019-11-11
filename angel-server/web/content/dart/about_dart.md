---
title: "About Dart"
author: "Eric"
category: "Dart"
subSection: "About Dart"
order: 1
tags:
    - dart
---

<div class='aside'>

## Sections

* [Meet Dart](#about-dart)
* [Why Does Flutter Use Dart](#why-dart)

</div>

### About Dart

> Dart is an application programming language that’s easy to learn, easy to
> scale, and deployable everywhere. Google depends on Dart to make very large apps.
> -dartlang.org

The first hurdle for most would-be Flutter developers is being convinced to
 learn a new, sparsely used Language: Dart. (Although, Dart has been growing
 like crazy, thanks to Flutter. More on that in a bit.)  
 
In order to write Flutter apps, it's important that you also learn Dart. We
'll do that first:

Dart is a programming language. And programming languages can be, as it turns
out, hard to learn. The fundamentals of Dart are similar to all higher-level
languages. You’ll find familiarity in Dart syntax if you’re coming from
JavaScript, Java, or any other C-like language. You’ll feel comfortable with
Dart’s object-oriented design if you’re coming from Ruby or Python.

Dart excels at being a "safe" language to learn. Google didn't set out to
 create anything innovative with Dart. Google wanted to make a language that
 was simple and productive and that could be compiled into JavaScript. What
 Google came up with, it turns out, works well for writing UIs.
 
In a nutshell, Dart is an object-oriented, class defined, single inheritance
language using a C-style syntax that transcompiles optionally into
JavaScript. It supports interfaces, mixins, abstract classes, reified
generics, optional typing, and a sound type system.

Lastly, Dart is always improving quite a bit. It is very much in constant
 development. Don't worry, though. There won't be any new breaking changes
 , just improvements and additional features.

### Why Does Flutter Use Dart?

To us, the mobile developers, Flutter appears to be nothing more than a Dart
library (although it is much more under the hood). So, why does Flutter rely
so heavily on this relatively unknown language?

According to members of the Flutter team themselves, there are several
 reasons. Let's get the controversial reason out of the way first:  

Dart is owned and maintained by Google. I think Google owning Dart _is_ an
 advantage. In the last few years, Dart has made great strides to be a nice
language specifically for writing modern UIs. The Dart team and Flutter team
 get to work closely together on feature development. This relationship
  allows Dart to support Flutter, rather than Flutter rely on outside forces. 

- Dart supports both just in time (JIT) compiling and ahead of time (AOT
) compiling:
-- The AOT compiler changes Dart into efficient native code. This makes Flutter
 fast (a win for the user and the developer), but it also means that (nearly) the entire framework is written in Dart. For you, the developer, that means you can customize almost everything.
-- Dart’s optional JIT compiling allows hot-reloading to exist. Fast
 development and iteration is a key to the joy of using Flutter.
- Dart is object-oriented. This makes it easy to write visual user
 experiences with Dart, with no need for a markup language.
- Dart is a productive, predictable language. Whether you come from a dynamic language or a static
  language, you can get up and running with ease. 
- The type system and object orientation make it easy to reason about writing
 reusable components for the UI. 
- And, Dart includes a few functional programming features that make it
 easier to turn your data into pieces of UI.
 - Finally, asynchronous, stream -based programming features are first-class
citizens in Dart. These features are used heavily in reactive programming, which is the paradigm of today. 

Lastly, Dart excels at being a language that's easy to learn. As a co-worker
 of mine said about hiring, "We don't have to find Dart people, only smart people."