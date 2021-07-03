import 'package:chat_application/model/date.model.dart';
import 'package:chat_application/model/event.model.dart';

class LoadedEventsList {
  List<Event> events;

  LoadedEventsList(this.events);
}

class AddEvent {
  final Event event;

  AddEvent(this.event);
}

class RemoveEvent {
  final Event event;

  RemoveEvent(this.event);
}

class OpenEvent {
  final Event event;

  OpenEvent(this.event);
}

class DoToEvent {
  final Type action;
  final int eventId;

  DoToEvent(this.action, this.eventId);
}

class EditEvent {
  final Event event;

  EditEvent(this.event);
}

class SelectDay {
  final Date day;

  SelectDay(this.day);
}

class ExpandRange {
  final Date first;
  final Date last;

  ExpandRange(this.first, this.last);
}
