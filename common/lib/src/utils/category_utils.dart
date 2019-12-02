/// These are used for display purposes
/// This should probably be removed as it's somewhat repeating
/// work that the [sortPosts] method is doing
class CategoryOrder {
  static const int Dart = 1;
  // examples below, no content exists yet and these can change
  static const int Flutter = 2;
  static const int AdvancedTopics = 3;
  static const int ExampleApp = 4;
  static const int ETC = 5;

  static final Map<String, int> postOrder = {
    "Dart": CategoryOrder.Dart,
    "Flutter": CategoryOrder.Flutter,
    "AdvancedTopics": CategoryOrder.AdvancedTopics,
    "ExampleApp": CategoryOrder.ExampleApp,
    "etc": CategoryOrder.ETC,
  };

  static int fromString(String s) {
    return postOrder[s];
  }
}

class SubCategoryOrder {
  // Dart Section constants
  static const int Dart_AboutDart = 1;
  static const int Dart_IntroToDart = 2;
  static const int Dart_DataTypes = 3;
  static const int Dart_Functions = 4;
  static const int Dart_OOP = 5;

  // Flutter section constants
  static const int Flutter_Layout = 1;

  static final Map<String, int> postOrder = {
    // DART
    "Getting Started with Dart": SubCategoryOrder.Dart_AboutDart,
    "Dart Fundamentals": SubCategoryOrder.Dart_IntroToDart,
    "Data Types": SubCategoryOrder.Dart_DataTypes,
    "Functions": SubCategoryOrder.Dart_Functions,
    "Object Oriented Dart": SubCategoryOrder.Dart_OOP,

    // FLUTTER
    "Layout": SubCategoryOrder.Flutter_Layout,
  };

  static int fromString(String s) {
    return postOrder[s];
  }
}
