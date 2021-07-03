import 'dart:collection';

import 'package:chat_application/model/date.model.dart';
import 'package:chat_application/model/event-instance.model.dart';
import 'package:chat_application/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class TodayListViewModel {
  final SplayTreeMap<Date, List<EventInstance>> eventMapped;

  TodayListViewModel({this.eventMapped});

  static TodayListViewModel fromStore(Store<AppState> store) {
    return TodayListViewModel(
      eventMapped: store.state.calendarState.eventsMapped,
    );
  }
}
