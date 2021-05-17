import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/src/app.dart';
import 'package:mobile_app/src/modules/Symptoms/model/symptomsmodel.dart';
import 'package:mobile_app/src/modules/logs/model/logsmodel.dart';
import 'package:mobile_app/src/modules/medicines/model/medicinemodel.dart';
import 'package:mobile_app/src/modules/profile/Model/profilemodel.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = Platform.isAndroid
      ? await path_provider.getApplicationDocumentsDirectory()
      : await path_provider.getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDirectory.path)
    ..registerAdapter(LogsModelAdapter())
    ..registerAdapter(MedicineModelAdapter())
    ..registerAdapter(SymptomsModelAdapter())
    ..registerAdapter(ProfileModelAdapter());
  runApp(AppTemplate());
}
