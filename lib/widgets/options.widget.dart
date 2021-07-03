import 'package:chat_application/redux/actions/calendar.actions.dart';
import 'package:chat_application/redux/states/app.state.dart';
import 'package:chat_application/services/app-localizations.service.dart';

class Option {
  Option({this.title, this.type, this.eventId});

  final String title;
  final OptionType type;
  int eventId;

  Option setEvent(int eventId) {
    this.eventId = eventId;
    return this;
  }
}

List<Option> options = <Option>[
  Option(title: AppLocalizations.DELETE, type: OptionType.REMOVE),
];

void selectOption(Option option) {
  if (option.type == OptionType.REMOVE) {
    calendarooState.dispatch(DoToEvent(RemoveEvent, option.eventId));
  }
}

enum OptionType { REMOVE }
