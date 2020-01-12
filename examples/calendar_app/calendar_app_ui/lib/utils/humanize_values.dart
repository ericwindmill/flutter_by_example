class Humanize {
  static String dateTime(DateTime dateTime) {
    return '${dateTime.month}/${dateTime.day}/${dateTime.year}';
  }

  static String enumValue(String enumVal) {
    return enumVal.split('.').last;
  }

  static String dayOfWeekFromDateTime(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 0:
        return 'Sunday';
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
      default:
        return 'Saturday';
    }
  }

  static String listOfDays(List<String> days) {
    var stringList = days.fold("", (String prev, String ele) {
      return "$prev ${enumValue(ele)},";
    });

    return stringList.substring(0, stringList.length - 1);
  }
}
