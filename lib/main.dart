import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/src/app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  // Hive.registerAdapter(ContactAdapter());
  runApp(AppTemplate());
}
