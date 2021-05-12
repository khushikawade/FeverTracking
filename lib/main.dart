import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/src/app.dart';
import 'package:mobile_app/src/modules/logs/model/logsmodel.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = Platform.isAndroid
      ? await path_provider.getDownloadsDirectory()
      : await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter(LogsModelAdapter());
  runApp(AppTemplate());
}
