import 'package:chat_application/dao/database.service.dart';
import 'package:chat_application/model/event.model.dart';
import 'package:chat_application/redux/actions/calendar.actions.dart';
import 'package:chat_application/redux/states/app.state.dart';
import 'package:chat_application/routes.dart';
import 'package:chat_application/services/navigation.service.dart';
import 'package:chat_application/services/notification.service.dart';
import 'package:chat_application/services/shared-preferences.service.dart';
import 'package:redux/redux.dart';

class CalendarMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is AddEvent) {
      var id = await DatabaseService().saveEvent(action.event);
      action.event.setId(id);

      if (SharedPreferenceService().enableNotifications) {
        await NotificationService().scheduleForEvent(action.event);
      }
    }

    if (action is EditEvent) {
      await DatabaseService().editEvent(action.event);
      await NotificationService().cancelForEvent(action.event);
    }

    if (action is RemoveEvent) {
      await DatabaseService().deleteEvent(action.event.id);
      await NotificationService().cancelForEvent(action.event);
    }

    if (action is ExpandRange) {
      var eventsList =
          await DatabaseService().getEvents(action.first, action.last);
      next(LoadedEventsList(eventsList));
    }

    if (action is DoToEvent) {
      var event = await DatabaseService().findEventById(action.eventId);
      switch (action.action) {
        case AddEvent:
          call(store, AddEvent(event), next);
          break;
        case RemoveEvent:
          call(store, RemoveEvent(event), next);
          break;
        case EditEvent:
          call(store, EditEvent(event), next);
          break;
        case OpenEvent:
          await NavigationService().navigateTo(DETAILS, arguments: event);
          call(store, OpenEvent(event), next);
          break;
      }
    }
    next(action);
  }
}
