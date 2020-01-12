class Week {
  List<DateTime> get dates {
    var today = DateTime.now();
    var weekBeginning = today.subtract(Duration(days: today.weekday));
    // Todo: this will be incorrect during year or month changes (i.e. it could show january 34th)
    var week = List.generate(7, (int index) {
      return DateTime(weekBeginning.year, weekBeginning.month, weekBeginning.day + index);
    });
    return week;
  }
}
