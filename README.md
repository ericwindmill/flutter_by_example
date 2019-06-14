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
    - support subfolders in routes. Two possibilities
        1. Make the client smarter and have routes follow this format: "posts/:category/:postTitle"
            - pros: 
                - faster, less code -- because its done for me by `angel_static` library 
            - cons
                - logic in the client is a no-no for this project
        2. Make the server smarter and find search the filesystem for that md file
            - pros: 
                - more flexible
                - this way, the file structure of the "cms" doesn't matter. it's only for the user (me)
            - cons:
                - could be slow, potentially have to loop through all files. # of files is limited, though.
                - lose automatic functionality from `angel_static`.  
    - syntax highlighting
    - styling blog post in general
    - potentially add Disqus comments?
    - potentially add interactive feature to run code?
    - implement search
    - add `User` feature, allowing users to log in and save progress.
        - Probably should use Firestore for this: easy, built in Auth.
    - add mailing list form
    
- server
    - validate frontmatter
    - ~~support sub folders for table of contents~~
    - implement API for search

- deploy
    - deploy both client and server with either k8s/GCP or Heroku

    
