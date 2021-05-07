import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

import 'package:mobile_app/src/modules/login/intro_page.dart';
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/globals.dart' as globals;

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
    getDeviceType();
    startTimer();
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

  getDeviceType() async {
    if (Platform.isAndroid) {
      final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
      // globals.deviceType = data.size.shortestSide < 600 ? 'tablet' :'tablet';
      globals.deviceType = data.size.shortestSide < 600 ? 'phone' : 'tablet';
      print("Device Type : ${globals.deviceType}");
    } else {
      var deviceType = await getDeviceInfo();
      globals.deviceType = deviceType == "ipad" ? "tablet" : "phone";
    }
  }

  static Future<String> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.model.toLowerCase()}');
    return iosInfo.model.toLowerCase();
  }

  // start splash screen timer
  void startTimer() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IntroPage()));
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
