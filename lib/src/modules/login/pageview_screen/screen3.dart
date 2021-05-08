import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;

class Screen3 extends StatefulWidget {
  @override
  Screen3State createState() => Screen3State();
}

class Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        color: Colors.white,
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
          'assets/images/welcome_03.png',
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Send all the data to doctor or caregiver in a PDF',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xff0F0F0F),
              letterSpacing: 0,
              fontSize: globals.deviceType == 'phone' ? 24 : 32,
              fontFamily: 'SF UI Display Bold',
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'A primary caregiver is the person who takes primary responsibility for someone who cannot care fully for himself or herself.',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).accentColor,
              letterSpacing: 0,
              fontSize: globals.deviceType == 'phone' ? 17 : 25,
              fontFamily: 'SF UI Display Regular',
              fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
