// would love to see this in a yaml config. But not today.
class PostOrder {
  static const int Dart = 1;
  static const int Flutter = 2;
  static const int AdvancedTopics = 3;
  static const int ExampleApp = 4;
  static const int ETC = 5;

  static final Map<String, int> postOrder = {
    "Dart": PostOrder.Dart,
    "Flutter": PostOrder.Flutter,
    "AdvancedTopics": PostOrder.AdvancedTopics,
    "ExampleApp": PostOrder.ExampleApp,
    "etc": PostOrder.ETC,
  };

  static int fromString(String s) {
    return postOrder[s];
  }
}

class SubCategoriesOrder {
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
    "Getting Started with Dart": SubCategoriesOrder.Dart_AboutDart,
    "Basic Dart Language Features": SubCategoriesOrder.Dart_IntroToDart,
    "Data Types": SubCategoriesOrder.Dart_DataTypes,
    "Functions": SubCategoriesOrder.Dart_Functions,
    "Object Oriented Dart": SubCategoriesOrder.Dart_OOP,

    // FLUTTER
    "Layout": SubCategoriesOrder.Flutter_Layout,
  };

  static int fromString(String s) {
    return postOrder[s];
  }
}
