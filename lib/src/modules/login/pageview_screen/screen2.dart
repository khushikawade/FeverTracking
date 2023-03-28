import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/home/home_screen.dart';
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/widgets/skip_button.dart';

class Screen2 extends StatefulWidget {
  @override
  Screen2State createState() => Screen2State();
}

class Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Theme.of(context).backgroundColor,
      //   actions: [
      //     InkWell(
      //       onTap: () {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => HomeScreen()));
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.only(right: 25),
      //         child: Text(
      //           'Skip',
      //           style: TextStyle(
      //               color: AppTheme.textColor2,
      //               letterSpacing: 0,
      //               fontSize: globals.deviceType == 'phone' ? 17 : 25,
      //               fontFamily: 'SF UI Display Semibold',
      //               fontWeight: FontWeight.w600),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 60,
            ),
            SkipButton(),
            SizedBox(
              height: 100,
            ),
            makeWidget(),
          ],
        ),
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
          'assets/images/welcome_02.png',
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Regularly track the parameters with symptoms',
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
          'In medicine, monitoring is the observation of a disease, condition or one or several medical parameters over time.',
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
