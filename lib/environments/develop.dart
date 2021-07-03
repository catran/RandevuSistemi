import 'package:chat_application/constants.dart';
import 'package:chat_application/main.dart';
import 'package:chat_application/services/initializer-app.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:pedantic/pedantic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var packageInfo = await PackageInfo.fromPlatform();
  unawaited(InitializerAppService().setUp(INTEGRATION, packageInfo.version));
  runApp(MyApp());
}
