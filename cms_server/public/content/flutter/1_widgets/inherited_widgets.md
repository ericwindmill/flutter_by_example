---
title: "Inherited Widgets"
author: "Eric"
category: "Flutter"
subSection: "Widgets"
tags:
    - flutter
    - inherited widget
    - state management
---

If you've used Flutter before, you've probably come across the 'of' method on different classes here and there:

```dart
Theme.of(context).textTheme
MediaQuery.of(context).size
```

Those widgets (Theme, MediaQuery) are Inherited widgets. Pretty much anywhere in your app, you can access your theme,
 because they're inherited.
 
In Flutter, every part of the sdk is exposed to the developer, so you can take advantage of the inherited widget 
yourself. You can use a custom InheritedWidget as a built-in central state storage, similar to a Redux Store or Vue's 
Vuex Store.

After you've set up a store like this, you'll be able to do something like this: 

```dart
class RedText extends StatelessWidget {
  // ...
  Widget build(BuildContext context) {
    var state = StateContainer.of(context).state;
    return new Text(
      state.user.username,
      style: const TextStyle(color: Colors.red),
    );
  // ...
```

### Lifting State Up

When using an InheritedWidget as your state management tool, you're likely relying on an architecture pattern called 
'Lifting State Up'. 

Consider the starter Flutter app when you start a new project (the counter app). If you wanted to
 separate that app into two pages, one that displayed the counter, and one that allowed you to change the number. 
 Suddenly, this incredibly simple app is confusing. Each time you change routes, you have to be passing this piece of
  state (the counter) back and forth.
  
The InheritedWidget solves this problem by giving an entire widget tree access to the same pieces of state. 

 <img src="http://res.cloudinary.com/ericwindmill/image/upload/v1518974500/flutter_by_example/medium_tree.png" />

For a super awesome detailed explanation of different Flutter architecture concepts, [watch Brain Egan's talk from 
DartConf 2018](https://www.youtube.com/watch?v=zKXz3pUkw9A&t=1467s). Just don't watch too much, or you'll be 
convinced to use [flutter_redux](https://pub.dartlang.org/packages/flutter_redux), and you won't care about this article anymore. 🙃

The advantage to lifting state up rather than reaching for something like Redux, is that using an Inherited Widget is
 pretty simple to set up and use. 
 
**NB:** To be sure, I am a fan of Redux and Vuex and all the 'ux' things. This is just another tool in your toolbox 
for when Redux is more than you need. 

### Why Bother?

At this point, you might be asking why you should bother with an InheritedWidget. Why not just stick with a stateful 
widget at the apps root? 

Well really, that's what you are doing here. The inherited widget works in conjunction with a stateful widget and 
allows you to pass that StatefulWidgets state to *all* of its ancestors. Its a convenience widget. So you don't have 
to type the code in every class to pass state down to its children.

##Pt: 1 Set up a boiler plate app

For this example, let's just make this simple app:

<img src="http://res.cloudinary.com/ericwindmill/image/upload/v1523742041/blog_posts/inherited_test.gif" />

Basically this app's state is lifted up above the root Widget, and when you submit the form, it calls `setState` on 
that inherited widgets state, which tells the main page that there's new information to render.

### 1. The Material App Root

This is just your standard Flutter app set up:

```dart
void main() {
  runApp(new UserApp());
}

class UserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new HomeScreen(),
    );
  }
}
```

### 2. HomeScreen Widget

This is also very basic, for now. This is just boiler plate you need to follow along when the good stuff comes.

```dart
class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  
  Widget get _logInPrompt {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(
            'Please add user information',
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
  
  // All this method does is bring up the form page.
  void _updateUser(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return new UpdateUserScreen();
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Inherited Widget Test'),
      ),
      body: _logInPrompt,
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _updateUser(context),
        child: new Icon(Icons.edit),
      ),
    );
  }
}
```

### 3. The UpdateUserScreen Widget

Finally, a form page that does nothing, for now.


```dart
class UpdateUserScreen extends StatelessWidget {
  static final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> firstNameKey =
  new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> lastNameKey =
  new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> emailKey =
  new GlobalKey<FormFieldState<String>>();

  const UpdateUserScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Edit User Info'),
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          autovalidate: false,
          child: new ListView(
            children: [
              new TextFormField(
                key: firstNameKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'First Name',
                ),
              ),
              new TextFormField(
                key: lastNameKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'Last Name',
                ),
              ),
              new TextFormField(
                key: emailKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'Email Address',
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          final form = formKey.currentState;
          if (form.validate()) {
            var firstName = firstNameKey.currentState.value;
            var lastName = lastNameKey.currentState.value;
            var email = emailKey.currentState.value;

            // Later, do some stuff here

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
```
[Here's a GitHub Gist of the boiler plate.](https://gist.github.com/ericwindmill/32e73cc1fbf65114b5aa875500395f5a)

##Pt 2: Add in Inherited Widget Functionality



### 1. StateContainer and InheritedStateContainer Widgets

Make a new file called `state_container.dart`. This is where all things happen.

First, in that file, create a simple class called `User`. In a real app, this could be a bigger class called 
`AppState`, where you'd hold all the properties you want to access across your app.

```dart
class User {
  String firstName;
  String lastName;
  String email;

  User(this.firstName, this.lastName, this.email);
}
```

The InheritedWidget works as store by connecting to an StatefulWidget. So your StateContainer is really three classes:

```dart
class StateContainer extends StatefulWidget
class StateContainerState extends State<StateContainer>
class _InheritedStateContainer extends InheritedWidget
```

The `InheritedWidget` and the `StateContainer` are the simplest to set up, and once they're set up they don't change.
 The logic mainly lives in `StateContainerState`. Set up the first two:
 
 ```dart
 class _InheritedStateContainer extends InheritedWidget {
    // Data is your entire state. In our case just 'User' 
   final StateContainerState data;
    
   // You must pass through a child and your state.
   _InheritedStateContainer({
     Key key,
     @required this.data,
     @required Widget child,
   }) : super(key: key, child: child);
 
   // This is a built in method which you can use to check if
   // any state has changed. If not, no reason to rebuild all the widgets
   // that rely on your state.
   @override
   bool updateShouldNotify(_InheritedStateContainer old) => true;
 }
 
 class StateContainer extends StatefulWidget {
    // You must pass through a child. 
   final Widget child;
   final User user;
 
   StateContainer({
     @required this.child,
     this.user,
   });
 
   // This is the secret sauce. Write your own 'of' method that will behave
   // Exactly like MediaQuery.of and Theme.of
   // It basically says 'get the data from the widget of this type.
   static StateContainerState of(BuildContext context) {
     return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
             as _InheritedStateContainer).data;
   }
   
   @override
   StateContainerState createState() => new StateContainerState();
 }
 ```
That 'of' method should really never do anything else. In fact those two classes can just be left alone forever.


### 2. StateContainerState Widget

This Widget is where all your state and logic *can* live. For this app, you'll simply be able to store and manipulate
 your user.
 
```dart
class StateContainerState extends State<StateContainer> {
  // Whichever properties you wanna pass around your app as state
  User user;

  // You can (and probably will) have methods on your StateContainer
  // These methods are then used through our your app to 
  // change state.
  // Using setState() here tells Flutter to repaint all the 
  // Widgets in the app that rely on the state you've changed.
  void updateUserInfo({firstName, lastName, email}) {
    if (user == null) {
      user = new User(firstName, lastName, email);
      setState(() {
        user = user;
      });
    } else {
      setState(() {
        user.firstName = firstName ?? user.firstName;
        user.lastName = lastName ?? user.lastName;
        user.email = email ?? user.email;
      });
    }
  }

  // Simple build method that just passes this state through
  // your InheritedWidget
  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}
``` 

If you've used Redux in the past, you can see how much less boiler plate is involved here. Theres far less opinions, 
which of course comes with potential for bugs, but for a simple app, this is fantastic. This is literally *all* the 
work it takes to set up your Store. Then you just add properties and methods to that class as you need them.

### 3. Refactor Home and Form screens

First, wrap your app in the StateContainer:

```dart
void main() {
  runApp(new StateContainer(child: new UserApp()));
}
```

That's it: now you can access your store all over the app. So do that:

```dart
// main.dart
// ... 
class HomeScreenState extends State<HomeScreen> {
  // Make a class property for the data you want
  User user;

  // This Widget will display the users info:
  Widget get _userInfo {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // This refers to the user in your store
          new Text("${user.firstName} ${user.lastName}",
              style: new TextStyle(fontSize: 24.0)),
          new Text(user.email, style: new TextStyle(fontSize: 24.0)),
        ],
      ),
    );
  }

  Widget get _logInPrompt {
    // ...
  }

  void _updateUser(BuildContext context) {
    // ...
  }

  @override
  Widget build(BuildContext context) {
    // This is how you access your store. This container
    // is where your properties and methods live
    final container = StateContainer.of(context);
    
    // set the class's user
    user = container.user;
    
    var body = user != null ? _userInfo : _logInPrompt;
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Inherited Widget Test'),
      ),
      // The body will rerender to show user info
      // as its updated
      body: body,
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _updateUser(context),
        child: new Icon(Icons.edit),
      ),
    );
  }
}
```

Pretty simple changes there. And the form page isn't much different:

```dart
// form_page.dart
// ...
class UpdateUserScreen extends StatelessWidget {
  // ...

  @override
  Widget build(BuildContext context) {
    // get reference to your store
    final container = StateContainer.of(context);
    
    return new Scaffold(
      // the form is the same until here:
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          final form = formKey.currentState;
          if (form.validate()) {
            var firstName = firstNameKey.currentState.value;
            var lastName = lastNameKey.currentState.value;
            var email = emailKey.currentState.value;

            // This is a hack that isn't important
            // To this lesson. Basically, it prevents 
            // The store from overriding user info
            // with an empty string if you only want
            // to change a single attribute
            if (firstName == '') {
              firstName = null;
            }
            if (lastName == '') {
              lastName = null;
            }
            if (email == '') {
              email = null;
            }

            // You can call the method from your store,
            // which will call set state and rerender
            // the widgets that rely on the user slice of state.
            // In this case, thats the home page
            container.updateUserInfo(
              firstName: firstName,
              lastName: lastName,
              email: email,
            );
            
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

```


That's it! The InheritedWidget is easy, and an extremely viable option for simple apps, prototypes, etc.

[Here are the completed files on GitHub Gist](https://gist.github.com/ericwindmill/f790bd2456e6489b1ab97eba246fd4c6)
