import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthItem extends StatefulWidget {
  const MonthItem({
    Key key,
    this.isCurrDay = false,
    this.txt,
    this.isCurrMonth = false,
    this.date,
    this.numActivities = 0,
    this.onClick,
    this.stream,
  }) : super(key: key);
  final int txt;
  final bool isCurrMonth;
  final bool isCurrDay;
  final DateTime date;
  final int numActivities;
  final VoidCallback onClick;
  final Stream stream;

  @override
  _MonthItemState createState() => _MonthItemState();
}

class _MonthItemState extends State<MonthItem> {
  DateTime selDate;
  // ignore: cancel_subscriptions
  StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();

    streamSubscription = widget.stream.listen((date) {
      _changeDate(date);
    });
  }

  void _changeDate(newDate) {
    setState(() {
      selDate = newDate;
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  int _weekNum() {
    int dayOfYear = int.parse(DateFormat("D").format(widget.date));
    return ((dayOfYear - widget.date.weekday + 10) / 7).floor();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Card(
        elevation: 0.2,
        margin: EdgeInsets.all(1),
        color: selDate == widget.date
            ? Colors.grey[350]
            : widget.isCurrDay
                ? Colors.grey[200]
                : Colors.white,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  widget.txt.toString(),
                  style: TextStyle(
                      color: widget.isCurrMonth
                          ? Colors.grey[700]
                          : Colors.grey[400]),
                ),
              ),
              widget.date.weekday == 1
                  ? Text(
                      'w.' + _weekNum().toString(),
                      style: TextStyle(color: Colors.green[800]),
                    )
                  : Container(),
              widget.numActivities != 0
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                        child: Text(
                          '${widget.numActivities}',
                        ),
                      ),
                    )
                  : Container(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
