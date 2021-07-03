import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Activities extends StatefulWidget {
  const Activities(
      {Key key,
      this.title,
      this.info,
      this.startDate,
      this.endDate,
      this.onClick,
      this.onDeleteClick})
      : super(key: key);

  final String title;
  final String info;
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback onClick;
  final VoidCallback onDeleteClick;

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities>
    with SingleTickerProviderStateMixin {
  AnimationController rotationController;
  double _start = 0;

  bool _isAnimating = false;
  bool _isAllDay = false;

  @override
  void initState() {
    super.initState();
    _isAnimating = false;
    rotationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));

    if (widget.startDate.hour == 0 &&
        widget.startDate.minute == 0 &&
        widget.endDate.hour == 23 &&
        widget.endDate.minute == 59) {
      _isAllDay = true;
    }
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  _stop() {
    rotationController.animateTo(0);
    _start = 0;
    setState(() {
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: _isAnimating
          ? () {
              setState(() {
                _stop();
              });
            }
          : widget.onClick,
      onLongPress: _isAnimating
          ? () {
              setState(() {
                _stop();
              });
            }
          : () {
              _start = -0.005;
              rotationController.repeat(reverse: true);
              setState(() {
                _isAnimating = true;
              });
            },
      child: Stack(
        children: [
          _isAnimating
              ? Positioned(
                  top: -10,
                  right: 10,
                  child: Container(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      onPressed: widget.onDeleteClick,
                      icon: Icon(
                        Icons.cancel,
                        size: 35,
                        color: Colors.red,
                      ),
                    ),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: RotationTransition(
              turns:
                  Tween(begin: _start, end: 0.005).animate(rotationController),
              child: Container(
                width: maxWidth / 2.6,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        textScaleFactor: 1.4,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.info,
                        textScaleFactor: 1.2,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      _isAllDay
                          ? Text(
                              'Last all day',
                              textScaleFactor: 1.2,
                            )
                          : Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Starts:',
                                    textScaleFactor: 1.2,
                                  ),
                                  Text(
                                    DateFormat('HH:mm')
                                        .format(widget.startDate),
                                    textScaleFactor: 1.2,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Ends:',
                                    textScaleFactor: 1.2,
                                  ),
                                  Text(
                                    DateFormat('HH:mm').format(widget.endDate),
                                    textScaleFactor: 1.2,
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
