import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;

class RegistrationSuccessDialog extends StatefulWidget {
  @override
  _RegistrationSuccessDialogState createState() =>
      _RegistrationSuccessDialogState();
}

class _RegistrationSuccessDialogState extends State<RegistrationSuccessDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      insetPadding: EdgeInsets.all(20),
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      //width: Utility.displayWidth(context) * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xffFFFFFF),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Image.asset(
                'assets/images/undraw_Safe_re_kiil.png',
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Please complete your profile before sharing report to your Doctor.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'SF UI Display Medium',
                      fontSize: globals.deviceType == 'phone' ? 17 : 25,
                      color: Color(0xff999999)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "FeverTracking app doesn't communicate with any server, so your details are fully secured in your phone.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SF UI Display Medium',
                  fontSize: globals.deviceType == 'phone' ? 17 : 25,
                  color: Color(0xff999999)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop(true);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Text(
                'Continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SF UI Display Medium',
                    fontSize: globals.deviceType == 'phone' ? 17 : 25,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
