import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:intl/intl.dart';
import 'package:mobile_app/src/styles/theme.dart';

class AddLogPage extends StatefulWidget {
  @override
  _AddLogPageState createState() => _AddLogPageState();
}

class _AddLogPageState extends State<AddLogPage> {
  Color backGroundColor = Color(0xFFFFFFFF);
  Color dropdowniconColor = Color(0XFFB5B1E8);
  Color textColor = Color(0xFFFFFFFF);
  Color dividerColor = Color(0xffC4CADF).withOpacity(0.25);

  Color listTextColor = Color(0xFF030303);
  Color headingTextColor = Color(0xFF000000);
  Color iconsColor = Color(0xFFd6d6d6);
  Color arrowIconsColor = Color(0xFF000000);
  String time;
  String dateTime;
  Color listTralingTextColor = Color(0xFF463DC7);
  Color subHeadingTextColor = Color(0xFF6D6D72);
  Color iconBackgroundColor = Color(0xff929292);
  Color toggleSwitchActiveColor = Color(0XFF4CD964);
  DateTime selectedDate = DateTime.now();
  String now = DateFormat('yyyy-MM-dd , kk:mm').format(DateTime.now());

  Future<void> bottomSheet(BuildContext context, Widget child,
      {double height}) {
    return showModalBottomSheet(
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13), topRight: Radius.circular(13))),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) => Container(
            height: height ?? MediaQuery.of(context).size.height / 3,
            child: child));
  }

  Widget datetimePicker() {
    return CupertinoDatePicker(
      initialDateTime: DateTime.now(),
      onDateTimeChanged: (DateTime newdate) {
        print(newdate);
        setState(() {
          dateTime = DateFormat("yyyy-MM-dd , kk:mm").format(newdate);
        });
      },
      use24hFormat: true,
      maximumDate: new DateTime(2021, 12, 30),
      minimumYear: 2010,
      maximumYear: 2021,
      minuteInterval: 1,
      mode: CupertinoDatePickerMode.dateAndTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(children: [
          SizedBox(
            height: 28,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: dividerColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
            child: ListTile(
              leading: Text(
                "Time",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: listTextColor,
                    fontFamily: "SF UI Display Regular Bold",
                    fontSize: globals.deviceType == "phone" ? 17 : 25),
              ),
              trailing: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  dateTime == null
                      ? Text(
                          "$now",
                          style: TextStyle(
                              color: listTralingTextColor,
                              fontFamily: "SF UI Display Regular",
                              fontSize:
                                  globals.deviceType == "phone" ? 17 : 25),
                        )
                      : Text(
                          "$dateTime",
                          style: TextStyle(
                              color: listTralingTextColor,
                              fontFamily: "SF UI Display Regular",
                              fontSize:
                                  globals.deviceType == "phone" ? 17 : 25),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 02),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: arrowIconsColor.withOpacity(0.2),
                      size: globals.deviceType == 'phone' ? 15 : 23,
                    ),
                  ),
                ],
              ),
              selected: true,
              onTap: () {
                bottomSheet(context, datetimePicker());
                print(dateTime);
              },
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: dividerColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
            child: ListTile(
              leading: Text(
                "Postion",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: listTextColor,
                    fontFamily: "SF UI Display Regular Bold",
                    fontSize: globals.deviceType == "phone" ? 17 : 25),
              ),
              trailing: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  Text(
                    "Underarm",
                    style: TextStyle(
                        color: listTralingTextColor,
                        fontFamily: "SF UI Display Regular",
                        fontSize: globals.deviceType == "phone" ? 17 : 25),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 02),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: arrowIconsColor.withOpacity(0.2),
                      size: globals.deviceType == 'phone' ? 15 : 23,
                    ),
                  ),
                ],
              ),
              selected: true,
              onTap: () {},
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: dividerColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
            child: ListTile(
              leading: Text(
                "Temp",
                style: TextStyle(
                    color: listTextColor,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == "phone" ? 17 : 25),
              ),
              trailing: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  Text(
                    "97  \u00B0C",
                    style: TextStyle(
                        color: listTralingTextColor,
                        fontFamily: "SF UI Display Regular",
                        fontSize: globals.deviceType == "phone" ? 17 : 25),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 02,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: arrowIconsColor.withOpacity(0.25),
                      size: 15,
                    ),
                  ),
                ],
              ),
              selected: true,
              onTap: () {},
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: dividerColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
            child: ListTile(
              leading: Text(
                "Symptoms",
                style: TextStyle(
                    color: listTextColor,
                    fontFamily: "SF UI Display Regular",
                    fontSize: 17),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: arrowIconsColor.withOpacity(0.25),
                size: globals.deviceType == 'phone' ? 15 : 23,
              ),
              selected: true,
              onTap: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0XFFEFEFF4),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                "Medicines Log",
                style: TextStyle(
                    color: subHeadingTextColor,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == "phone" ? 13 : 21),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
            child: ListTile(
              leading: Text(
                "Add Medicine Log",
                style: TextStyle(
                    color: listTextColor,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == "phone" ? 17 : 25),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: arrowIconsColor.withOpacity(0.25),
                size: globals.deviceType == 'phone' ? 15 : 23,
              ),
              selected: true,
              onTap: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0XFFEFEFF4),
              boxShadow: [
                // const BoxShadow(
                //   color: Color(0XFFEFEFF4),
                // ),
                const BoxShadow(
                  color: Color(0XFFC7C7C7),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(0, -0.5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Notes",
                style: TextStyle(
                    color: subHeadingTextColor,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == "phone" ? 13 : 21),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
            child: ListTile(
              leading: Text(
                "Add Notes here",
                style: TextStyle(
                    color: listTextColor,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == "phone" ? 17 : 25),
              ),
              selected: true,
              onTap: () {},
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: dividerColor,
            ),
          ),
        ]),
      ),
    );

    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
