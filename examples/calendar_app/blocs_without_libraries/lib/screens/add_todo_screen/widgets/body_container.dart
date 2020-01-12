import 'package:blocs_without_libraries/app/bloc_provider.dart';
import 'package:calendar_app_repository/calendar_app_repository.dart';
import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).editTodoBloc;
    return StreamBuilder<Task>(
        stream: bloc.todo,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          onChanged: (String v) {
                            bloc.updateTodoDescription(v);
                          },
                          decoration: InputDecoration(
                            hintText: 'clean the kitchen',
                            labelText: 'Task description',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Due By Date',
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      Row(
                        children: <Widget>[
                          Text(snapshot?.data?.dueDate?.toString() ?? 'None'),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 20,
                            ),
                            onPressed: () async {
                              DateTime date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                              );
                              bloc.updateDueByDate(date);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Repeats",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    Switch(
                      value: snapshot.data.isRepeating,
                      onChanged: (bool val) => bloc.toggleIsRepeating(val),
                    ),
                  ],
                ),
                if (snapshot.data.isRepeating)
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: DayOfWeek.values.length,
                      itemBuilder: (BuildContext context, int index) {
                        var currentDay = DayOfWeek.values[index];
                        return Row(
                          children: <Widget>[
                            Checkbox(
                              value: snapshot.data.repeatingDays.contains(currentDay),
                              onChanged: (bool v) {
                                bloc.toggleRepetitionDay(currentDay, v);
                              },
                            ),
                            Text("Every ${DayOfWeek.values[index].humanize}"),
                          ],
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        });
  }
}

extension on DayOfWeek {
  String get humanize {
    return this.toString().split('.').last;
  }
}
