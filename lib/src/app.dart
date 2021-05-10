import 'package:flutter/material.dart';
import 'package:mobile_app/src/modules/login/startup.dart';

import 'package:mobile_app/src/styles/theme.dart';

//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class AppTemplate extends StatefulWidget {
  @override
  AppState createState() {
    return new AppState();
  }
}

class AppState extends State<AppTemplate> {
  @override
  void initState() {
    super.initState();
    //initDynamicLinks();
  }

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  bool _isCreatingLink = false;
  String _linkMessage;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FeverTracking',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      // routes: routes,
      home: StartupPage(),

      navigatorKey: navigatorKey,
    );
  }
}
