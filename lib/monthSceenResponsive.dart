import 'package:flutter/widgets.dart';

abstract class MonthDetailsResponsive extends StatelessWidget {
  MonthDetailsResponsive(this.width);
  final double width;
  Widget potrait();

  Widget landscape();

  @override
  Widget build(BuildContext context) {
    return width > 600 ? landscape() : potrait();
  }
}

class MonthDetailsResponse extends MonthDetailsResponsive {
  MonthDetailsResponse({width, this.listOfWidget}) : super(width);
  final List<Widget> listOfWidget;

  Widget potrait() {
    return SingleChildScrollView(
      child: Column(
        children: listOfWidget,
      ),
    );
  }

  Widget landscape() {
    return SingleChildScrollView(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: listOfWidget,
    ));
  }
}
