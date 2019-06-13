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


## Todo:

- content
    - transfer and update/revise all posts from current FBE
    - set up image hosting
    - copy all examples over from current FBE, and make sure they're correct
    - write more!
    
- client
    - syntax highlighting
    - styling blog post in general
    - potentially add Disqus comments?
    - potentially add interactive feature to run code
    - implement search
    
- server
    - validate frontmatter
    - support sub folders for content
    - implement API for search
    
