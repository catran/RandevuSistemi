import 'dart:async';

import 'package:chat_application/screens/set_activity.dart';
import 'package:chat_application/services/database_service.dart';
import 'package:chat_application/shared/activities.dart';
import 'package:chat_application/shared/month_item.dart';
import 'package:chat_application/shared/weekday_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthScreen extends StatefulWidget {
  MonthScreen({Key key}) : super(key: key);

  @override
  _MonthScreenState createState() => _MonthScreenState();
}

class _MonthScreenState extends State<MonthScreen> {
  DatabaseService _databaseService = DatabaseService();
  DateTime _now = DateTime.now();
  int _monthNum = 0;
  int _yearNum = 0;
  List<Widget> lastMonthItems = [];
  List<Widget> monthItems = [];
  List<Widget> nextMonthItems = [];
  List<Activities> todaysActivities = [];
  List<Map<int, Activities>> allMonthlyActivities = [];
  DateTime _selDate = DateTime.now();

  StreamController<DateTime> _controller =
      StreamController<DateTime>.broadcast();

  int _insertYear = 0;
  int _insertMonth = 0;
  int _insertDay = 0;

  String _selTitle = '';
  String _selInfo = '';

  void initState() {
    _databaseService.initializeDatabase();
    _monthNum = int.parse(DateFormat('M').format(_now));
    _yearNum = int.parse(DateFormat('y').format(_now));
    _insertDay = int.parse(DateFormat('d').format(_now));
    _insertMonth = _monthNum;
    _insertYear = _yearNum;
    getMonthDates(_monthNum, _yearNum);
    super.initState();
  }

  Future insertActivities(int month, int year) async {
    var data = await _databaseService.getMonthlyActivities(
        year.toString(), month.toString());
    allMonthlyActivities = [];

    for (var element in data) {
      bool isAllDay = false;
      var startDate = DateTime.parse(element.startTime);
      var endDate = DateTime.parse(element.endTime);
      String title = element.title;
      String info = element.title;

      if (startDate.hour == 0 &&
          startDate.minute == 0 &&
          endDate.hour == 23 &&
          endDate.minute == 59) {
        isAllDay = true;
      }

      allMonthlyActivities.add({
        element.day: Activities(
          title: title,
          info: info,
          startDate: startDate,
          endDate: endDate,
          onClick: () {
            showDialog(
                context: context,
                builder: (_) => SetActivity(
                      title: title,
                      info: info,
                      startTime: startDate,
                      endTime: endDate,
                      isAllDay: isAllDay,
                      update: true,
                      id: element.id,
                    )).whenComplete(() => getMonthDates(month, year));
          },
          onDeleteClick: () {
            print(element.id);
            print(title);
            _databaseService
                .delete(element.id)
                .whenComplete(() => getMonthDates(month, year));
          },
        )
      });

      var num = await _databaseService.getNum(
          year.toString(), month.toString(), element.day.toString());

      int day = element.day;
      if (DateTime(_yearNum, _monthNum, day) ==
          DateTime(_now.year, _now.month, _now.day)) {
        monthItems[day - 1] = MonthItem(
          txt: day,
          date: DateTime(year, month, day - 1),
          isCurrMonth: true,
          isCurrDay: true,
          numActivities: num,
          onClick: () {
            setState(() {
              _insertYear = year;
              _insertMonth = month;
              _insertDay = day;

              _selDate = DateTime(year, month, day);
              _controller.add(DateTime(year, month, day));
            });
          },
          stream: _controller.stream,
        );
      } else {
        monthItems[day - 1] = MonthItem(
          txt: day,
          date: DateTime(year, month, day),
          isCurrMonth: true,
          numActivities: num,
          onClick: () {
            setState(() {
              _insertYear = year;
              _insertMonth = month;
              _insertDay = day;

              _selDate = DateTime(year, month, day);
              _controller.add(DateTime(year, month, day));
            });
          },
          stream: _controller.stream,
        );
      }
    }
    return;
  }

  void getMonthDates(int month, int selYear) {
    lastMonthItems = [];
    monthItems = [];
    nextMonthItems = [];
    int start = 0;
    int daysInLastMonth = DateTime(selYear, month, 0).day;
    int daysInMonth = DateTime(selYear, month + 1, 0).day;

    String firstDayWeekday =
        DateFormat('E').format(DateTime(selYear, month, 1));

    if (firstDayWeekday == 'Mon')
      start = 0;
    else if (firstDayWeekday == 'Tue')
      start = 1;
    else if (firstDayWeekday == 'Wed')
      start = 2;
    else if (firstDayWeekday == 'Thu')
      start = 3;
    else if (firstDayWeekday == 'Fri')
      start = 4;
    else if (firstDayWeekday == 'Sat')
      start = 5;
    else
      start = 6;

    daysInLastMonth -= (start - 1);
    for (int i = start; i > 0; i--) {
      lastMonthItems.add(MonthItem(
        txt: daysInLastMonth,
        date: DateTime(selYear, month - 1, daysInLastMonth),
        onClick: () {
          _insertYear = selYear;
          _insertMonth = month;
          _insertDay = i;
        },
        stream: _controller.stream,
      ));
      daysInLastMonth++;
    }
    for (int i = 1; i <= daysInMonth; i++) {
      if (DateTime(_yearNum, _monthNum, i) ==
          DateTime(_now.year, _now.month, _now.day)) {
        monthItems.add(
          MonthItem(
            isCurrDay: true,
            txt: i,
            isCurrMonth: true,
            date: DateTime(selYear, month, i),
            onClick: () {
              setState(() {
                _insertYear = selYear;
                _insertMonth = month;
                _insertDay = i;
                _selTitle = '';
                _selInfo = '';

                _selDate = DateTime(selYear, month, i);
                _controller.add(DateTime(selYear, month, i));
              });
            },
            stream: _controller.stream,
          ),
        );
      } else {
        monthItems.add(
          MonthItem(
            isCurrDay: false,
            txt: i,
            isCurrMonth: true,
            date: DateTime(selYear, month, i),
            onClick: () {
              setState(() {
                _insertYear = selYear;
                _insertMonth = month;
                _insertDay = i;
                _selTitle = '';
                _selInfo = '';

                _selDate = DateTime(selYear, month, i);
                _controller.add(DateTime(selYear, month, i));
              });
            },
            stream: _controller.stream,
          ),
        );
      }
    }
    for (int i = lastMonthItems.length + monthItems.length, n = 1;
        i < 35;
        i++, n++) {
      nextMonthItems.add(MonthItem(
        txt: n,
        date: DateTime(selYear, month + 1, n),
        onClick: () {
          _insertYear = selYear;
          _insertMonth = month;
          _insertDay = i;
        },
        stream: _controller.stream,
      ));
    }
    insertActivities(month, selYear).whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    todaysActivities = [];
    allMonthlyActivities.forEach((e) {
      if (e[_insertDay] != null) {
        todaysActivities.add(e[_insertDay]);
      }
    });
    todaysActivities
        .sort((a, b) => a.startDate.hour.compareTo(b.startDate.hour));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: maxWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            DateFormat('yMMMM')
                                .format(DateTime(_yearNum, _monthNum)),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        WeekdayItem(txt: 'M'),
                        WeekdayItem(txt: 'T'),
                        WeekdayItem(txt: 'W'),
                        WeekdayItem(txt: 'T'),
                        WeekdayItem(txt: 'F'),
                        WeekdayItem(txt: 'S'),
                        WeekdayItem(txt: 'S'),
                      ],
                    ),
                  ),
                  Container(
                    height: 400,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 7,
                      padding: EdgeInsets.zero,
                      childAspectRatio: 0.7,
                      children: lastMonthItems + monthItems + nextMonthItems,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Text(
                          DateFormat('EEE d MMMM').format(_selDate) + ':',
                          textScaleFactor: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: 250, maxWidth: maxWidth),
                          child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: todaysActivities),
                        ),
                      ),
                      Container(
                        width: maxWidth,
                        height: 50,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        if (_monthNum == 1) {
                          _yearNum--;
                          _monthNum = 12;
                        } else {
                          _monthNum--;
                        }
                        setState(() {
                          getMonthDates(_monthNum, _yearNum);
                        });
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 35,
                      )),
                  Container(
                    child: Text(
                      DateFormat('MMMM').format(DateTime(_yearNum, _monthNum)),
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (_monthNum == 12) {
                          _yearNum++;
                          _monthNum = 1;
                        } else {
                          _monthNum++;
                        }
                        setState(() {
                          getMonthDates(_monthNum, _yearNum);
                        });
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 35,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => SetActivity(
              title: _selTitle,
              info: _selInfo,
              startTime: DateTime(_insertYear, _insertMonth, _insertDay, 12),
              endTime: DateTime(_insertYear, _insertMonth, _insertDay, 13),
            ),
          ).whenComplete(() => getMonthDates(_monthNum, _yearNum));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
