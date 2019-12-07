---
title: "Intro and Setup"
author: "Eric"
category: "Flutter Examples"
subSection: "Basic UI App"
tags:
    - flutter
    - example
    - setup
---

> It's a Good Framework, Brant.

In this basic app tutorial we'll build a very simple, **pure Flutter app**, inspired by the greatest Twitter conversation of all time -- the We Rate Dogs v. Brant showdown of 2012.

The idea here is that we won't pull in any extra packages, we won't think about architecture or state management. We'll just use the tools that Flutter gives us out of the box to learn the basics.

By the end of this, you should be pretty amazed by how much Flutter gives us out of the box -- and we won't cover nearly everything.

This is what you're making:

![add dog](https://res.cloudinary.com/ericwindmill/image/upload/c_scale,w_300/v1520699901/flutter_by_example/new_dog.gif)
![good dogs](https://res.cloudinary.com/ericwindmill/image/upload/c_scale,w_300/v1520699902/flutter_by_example/good_dogs.gif)

Finished source code: [We Rate Dogs example app](https://github.com/ericwindmill/flutter_by_example/examples/we_rate_dogs/basic_example)

We'll just start this from a fresh app. Once you have [Flutter installed on your machine and your environment set up](https://flutter.io), create a new Flutter app:

```bash
flutter create basic_flutter_app
cd basic_flutter_app
flutter run
```

Alternatively you can clone the pre-generated app from [GitHub](https://github.com/ericwindmill/flutter_by_example_apps).

```bash
git clone https://github.com/ericwindmill/flutter_by_example_apps.git
cd flutter_by_example_apps/blank_flutter_app
flutter packages get
flutter run
```

This will give you a fresh, blank Flutter app.
