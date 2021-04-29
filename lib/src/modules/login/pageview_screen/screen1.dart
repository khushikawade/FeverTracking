import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/home/home_screen.dart';

class Screen1 extends StatefulWidget {
  @override
  Screen1State createState() => Screen1State();
}

class Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Text(
                'Skip',
                style: TextStyle(
                    color: Color(0xff463DC7),
                    letterSpacing: 0,
                    fontSize: globals.deviceType == 'phone' ? 17 : 25,
                    fontFamily: 'SF UI Display Semibold',
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
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
          'assets/images/welcome_01.png',
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Easy way to track health parameters',
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
          'Running a fever during the onset of Monsoon could have been passed off as the seasonal flu or viral fever earlier.',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xff333333),
              letterSpacing: 0,
              fontSize: globals.deviceType == 'phone' ? 17 : 25,
              fontFamily: 'SF UI Display Regular',
              fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
