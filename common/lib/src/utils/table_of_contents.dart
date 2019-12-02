/// This [TABLE_OF_CONTENTS] determines the order of the posts.
/// A lot of code does tricky things in order to ensure that the easiest
/// way to change the order of the lessons is to change this map

/// Category : {
///   subCategory: [List of post names]
/// }
///
/// NB: Lists are ordered!
const Map<String, Map<String, List<String>>> TABLE_OF_CONTENTS = {
  "Dart": {
    "Getting Started with Dart": [
      "About Dart",
      "Install Dart on your machine",
      "Dartpad",
      "Text Editors: Intellij and VSCode",
      "Resources: Documentation and Pub.dev",
      "Hello World",
      "The main function",
      "Print to the console",
    ],
    "Dart Fundamentals": [
      "Values and variables",
      "Comments",
      "const and final variables",
      "Arithmetic and Comparison Operators",
      "Assignment Operators",
      "Logical Operators",
      "Null Aware Operators",
      "Type Test Operators",
      "Bitwise and Shift Operators",
      "Control Flow: if, else, else if",
      "Switch statements and case",
      "Ternary Conditional operator",
      "Loops: for and while",
      "Anatomy of Dart Functions",
      "'Arrow' functions",
      "Function arguments: default, optional, named",
      "Lexical Scope",
      "Cascade notation",
    ],
    "Data Types": [
      "Intro to Dart's Type System",
      "Numbers",
      "Strings",
      "Booleans",
      "dynamic",
      "lists",
      "sets",
      "maps",
    ],
  }
};
