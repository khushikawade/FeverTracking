import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/home/home_screen.dart';
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/utils/utility.dart';
import 'package:mobile_app/src/widgets/skip_button.dart';

class Screen1 extends StatefulWidget {
  @override
  Screen1State createState() => Screen1State();
}

class Screen1State extends State<Screen1> {
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
        // Text(
        //   'Skip',
        //   textAlign: TextAlign.end,
        //   style: TextStyle(
        //       color: AppTheme.contentColor1,
        //       letterSpacing: 0,
        //       fontSize: globals.deviceType == 'phone' ? 24 : 32,
        //       fontFamily: 'SF UI Display Bold',
        //       fontWeight: FontWeight.bold),
        // ),
        // SizedBox(
        //   height: 100,
        // ),
        SizedBox(
          child: Image.asset(
            'assets/images/secure.png',
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Our Commitment to Your Security',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppTheme.contentColor1,
              letterSpacing: 0,
              fontSize: globals.deviceType == 'phone' ? 24 : 32,
              fontFamily: 'SF UI Display Bold',
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 26,
        ),
        Text(
          // 'Running a fever during the onset of Monsoon could have been passed off as the seasonal flu or viral fever earlier.',
          'Your privacy is important to us. We do not collect any type of data from our users. You can use our app with confidence, knowing that your personal information is safe and secure.',
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
