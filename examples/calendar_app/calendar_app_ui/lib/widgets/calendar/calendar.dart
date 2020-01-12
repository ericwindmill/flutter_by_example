import 'package:calandar_app_ui/widgets/calendar/calendar_tile.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  final Function onDateSelected;
  final DateTime selectedDate;
  final List<DateTime> weeklyDates;

  const Calendar({
    Key key,
    @required this.onDateSelected,
    this.selectedDate,
    @required this.weeklyDates,
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 7,
      childAspectRatio: .8,
      children: <Widget>[
        for (var date in widget.weeklyDates)
          CalendarTile(
            isSelected: widget.selectedDate == date ?? false,
            date: date,
            onDateSelected: widget.onDateSelected,
          ),
      ],
    );
  }
}
