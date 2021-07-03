import 'dart:collection';

import 'package:chat_application/model/date.model.dart';
import 'package:chat_application/model/event-instance.model.dart';
import 'package:chat_application/model/event.model.dart';
import 'package:chat_application/redux/middlewares/app.middlewares.dart';
import 'package:chat_application/redux/middlewares/calendar.middlewares.dart';
import 'package:chat_application/redux/reducers/app.reducer.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';

import 'calendar.state.dart';
import 'app-status.state.dart';

Store<AppState> calendarooState = Store<AppState>(appReducer,
    initialState: AppState.initial(),
    middleware: [AppMiddleware(), CalendarMiddleware()]);

@immutable
class AppState {
  final AppStatusState appStatusState;
  final CalendarState calendarState;

  AppState({@required this.appStatusState, @required this.calendarState});

  factory AppState.initial() {
    return AppState(
        appStatusState: AppStatusState.initial(),
        calendarState: CalendarState.initial());
  }

  AppState copyWith(
      {AppStatusState appStatusState, CalendarState calendarState}) {
    return AppState(
        appStatusState: appStatusState ?? this.appStatusState,
        calendarState: calendarState ?? this.calendarState);
  }
}
