---
title: "Install Dart on your machine"
author: "Eric Windmill"
category: "Dart"
subSection: "Getting Started with Dart"
order: 2
tags:
- dart
- setup
- Dart sdk
---


In order to run Dart on your machine, you'll need to install the Dart SDK.

> The following instructions install Dart 2. This book will be using Dart 2; Dart 1 will not work! If you already have the Dart SDK on your machine, ensure that it's version 2.0.0 or greater.

Installing the Dart SDK is straight forward if you use the command line. To check if you have Dart installed already, use the `which dart` command (on MacOS).

```shell script
$ which dart

# should print 
=> /usr/local/bin/dart
```

Otherwise, install the SDK using the instructions for your machines operating system.

### Mac OS

If you're using a Mac, it's likely that you have a program called Homebrew on your computer. If not, you need to install it. Homebrew is a command-line program that lets you download and manage software packages from the terminal.

We can install it easily from the command line. First, check to see if its installed:

```shell script
$ brew -v
```

If your terminal prints `Homebrew 1.x.x`, then you're good to go. Otherwise, you need to install Homebrew. You can find instructions for installing Homebrew via the command line at https://brew.sh.

Homebrew will walk you through the steps in your terminal.

Second, install Dart SDK. Thanks to Homebrew, this is incredibly easy.

```shell script
$ brew tap dart-lang/dart
$ brew install dart
```

Now, in your terminal, run this command to make sure everything is in its right place:

```shell script
$ dart -v

=> Dart VM version: 2.x.x...
```

### Windows

On Windows, the easiest way to install Dart is via the package manager, Chocolately. With Chocolatey on your machine, you simply have to run:

```shell script
C:\> choco install dart-sdk
```

### Linux

The easiest way to install on Ubuntu is with this series of steps. Using all these commands will ensure that Dart automatically updates whenever the newest version is released.

A one-time setup step:
```shell script
$ sudo apt-get update
$ sudo apt-get install apt-transport-https
$ sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
$ sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
```

Now, install the Dart SDK:
```shell script
$ sudo apt-get update
$ sudo apt-get install dart
```