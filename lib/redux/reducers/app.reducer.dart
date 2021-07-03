import 'package:chat_application/redux/reducers/app-status.reducer.dart';
import 'package:chat_application/redux/reducers/calendar.reducer.dart';
import 'package:chat_application/redux/states/app.state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    appStatusState: appStatusReducer(state.appStatusState, action),
    calendarState: calendarReducer(state.calendarState, action),
  );
}
