
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/utils/utility.dart';

Widget addToLogButton(fromHomePage, _scaffoldKey, index, items, context) {
  return InkWell(
    onTap: () {
      fromHomePage
          ? print("fromhomepage")
          : Future.delayed(const Duration(seconds: 0), () {
              Utility.showSnackBar(
                  _scaffoldKey, 'Medicine successfully added to log', context);
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pop(items[index]);
              });
            });
      //
    },
    child: Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
          width: 100,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.subHeadingbackgroundcolor2,
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
            // color: Colors.transparent,
            color: AppTheme.subHeadingbackgroundcolor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: Text(
              "Add to log",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.textColor2, fontWeight: FontWeight.bold),
            ),
          )),
    ),
  );
}
