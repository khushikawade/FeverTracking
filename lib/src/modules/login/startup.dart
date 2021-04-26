import 'package:flutter/material.dart';
import 'package:mobile_app/src/overrides.dart' as overrides;

import 'package:mobile_app/src/utils/shared_preference.dart';

import 'package:shared_preferences/shared_preferences.dart';

class StartupPage extends StatefulWidget {
  bool firstLogin;
  StartupPage({Key key, this.firstLogin}) : super(key: key);
  @override
  _StartupPageState createState() => new _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  bool flag = true;
  bool showlogin = true;

  void initState() {
    super.initState();
  }

  checklogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString('username');
    setState(() {
      if (username != null) {
        flag = false;
        showlogin = false;
      } else {
        flag = false;
        showlogin = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // globals.context = context;
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/images/splash.png', fit: BoxFit.fill)));
  }
}
