---
title: "Generating Code"
author: "Tim Shedor"
category: "Flutter UI Example Apps"
subSection: "Brick Offline First with Rest"
tags:
    - flutter
    - Brick
---

Brick hides away the ugly part of fetching data from different sources. Now that we have a model, we need to create its [Adapter](https://github.com/greenbits/brick/tree/master/packages/brick_build#adapter). The Adapter (de)serializes model instances to and from multiple providers.

To generate all the necessary code for Brick run in the console:

```shell
flutter pub run build_runner build
```

:warning: Sometimes `schema.g.dart` does not detect the new migration on a first build. Run `flutter pub run build_runner build` again if this is the case.

To keep generated code up-to-date and making a new migration on every model save, use build_runner's watch:

```shell
flutter pub run build_runner watch
```

### Optional Steps

Generated code should not be committed. Adding these lines to `.gitignore` is not required, but it is strongly recommended:

```
*.g.dart
# alternately, uncomment the lines below to only target brick files
# app/adapters/*.dart
# app/db/*.g.dart
# app/brick.g.dart
```


While not required, it's recommend to run this command on every checkout from git. Adding these lines to `.git/hooks/post-checkout` help keep teams in sync when generated code is not committed

```
# .git/post-checkout
#!/bin/sh

cd `dirname "$0"`
cd ../../
flutter pub get
flutter pub run build_runner build
```
