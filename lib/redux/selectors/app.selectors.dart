import 'package:chat_application/redux/states/app-status.state.dart';
import 'package:chat_application/redux/states/app.state.dart';
import 'package:chat_application/redux/states/calendar.state.dart';

// TODO remove this file
CalendarState calendarSelector(AppState state) => state.calendarState;
AppStatusState lifecycleSelector(AppState state) => state.appStatusState;
