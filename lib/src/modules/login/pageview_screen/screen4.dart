import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';

class Screen4 extends StatefulWidget {
  @override
  Screen4State createState() => Screen4State();
}

class Screen4State extends State<Screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.only(left: 30, right: 30),
        child: makeWidget(),
      ),
    );
  }

  // make Widget
  Widget makeWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/undraw_Safe_re_kiil.png',
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'User privacy policy',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppTheme.contentColor1,
              letterSpacing: 0,
              fontSize: globals.deviceType == 'phone' ? 24 : 32,
              fontFamily: 'SF UI Display Bold',
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "FeverTracking app doesn't communicate with any server, so your details are fully secured in your phone.",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppTheme.contentColor2,
              letterSpacing: 0,
              fontSize: globals.deviceType == 'phone' ? 17 : 25,
              fontFamily: 'SF UI Display Regular',
              fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
