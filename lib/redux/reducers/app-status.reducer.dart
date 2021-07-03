import 'package:chat_application/redux/actions/app-status.actions.dart';
import 'package:chat_application/redux/states/app-status.state.dart';
import 'package:redux/redux.dart';

final appStatusReducer = combineReducers<AppStatusState>([
  TypedReducer<AppStatusState, StartApplication>(_startApplicationEvent),
]);

AppStatusState _startApplicationEvent(
    AppStatusState state, StartApplication action) {
  return state.copyWith(appStatus: AppStatus.STARTED);
}
