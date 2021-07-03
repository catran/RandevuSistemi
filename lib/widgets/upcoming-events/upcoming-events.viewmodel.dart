import 'dart:collection';

import 'package:chat_application/model/date.model.dart';
import 'package:chat_application/model/event-instance.model.dart';
import 'package:chat_application/redux/actions/calendar.actions.dart';
import 'package:chat_application/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class UpcomingEventsViewModel {
  final Date selectedDay;
  final SplayTreeMap<Date, List<EventInstance>> eventMapped;

  final Function(int) openEvent;

  UpcomingEventsViewModel({this.selectedDay, this.eventMapped, this.openEvent});

  static UpcomingEventsViewModel fromStore(Store<AppState> store) {
    return UpcomingEventsViewModel(
      selectedDay: store.state.calendarState.selectedDay,
      eventMapped: store.state.calendarState.eventsMapped,
      openEvent: (eventId) => store.dispatch(DoToEvent(OpenEvent, eventId)),
    );
  }
}
