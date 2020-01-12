import 'package:calandar_app_ui/calandar_app_ui.dart';
import 'package:flutter/material.dart';

class CalendarTile extends StatelessWidget {
  final Function onDateSelected;
  final bool isSelected;
  final DateTime date;

  const CalendarTile({Key key, this.onDateSelected, this.isSelected, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width / 7;
    return Column(
      children: <Widget>[
        Text(
          Humanize.dayOfWeekFromDateTime(date),
          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10.0),
        ),
        InkWell(
          onTap: () => onDateSelected(date),
          child: Center(
            child: Container(
              width: size,
              height: size,
              color: isSelected ? Colors.blue[100] : Colors.grey[100],
              child: Center(
                child: Text(date.day.toString()),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
