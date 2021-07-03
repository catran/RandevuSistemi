import 'package:chat_application/constants.dart';
import 'package:chat_application/dao/database.service.dart';
import 'package:chat_application/environments/environment.dart';
import 'package:chat_application/model/date.model.dart';
import 'package:chat_application/model/event.model.dart';
import 'package:chat_application/redux/actions/calendar.actions.dart';
import 'package:chat_application/redux/states/app.state.dart';
import 'package:chat_application/services/shared-preferences.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../utils/notification.utils.dart';
import 'local-storage.service.dart';

class InitializerAppService {
  static final InitializerAppService _instance = InitializerAppService._();

  InitializerAppService._();

  factory InitializerAppService() {
    return _instance;
  }

  Future<List<Event>> setUp(environment, version) async {
    WidgetsFlutterBinding.ensureInitialized();
    // sharedPref init
    await SharedPreferenceService().getSharedPreferencesInstance();

    // Environment init
    Environment().environment = environment as String;
    Environment().version = version as String;

    // loadData init
    var eventsList = await preLoadingDataFromDB();

    // setup orientation
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // init Notification
    await initNotification();

    return eventsList;
  }

  static Future<List<Event>> preLoadingDataFromDB() async {
    try {
      var env = Environment().environment;
      if (env == DEVELOP) {
        final clientDB = await LocalStorageService().db;
        await LocalStorageService().dropTable(clientDB);
        debugPrint('DB deleted');
      }
    } catch (e) {
      debugPrint('error during drop db: ${e.toString()}');
    }
    var rangeStart =
        Date.convertToDate(DateTime.now().subtract(Duration(days: 60)));
    var rangeEnd = Date.convertToDate(DateTime.now().add(Duration(days: 60)));
    var eventsList = await DatabaseService().getEvents(rangeStart, rangeEnd);
    calendarooState.dispatch(LoadedEventsList(eventsList));
    return eventsList;
  }
}
