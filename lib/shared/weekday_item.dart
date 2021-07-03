import 'package:flutter/material.dart';

class WeekdayItem extends StatelessWidget {
  const WeekdayItem({Key key, this.txt}) : super(key: key);
  final String txt;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 60,
      width: width / 7,
      child: Card(
        color: Colors.grey[50],
        margin: EdgeInsets.all(1),
        elevation: 2,
        child: Center(
          child: Text(
            txt,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
