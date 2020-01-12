# Flutter (and Dart) by Example mono repo.

development:

- First, make sure Dart2 and Angel are installed on your machine
[Dart 2](https://dart.dev/get-dart)
[Angel framework](https://github.com/angel-dart)

```text
cd common
pub get

cd ../angel-server
pub get
dart --observe bin/dev.dart

cd ../clients/web
pub get
webdev serve
```

Server is running at localhost:3000
Site is running at localhost:8080