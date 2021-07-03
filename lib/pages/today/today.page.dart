import 'package:chat_application/colors.dart';
import 'package:chat_application/routes.dart';
import 'package:chat_application/services/navigation.service.dart';
import 'package:chat_application/widgets/todaylist/todaylist.widget.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> with TickerProviderStateMixin {
  Future<void> weather;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: white,
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildTitle(context),
                  IconButton(
                    onPressed: () {
                      NavigationService().navigateTo(SETTINGS);
                    },
                    icon: Icon(
                      FeatherIcons.user,
                      color: grey,
                    ),
                  )
                ],
              ),
            ),
            TodayListWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    var _formatterDate =
        DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString());
    return Text("burası weatherdı sildim");
  }
}
