# Flutter (and Dart) by Example mono repo.

development:

1. First, make sure Dart2 and Aqueduct are installed on your machine

    [Dart 2](https://dart.dev/get-dart)

    [Aqueduct](https://aqueduct.io/docs/getting_started/)

2. Next, navigate to th file at `./flutter_by_example_monorepo/clients/web/lib/src/app/repositories/posts_respository_filesystem.dart`. Here, you'll need to comment out the `BASE_URL` variable that points to heroku and uncomment the variable that points to localhost. YES, it is janky SO WHAT

3. Finally, run the commands below

```text
cd common
pub get

cd ../cms_server
pub get
dart --observe bin/dev.dart

cd ../clients/web
pub get
webdev serve
```

Server is running at localhost:3000
Site is running at localhost:8080

**NB:** be sure to revert the `BASE_URL` variable to the heroku URL before committing to master!!!