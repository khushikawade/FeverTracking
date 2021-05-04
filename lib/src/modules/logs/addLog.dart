import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;

import 'package:flutter_switch/flutter_switch.dart';

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

  Color listTralingTextColor = Color(0xFF463DC7);
  Color subHeadingTextColor = Color(0xFF6D6D72);

  Color iconBackgroundColor = Color(0xff929292);
  Color toggleSwitchActiveColor = Color(0XFF4CD964);
  bool _lights = false;
  int _selectedIndexValue;
  bool isSwitched = false;
  var textValue = 'Switch is OFF';
  // var degreeSymbol = ascii.decode([0x00B0]);
  static const int deg = 0x00B0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backGroundColor,
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: 1,
            // margin: EdgeInsets.only(left: 65),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: dividerColor,
            ),
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 2.5, bottom: 2.5),
              child: Text(
                "Postion",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: listTextColor,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == "phone" ? 17 : 25),
              ),
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
                Padding(
                  padding: const EdgeInsets.only(top: 02, left: 7),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: arrowIconsColor.withOpacity(0.2),
                    size: 17,
                  ),
                ),
              ],
            ),
            selected: true,
            onTap: () {},
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 20),
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: dividerColor,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 2.5, bottom: 2.5),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 02, left: 7),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: arrowIconsColor.withOpacity(0.25),
                      size: 17,
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
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: dividerColor,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 2.5, bottom: 2.5),
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
                size: 15,
              ),
              selected: true,
              onTap: () {},
            ),
          ),
          // SizedBox(
          //   height: 5,
          // ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.width / 12,
            decoration: BoxDecoration(
              color: Color(0XFFEFEFF4),
              // color: Color(0XFFC7C7C7),

              // boxShadow: [
              //   // const BoxShadow(
              //   //   color: Color(0XFFEFEFF4),
              //   // ),
              //   const BoxShadow(
              //     // color: Color(0XFFC7C7C7),
              //     color: Color(0XFFefeff4),
              //     spreadRadius: 0,
              //     blurRadius: 0,
              //     offset: Offset(0, -0.5),
              //   ),
              // ],
            ),
            // color: Color(0XFFC7C7C7),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
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
            // padding: EdgeInsets.only(left: 5, top: 5, right: 0, bottom: 5),
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
                size: 15,
              ),
              selected: true,
              onTap: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.width / 12,
            decoration: BoxDecoration(
              color: Color(0XFFEFEFF4),
              // color: Color(0XFFC7C7C7),

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
            // color: Color(0XFFC7C7C7),
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
            // padding: EdgeInsets.only(left: 5, top: 5, right: 0, bottom: 5),
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
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: dividerColor,
            ),
          ),
        ]),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
