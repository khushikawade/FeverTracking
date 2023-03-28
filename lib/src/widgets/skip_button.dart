import 'package:mobile_app/src/db/db_services.dart';

import 'package:flutter/material.dart';

import 'package:mobile_app/src/utils/utility.dart';
import 'package:mobile_app/src/widgets/bubble_showcase.dart';

class SkipButton extends StatefulWidget {
  SkipButton({
    Key key,
  }) : super(key: key);
  @override
  _SkipButtonState createState() => _SkipButtonState();
}

class _SkipButtonState extends State<SkipButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Utility.navigateToScreen(context);
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => BubbleShowcaseDemoApp()));
      },
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
            width: 70,
            height: 25,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade400,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 2.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Skip", textAlign: TextAlign.center),
                  Icon(Icons.arrow_forward,
                      color: Theme.of(context).accentColor, size: 15)
                ],
              ),
            )),
      ),
    );
  }
}
