---
title: "About Flutter"
author: "Eric"
category: "Flutter"
subSection: "Getting started with Flutter"
tags:
    - flutter
    - intro
---

> This article was originally published [on CSS Tricks](https://css-tricks.com/flutter-googles-take-on-cross-platform/). 
> Updated on 12/2/2019

<a href="https://flutter.dev/">Flutter</a> is a mobile <abbr title="Software Development Kit">SDK</abbr> that, at its core, is about empowering everyone to build beautiful mobile apps. Whether you come from the world of web development or native mobile development, Flutter makes it easier to create mobile apps in a familiar, simplified way, without ever giving up control to the framework.

As of this writing, Google AdWords, Alibaba, and BMW (to name a few) are using Flutter in production. <a href="https://flutter.io/showcase">You can see more examples of who's using Flutter</a> (including the app I've worked on) on Flutter's website on the showcase page.

Right now, there's a lot of buzz about Flutter. The question I see most often is, <em>"Flutter or React Native...which one should I use?"</em> Like all things in programming, its all about the tradeoffs you're willing to make.

I'm going to try to convince you that Flutter is the best option for mobile app development. I believe it's better than any other cross platform framework, and it's possibly better than native development — but more on that in a bit.

Before that though, let me walk (quickly) through what Flutter is, and what it is not, starting with the Dart programming language.

<h3>What's Dart?</h3>

Dart is a programming language created by Google and was used to write Flutter. Dart was created, more or less, because Google wanted a language that was "better" than JavaScript to write server side and front-end code. From what I understand, the main issue they had with JavaScript is how slowly it updates with new features since it relies on a huge committee for approvals and several browser vendors to implement it.

After a series of decisions about whether to take on JavaScript directly or not, Google decided to make a language that semantically fit inside of JavaScript. In other words, every single thing you write in Dart can compile to JavaScript. This is why they didn't just use Java — it's semantically huge.

> <a href="https://gist.github.com/paulmillr/1208618"> Here's a leaked email chain from Google from 2010. </a> It's the "coming to Jesus" moment that they decided they needed to do something about JavaScript.

The fundamentals of Dart are similar to all high-level languages. That said, programming languages are, as it turns out, hard to learn.

There's good news, though. Dart excels at being a "safe" language to learn. Google didn't set out to create anything innovative with Dart. They were seeking to make a language that was simple, productive and could be compiled into JavaScript.

There is nothing particularly exciting about its syntax, and no special operators that will throw you through a loop. In Dart (unlike JavaScript), there is one way to say true: True. There is one way to say false: False.

In JavaScript, this coerces to True:

```javascript
if (3) { ... }
```

In Dart, that would blow up your program. Dart is, at its core, a productive, predictable, and simple language.

This is important, because writing an app in Flutter is simply writing Dart. Flutter is, underneath it all, a library of Dart classes. There is no markup language involved or JSX-style hybrid language. Every bit of front-end code is written in Dart. No HTML. No CSS.

<h3>Why does Flutter use Dart?</h3>

If you're coming from literally any other background (and you're like me), you've probably complained about the fact that Flutter uses Dart, and not JavaScript. (Developers are, believe it or not, opinionated.)

And there are reasons to be skeptical of this choice. It's not one of the hot languages of today. It's not even one of the top 25 most used languages. What gives? Is Google just using it because it's their language? I'd imagine that played a role, but there are practical reasons, too.

* Dart supports both Just In Time (JIT) compiling and Ahead of Time (AOT) compiling.
  * The AOT compiler changes Dart into efficient native code. This makes Flutter fast (a win for the user and the developer), but it also means that almost all of the framework is written in Dart. For you, the developer, that means you customize everything.
  * Dart's optional JIT compiling allows hot-reloading to exist. Fast development and iteration is a key to the joy of using Flutter. When you save code in your text editor, your app is updated in your simulator in less than a second.
* Dart is Object Oriented. This makes it easy to write visual user-experiences exclusively with Dart, with no need for a markup language.
* Dart is a productive and predictable language. It's easy to learn and it feels familiar. Whether you come from a dynamic language or a static language, you can get up and running with ease.
* And yes, I'd image that it is extremely appealing to use a language made by the same company, because the Flutter team could work closely with the Dart team to implement new needed features.

<h3>Flutter vs. React Native (and other options)</h3>

Before I offer up my unsolicited opinions on your other options, I want to make this crystal clear: Flutter is not the answer 100% of the time. It's a tool and we should choose the right tool for the job at hand. That said, I'd only argue that it's something you should strongly consider in the future.

<h4>Native development (iOS and Android)</h4>

Your first choice is to write native apps for iOS and Android. This gives you maximum control, debugging tools, and (potentially) a very performant app. At a company, this likely means you have to write everything twice; once for each platform. You likely need different developers on different teams with different skillsets that can't easily help each other.

<h4>React Native, WebViews, and other cross-platform JavaScript options</h4>

Your second option: cross-platform, JavaScript-based tools such as WebViews and React Native. These aren't bad options. The problems you experience with native development disappear. Every front-end web developer on your team can chip in and help — all they need are some modern JavaScript skills. This is precisely why large companies such as AirBnb, Facebook, and Twitter have used React Native on core products. (AirBnb recently <a href="https://medium.com/airbnb-engineering/sunsetting-react-native-1868ba28e30a">announced</a> that it would stop using React Native, because of some of the issues I'll describe below.)

The first "mobile apps" to be built cross platform are simply WebViews that run on WebKit (a browser rendering engine). These are literally just embedded web pages. The problem with this is basically that manipulating the DOM is very expensive and doesn't perform well enough to make a great mobile experience.

Some platforms have solved this problem by building the "JavaScript bridge." This bridge lets JavaScript talk directly to native widgets.

This is much more performant than WebViews, because you eliminate the DOM from the equation, but it's still not ideal. Every time your app needs to talk directly to the rendering engine, it has to be compiled to native code to "cross the bridge." On a single interaction, the bridge must be crossed <em>twice</em>: once from platform to app, and then back from app to platform.

<figure id="post-275728" class="align-left media-275728"><img src="https://css-tricks.com/wp-content/uploads/2018/08/flutter-01.png" alt="" /></figure>

Flutter differs because it uses its own rendering engine, <a href="https://skia.org/">Skia</a>, which is the same rendering engine used in Chrome. Skia can communicate with Flutter apps. As a result, Flutter accepts local events <em>directly</em>, rather than having to first compile them into JavaScript. This is essentially possible because <em>Flutter compiles to native ARM code.</em> This is the secret to its success. When your app is fired up on a user's device, it's entirely running in the language that the device's operating system expects.

<figure id="post-275729" class="align-left media-275729"><img src="https://css-tricks.com/wp-content/uploads/2018/08/flutter-02.png" alt="" /></figure>

The JavaScript bridge is a marvel of modern programming, to be sure, but it presents three big problems.

The first problem is that debugging is hard. When there's an error in the runtime compiler, that error has to be traced back across the JavaScript bridge and found in the JavaScript code. It may be in markup or CSS-like syntax as well. The debugger itself may not work as well as we'd like it to.

A second bigger issue, though, is performance. The JavaScript bridge is very expensive. Every time something in the app is tapped, that event must be sent across the bridge to your JavaScript app. The result, for lack of better term, is <em>jank</em>.

The third big problem, <a href="https://medium.com/airbnb-engineering/sunsetting-react-native-1868ba28e30a">according to AirBnb,</a> is that they found themselves having to dip down into the native code more often than they wanted to, which was a problem for their teams comprised mostly of JavaScript developers. (The jury is still out on this issue with Flutter, but I can say that I've never once had to try and write native code at my job. Some members of my team have created plugins in Objective-C and Java.)

<h3>The immediate benefits of Flutter</h3>

It's likely, since you're reading this article, that you're interested in Flutter... but you might be skeptical. I admire how thorough you are in vetting technology.

Your reasons for being skeptical are fair. It's a new technology. That means breaking changes in the API. It means missing support for important features (such as Google Maps). It seems possible that Google could abandon it altogether one day.

And, despite the fact that you believe Dart is great language, that doesn't change the fact that Dart isn't widely used, and many third-party libraries that you want may not exist.

I would argue against all those points, though. The API unlikely to change, as the Google uses Flutter internally on major revenue-generating apps, including Google AdWords. Dart has recently moved into version 2, which means it will likely be a while until it changes much. It will likely be years until breaking changes are introduced which, in a computer world, is practically forever.

Yes, there are indeed missing features, but Flutter gives you the complete control to add your own native plugins. In fact, many of the most important operating system plugins already exist, such as a map plugin, camera, location services, and device storage. The Dart and Flutter ecosystem and community already exists. It's much smaller than the JavaScript community, of course, but I would argue that it's concise. I see people every day contributing to existing packages, rather than creating new ones.

Now, let's talk about Flutter's specific benefits.

<h4>No JavaScript bridge</h4>

This is a major bottleneck in development and in your application's performance. Again, it leads to <em>jank</em>. Scrolling isn't smooth, it's not always performant, and it's hard to debug.

Flutter compiles to actual native code and is rendered using Skia. The app itself is running in native, so there's no reason to convert Dart to native. This means that it doesn't lose any of the performance or productivity when it's running on a user's device.

<h4>Compile time</h4>

If you're coming from native development, one of your major pains is the development cycle. iOS is infamous for its insane compile times. In Flutter, a full compile generally takes less than 30 seconds, and incremental compiles are sub-seconds, thanks to hot-reload. At my day job, we develop features for our mobile client first because Flutter's development cycle allows us to move so quickly. Only when we're sure of our implementation do we go write those features in the web client.

<h4>Write once, test once, deploy everywhere</h4>

Not only do you get to write your app one time and deploy to iOS and Android, you also only have to write your tests once. Dart unit testing is quite easy, and Flutter includes a library for testing Widgets.

<h4>Code sharing</h4>

I'm going to be fair here: I suppose this is technically possible in JavaScript as well. But, it's certainly not possible in native development. With Flutter and Dart, your web and mobile apps can share all the code, except each client's views. (Of course, only if you're using Dart for your web apps.) You can quite easily use dependency injection to run an <a href="https://webdev.dartlang.org/angular">AngularDart</a> app and Flutter app with the same models and controllers.

And of course, even if you don't want to share code between your web app and your mobile app, you're sharing all your code between the iOS and Android apps.

In practical terms, this means that you are super productive. I mentioned that we develop our mobile features first at my day job. Because we share business logic between web and mobile, once the mobile feature is implemented, we only have to write views that expect that same controller data.

<h4>Productivity and collaboration</h4>

Gone are the days of separate teams for iOS and Android. In fact, whether your use Dart or JavaScript in your web apps, Flutter development is familiar enough that all your teams will be unified. It's not a stretch by any means to expect a JavaScript web developer to also effectively develop in Flutter and Dart. If you believe me here, then it follows that your new unified team will be three times more productive.

<h4>Code maintenance</h4>

Nothing is more satisfying then fixing a bug once and having it corrected on all your clients. Only in very specific cases is there a bug in a iOS app produced with Flutter that is not also in the Android version (and vice versa). In 100% of these cases, these bugs aren't bugs, but cosmetic issues because Flutter follows the device OS design systems in it's built-in widgets. Because these are issues like text sizing or alignment, they are trivial in the context of using engineering time to fix.

<h3>Flutter for JavaScript developers</h3>

Since you're reading CSS-Tricks, I'd be willing to bet you're a web developer. If you've used any of today's hottest frameworks (e.g. React, Angular, Vue, etc.), then you'll be happy to know that picking up Flutter is <em>easy</em>.

Flutter is completely reactive, so the same mindset and paradigm that you're used to with React carries over to Flutter. You're essentially building a ton of small, reusable components (called Widgets in Flutter) just like React. These widgets are complete with lifecycle methods, and they're written in classes. If you've used this syntax in React:

```javascript
const MyComponent extends React.Component {
  //...
  render(){}
}
```

...then you'll pick up Flutter with no problem. This is how you do the same in Flutter:

```dart
class MyWidget extends StatelessWidget {
  //...
  build(){}
}
```

And, just like React, Flutter favors composition over inheritance. For example, if you want to make a special <code>AddToCartButton</code> in React, you'd build a button with special functions and styles in JSX. That's exactly how you do it in Flutter (minus the JSX).

Finally, the layout system in Flutter is similar to CSS rules we're familiar with, like flexbox and absolute positioning.

This is also where a big difference in making views in Flutter comes in, though. In Flutter, literally <em>everything</em> is a Widget. There are some obvious, concrete Widgets, like <code>Text</code>, <code>Button</code>, and <code>AppBar</code>. But Animations and Layout declarations are also Widgets. To center text, you wrap a <code>Text</code> Widget in a <code>Center</code> Widget. To add padding, there's a <code>Padding</code> Widget.

Imagine breaking down a React app to the smallest possible reusable components you could make. For example, what if you made a higher-order React component that simply took a prop "padding" and all it did was add that amount of padding to whatever was nested within it. That's how Flutter works, because there is no CSS or markup.

In this sample picture, here are <em>a few</em> layout widgets that you might use, but you can't ‘see' as the user:

<figure id="post-275730" class="align-left media-275730"><img src="https://css-tricks.com/wp-content/uploads/2018/08/flutter-03.jpg" alt="" /></figure>

That may seem like a ton of monotonous work, but Flutter comes with many, many Widgets built right in (such as <code>Padding</code> and <code>Center</code>) so you don't have to waste time doing that yourself.

These are some of the most common widgets:

<ul>
  <li><a href="https://flutter.io/widgets/layout/)">Layout</a> -  <code>Row</code>, <code>Column</code>, <code>Scaffold</code>, <code>Stack</code></li>
  <li><a href="https://flutter.io/widgets/material/#App%20structure%20and%20navigation">Structures</a> - <code>Button</code>, <code>Toast</code>, <code>MenuDrawer</code></li>
  <li><a href="https://flutter.io/widgets/text/">Text</a> - <code>TextStyle</code>, <code>Color</code></li>
  <li><a href="https://flutter.io/widgets/animation/">Animations</a> - <code>FadeInPhoto</code>, transformations</li>
  <li><a href="https://flutter.io/widgets/styling/">Styling</a> - <code>Center</code>, <code>Padding</code></li>
</ul>

<h3>Final note</h3>

TL;DR: should you try Flutter?

If you want to make buttery smooth mobile apps in a familiar style, then yes! The performance and developer experience are both completely held in tact in Flutter. Its animations tick at 60fps, and it has a bundle of built-in Cupertino-style and Material Design-style Widgets. Or, long story short: it's <em>incredible</em> how quick you can be productive in Flutter, without sacrificing native performance.