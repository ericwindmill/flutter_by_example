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
    - set up image hosting
    - copy all examples over from current FBE, and make sure they're correct
    - grand vision:
        - section about Dart language features (like current) (documentation-like)
        - section about Flutter language features (documentation-like)
        - section of deep dives into single topics with small examples (like Wes Bos's JavaScript 30)
        - section of robust example Dart tutorials w/ accompanying lessons (tutorial like)
        - section of robust example Flutter apps w/ accompanying lessons (like current flutterbyexample) (tutorial like)
    
- client
    - ~~support subfolders in routes~~
    - syntax highlighting that doesn't stink
    - ~~initial styling blog post in general~~
    - potentially add Disqus comments?
    - potentially add interactive feature to run code?
    - implement search
    - add `User` feature, allowing users to log in and save progress.
        - Probably should use Firestore for this: easy, built in Auth.
    - add mailing list form
    
- server
    - validate frontmatter
    - improve ToC functionality with yaml
        - see [angel-server/web/post_order.yaml] for an example
    - ~~support sub folders for table of contents~~
        - ~~getting TOC supports sub folders~~
        - ~~getting single page should search through all subfolders and find the one that matches the request~~
            - ~~i.e.: "/content/test.md" will find "/content/dart/test.md"~~
    - v2: implement a cache on the server
    - v2: implement API for search
    - v2: Implement auth

- deploy
    - Add Travis CI/CD with github hook
    - deploy Heroku

    
