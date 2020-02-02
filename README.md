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

## Adding content

If you want to add a new tutorial to the app, you need to do two things:

1.  Create the **markdown** file and fill it with content.
    - The file *must* be in the `cms_server/public/content` directory. Within that directory, the location in the filesystem is inconsequential and just for us humans.
    - It must have valid frontmatter. I suggest copy and pasting the frontmatter from another file. Or from here:

    ```yaml       
    ---
    title: "Built-in Animation: Hero transition" 
    author: "Eric"
    category: "Flutter UI Example Apps" 
    subSection: "Basic App"
    tags:
        - AnimatedCrossFade
        - Hero
    ---
    ```

2.  Add it the file to the table of contents.
    - The table of contents lives at `common/lib/src/table_of_contents.dart`  (or at the link below)
        - [https://github.com/ericwindmill/flutter_by_example/blob/master/common/lib/src/table_of_contents.dart](https://github.com/ericwindmill/flutter_by_example/blob/master/common/lib/src/table_of_contents.dart)
    - The names / categories / subcategories titles must match the front matter *exactly.* I'm still pondering the contents structure, so feel free to take liberties with creating new categories, etc.
- If you're writing an article, please keep the following sudo-style-guide bullets in mind:
    - Every tutorial page on the site should be useful *on its own*. Especially the lessons that are one off examples and not tied to a larger, complete app.
    - Conversational, natural voice! I don't care if you use the word 'fuck' on Flutter by Example, as long as it's *authentic*. Writing like a human talks, which is unlike a robot talks, is super important.
    - Using DartPad's 'test' feature is encouraged.
        - The link below is to a cool guide all about using DartPad in tutorials.
        - [Dartpad](https://dart.dev/resources/dartpad-tutorials.pdf)
