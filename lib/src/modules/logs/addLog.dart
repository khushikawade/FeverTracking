// import 'dart:convert';
// import 'dart:ffi';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_app/src/globals.dart' as globals;
// import 'package:intl/intl.dart';
// import 'package:mobile_app/src/modules/graphdata/user_temp_grap.dart';
// import 'package:mobile_app/src/styles/theme.dart';
// import 'package:mobile_app/src/overrides.dart' as overrides;

// class AddLogPage extends StatefulWidget {
//   @override
//   _AddLogPageState createState() => _AddLogPageState();
// }

// class _AddLogPageState extends State<AddLogPage> {
//   String time;
//   String dateTime;

//   DateTime selectedDate = DateTime.now();
//   String now = DateFormat('yyyy-MM-dd , kk:mm').format(DateTime.now());

//   Future<void> bottomSheet(BuildContext context, Widget child,
//       {double height}) {
//     return showModalBottomSheet(
//         isScrollControlled: false,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(13), topRight: Radius.circular(13))),
//         backgroundColor: Theme.of(context).backgroundColor,
//         context: context,
//         builder: (context) => Container(
//             height: height ?? MediaQuery.of(context).size.height / 3,
//             child: child));
//   }

//   Widget datetimePicker() {
//     return CupertinoDatePicker(
//       initialDateTime: DateTime.now(),
//       onDateTimeChanged: (DateTime newdate) {
//         print(newdate);
//         setState(() {
//           dateTime = DateFormat("yyyy-MM-dd , kk:mm").format(newdate);
//         });
//       },
//       use24hFormat: true,
//       maximumDate: new DateTime(2021, 12, 30),
//       minimumYear: 2010,
//       maximumYear: 2021,
//       minuteInterval: 1,
//       mode: CupertinoDatePickerMode.dateAndTime,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 5,
//         // backgroundColor: Color(0xff463DC7),
//         centerTitle: true,
//         title: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Add Log',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: AppTheme.title,
//                   letterSpacing: 0,
//                   fontSize: globals.deviceType == 'phone' ? 20 : 28,
//                   fontFamily: 'SF UI Display Semibold',
//                   fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.close,
//             size: 30.0,
//             color: AppTheme.iconColor,
//           ),
//         ),
//         actions: [
//           InkWell(
//             onTap: () {
//               Navigator.of(context).pop(1);
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: Icon(
//                 const IconData(59809, fontFamily: "MaterialIcons"),
//                 color: AppTheme.iconColor,
//                 size: 24,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         color: Theme.of(context).backgroundColor,
//         child: Column(children: [
//           Container(
//             padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
//             child: ListTile(
//               leading: Text(
//                 "Time",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: AppTheme.textColor1,
//                     fontFamily: "SF UI Display Regular Bold",
//                     fontSize: globals.deviceType == "phone" ? 17 : 25),
//               ),
//               trailing: Wrap(
//                 alignment: WrapAlignment.center,
//                 children: <Widget>[
//                   dateTime == null
//                       ? Text(
//                           "$now",
//                           style: TextStyle(
//                               color: AppTheme.textColor2,
//                               fontFamily: "SF UI Display Regular",
//                               fontSize:
//                                   globals.deviceType == "phone" ? 17 : 25),
//                         )
//                       : Text(
//                           "$dateTime",
//                           style: TextStyle(
//                               color: AppTheme.textColor2,
//                               fontFamily: "SF UI Display Regular",
//                               fontSize:
//                                   globals.deviceType == "phone" ? 17 : 25),
//                         ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 02),
//                     child: Icon(
//                       Icons.arrow_forward_ios,
//                       color: AppTheme.arrowIconsColor.withOpacity(0.2),
//                       size: globals.deviceType == 'phone' ? 15 : 23,
//                     ),
//                   ),
//                 ],
//               ),
//               selected: true,
//               onTap: () {
//                 bottomSheet(context, datetimePicker());
//                 print(dateTime);
//               },
//             ),
//           ),
//           Container(
//             height: 1,
//             margin: EdgeInsets.only(left: 20),
//             decoration: BoxDecoration(
//               color: AppTheme.dividerColor.withOpacity(0.25),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
//             child: ListTile(
//               leading: Text(
//                 "Postion",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: AppTheme.textColor1,
//                     fontFamily: "SF UI Display Regular Bold",
//                     fontSize: globals.deviceType == "phone" ? 17 : 25),
//               ),
//               trailing: Wrap(
//                 alignment: WrapAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     "Underarm",
//                     style: TextStyle(
//                         color: AppTheme.textColor2,
//                         fontFamily: "SF UI Display Regular",
//                         fontSize: globals.deviceType == "phone" ? 17 : 25),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 02),
//                     child: Icon(
//                       Icons.arrow_forward_ios,
//                       color: AppTheme.arrowIconsColor.withOpacity(0.2),
//                       size: globals.deviceType == 'phone' ? 15 : 23,
//                     ),
//                   ),
//                 ],
//               ),
//               selected: true,
//               onTap: () {},
//             ),
//           ),
//           Container(
//             height: 1,
//             margin: EdgeInsets.only(left: 20),
//             decoration: BoxDecoration(
//               color: AppTheme.dividerColor.withOpacity(0.25),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
//             child: ListTile(
//               leading: Text(
//                 "Temp",
//                 style: TextStyle(
//                     color: AppTheme.textColor1,
//                     fontFamily: "SF UI Display Regular",
//                     fontSize: globals.deviceType == "phone" ? 17 : 25),
//               ),
//               trailing: Wrap(
//                 alignment: WrapAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     "97  \u00B0C",
//                     style: TextStyle(
//                         color: AppTheme.textColor2,
//                         fontFamily: "SF UI Display Regular",
//                         fontSize: globals.deviceType == "phone" ? 17 : 25),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       top: 02,
//                     ),
//                     child: Icon(
//                       Icons.arrow_forward_ios,
//                       color: AppTheme.arrowIconsColor.withOpacity(0.25),
//                       size: 15,
//                     ),
//                   ),
//                 ],
//               ),
//               selected: true,
//               onTap: () {},
//             ),
//           ),
//           Container(
//             height: 1,
//             margin: EdgeInsets.only(left: 20),
//             decoration: BoxDecoration(
//               color: AppTheme.dividerColor.withOpacity(0.25),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
//             child: ListTile(
//               leading: Text(
//                 "Symptoms",
//                 style: TextStyle(
//                     color: AppTheme.textColor1,
//                     fontFamily: "SF UI Display Regular",
//                     fontSize: 17),
//               ),
//               trailing: Icon(
//                 Icons.arrow_forward_ios,
//                 color: AppTheme.arrowIconsColor.withOpacity(0.25),
//                 size: globals.deviceType == 'phone' ? 15 : 23,
//               ),
//               selected: true,
//               onTap: () {},
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 10, bottom: 10),
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               color: AppTheme.subHeadingbackgroundcolor,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 18.0),
//               child: Text(
//                 "Medicines Log",
//                 style: TextStyle(
//                     color: AppTheme.subHeadingTextColor,
//                     fontFamily: "SF UI Display Regular",
//                     fontSize: globals.deviceType == "phone" ? 13 : 21),
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
//             child: ListTile(
//               leading: Text(
//                 "Add Medicine Log",
//                 style: TextStyle(
//                     color: AppTheme.textColor1,
//                     fontFamily: "SF UI Display Regular",
//                     fontSize: globals.deviceType == "phone" ? 17 : 25),
//               ),
//               trailing: Icon(
//                 Icons.arrow_forward_ios,
//                 color: AppTheme.arrowIconsColor.withOpacity(0.25),
//                 size: globals.deviceType == 'phone' ? 15 : 23,
//               ),
//               selected: true,
//               onTap: () {},
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 10, bottom: 10),
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               color: AppTheme.subHeadingbackgroundcolor,
//               boxShadow: [
//                 const BoxShadow(
//                   color: AppTheme.subHeadingbackgroundcolor2,
//                   spreadRadius: 0,
//                   blurRadius: 0,
//                   offset: Offset(0, -0.5),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 20.0),
//               child: Text(
//                 "Note",
//                 style: TextStyle(
//                     color: AppTheme.subHeadingTextColor,
//                     fontFamily: "SF UI Display Regular",
//                     fontSize: globals.deviceType == "phone" ? 13 : 21),
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
//             child: ListTile(
//               leading: Text(
//                 "Add note here",
//                 style: TextStyle(
//                     color: AppTheme.textColor1,
//                     fontFamily: "SF UI Display Regular",
//                     fontSize: globals.deviceType == "phone" ? 17 : 25),
//               ),
//               selected: true,
//               onTap: () {},
//             ),
//           ),
//           Container(
//             height: 1,
//             margin: EdgeInsets.only(left: 20),
//             decoration: BoxDecoration(
//               color: AppTheme.dividerColor.withOpacity(0.25),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/modules/logs/model/logsmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';

class AddLogPage extends StatefulWidget {
  bool fromHomePage;

  AddLogPage({Key key, this.fromHomePage}) : super(key: key);
  @override
  _AddLogPageState createState() => _AddLogPageState();
}

class _AddLogPageState extends State<AddLogPage> {
  String time;

  List<String> tempList = [];
  List<String> sypmtoms = ["Hadache"];
  String celsiusORfahrenheit = "celsius";
  List<String> fahrenheittempratureList = [
    "99.5",
    "99.6",
    "99.7",
    "99.8",
    "99.9",
    "100.0",
    "100.1",
    "100.2",
    "100.3",
    "100.4",
    "100.5",
    "100.6",
    "100.7",
    "100.8",
    "100.9",
    "101.0",
    "101.1",
    "101.2",
    "101.3",
    "101.4",
    "101.5",
    "101.6",
    "101.7",
    "101.8",
    "101.9",
    "102.0",
    "102.1",
    "102.2",
    "102.3",
    "102.4",
    "102.5",
    "102.6",
    "102.7",
    "102.8",
    "102.9",
    "103.0",
    "103.1",
    "103.2",
    "103.3",
    "103.4",
    "103.5",
    "103.6",
    "103.7",
    "103.8",
    "103.9",
    "104.0",
    "104.1",
    "104.2",
    "104.3",
    "104.4",
    "104.5",
    "104.6",
    "104.7",
    "104.8",
    "104.9",
    "105.0",
    "105.1",
    "105.2",
    "105.3",
    "105.4",
    "105.5",
    "105.6",
    "105.7",
    "105.8",
    "105.9",
  ];

  var distinctIds;
  DateTime dateTime;
  //String deviceType = "Phone";
  String postion = "underarm";
  String temp = "97 \u00B0C";
  String symptoms = "Cold, cuff,fever";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime selectedDate = DateTime.now();
  String now = DateFormat('yyyy-MM-dd , kk:mm').format(DateTime.now());

  void addLog(LogsModel log) async {
    bool isSuccess = await DbServices().addData(log, Strings.hiveLogName);

    if (isSuccess != null && isSuccess) {
      Utility.showSnackBar(_scaffoldKey, 'Data Added Successfully', context);
      Future.delayed(const Duration(seconds: 3), () {
        if (widget.fromHomePage != null && widget.fromHomePage) {
          Navigator.of(context).pop(1);
        } else {
          Navigator.of(context).pop(true);
        }
      });
    }
  }

  Future<void> bottomSheet(BuildContext context, Widget child,
      {double height}) {
    return showModalBottomSheet(
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13), topRight: Radius.circular(13))),
        backgroundColor: Theme.of(context).backgroundColor,
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
        //setState(() {
        //dateTime = DateFormat("yyyy-MM-dd , kk:mm").format(newdate);
        dateTime = newdate;
        print("Date : ${dateTime}");
//});
      },
      use24hFormat: true,
      maximumDate: new DateTime(2021, 12, 30),
      minimumYear: 2010,
      maximumYear: 2021,
      minuteInterval: 1,
      mode: CupertinoDatePickerMode.dateAndTime,
    );
  }

//   int startIndex = 0;  UNCOMMENT
// int endIndex = 3;
//  subList = myList.sublist(startIndex, endIndex);

  List<CheckBoxData> checkboxDataList = [
    new CheckBoxData(id: '1', displayId: 'Sweating', checked: false),
    new CheckBoxData(
        id: '2', displayId: 'Chills and shivering', checked: false),
    new CheckBoxData(id: '3', displayId: 'Headache', checked: false),
    new CheckBoxData(id: '4', displayId: 'Muscle Aches', checked: false),
    new CheckBoxData(id: '5', displayId: 'Loss of Appetite', checked: false),
    new CheckBoxData(id: '6', displayId: 'Irritability', checked: false),
    new CheckBoxData(id: '7', displayId: 'Dehydration', checked: false),
    new CheckBoxData(id: '8', displayId: 'General Weakness', checked: false),
    new CheckBoxData(
        id: '9', displayId: 'Loss of Taste or Smell', checked: false),
    new CheckBoxData(id: '10', displayId: 'Cough ', checked: false),
    new CheckBoxData(
        id: '11', displayId: 'Shortness of Breath ', checked: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 5,
        // backgroundColor: Color(0xff463DC7),
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Add Log',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.title,
                  letterSpacing: 0,
                  fontSize: globals.deviceType == 'phone' ? 20 : 28,
                  fontFamily: 'SF UI Display Semibold',
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            size: 30.0,
            color: AppTheme.iconColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                final log = LogsModel(dateTime, postion, temp, symptoms);
                addLog(log);
              },
              icon: Icon(
                const IconData(59809, fontFamily: "MaterialIcons"),
                color: AppTheme.iconColor,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
            child: ListTile(
              leading: Text(
                "Time",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppTheme.textColor1,
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
                              color: AppTheme.textColor2,
                              fontFamily: "SF UI Display Regular",
                              fontSize:
                                  globals.deviceType == "phone" ? 17 : 25),
                        )
                      : Text(
                          "$dateTime",
                          style: TextStyle(
                              color: AppTheme.textColor2,
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
                      color: AppTheme.arrowIconsColor.withOpacity(0.2),
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
              color: AppTheme.dividerColor.withOpacity(0.25),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
            child: ListTile(
              leading: Text(
                "Postion",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppTheme.textColor1,
                    fontFamily: "SF UI Display Regular Bold",
                    fontSize: globals.deviceType == "phone" ? 17 : 25),
              ),
              trailing: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  Text(
                    "$postion",
                    style: TextStyle(
                        color: AppTheme.textColor2,
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
                      color: AppTheme.arrowIconsColor.withOpacity(0.2),
                      size: globals.deviceType == 'phone' ? 15 : 23,
                    ),
                  ),
                ],
              ),
              selected: true,
              onTap: () {
                _onButtonPressed();
              },
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: AppTheme.dividerColor.withOpacity(0.25),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
            child: ListTile(
              leading: Text(
                "Temp",
                style: TextStyle(
                    color: AppTheme.textColor1,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == "phone" ? 17 : 25),
              ),
              trailing: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  Text(
                    "$temp " + "\u2109",
                    style: TextStyle(
                        color: AppTheme.textColor2,
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
                      color: AppTheme.arrowIconsColor.withOpacity(0.25),
                      size: 15,
                    ),
                  ),
                ],
              ),
              selected: true,
              onTap: () {
                _settingModalBottomSheet(context, fahrenheittempratureList);
              },
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: AppTheme.dividerColor.withOpacity(0.25),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
            child: ListTile(
              leading: Text(
                "Symptoms",
                style: TextStyle(
                    color: AppTheme.textColor1,
                    fontFamily: "SF UI Display Regular",
                    fontSize: 17),
              ),
              trailing: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  Text(
                    "${sypmtoms[0]}",
                    style: TextStyle(
                        color: AppTheme.textColor2,
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
                      color: AppTheme.arrowIconsColor.withOpacity(0.25),
                      size: 15,
                    ),
                  ),
                ],
              ),
              selected: true,
              onTap: () {
                _showSymtomModalSheet();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppTheme.subHeadingbackgroundcolor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                "Medicines Log",
                style: TextStyle(
                    color: AppTheme.subHeadingTextColor,
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
                    color: AppTheme.textColor1,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == "phone" ? 17 : 25),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.arrowIconsColor.withOpacity(0.25),
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
              color: AppTheme.subHeadingbackgroundcolor,
              boxShadow: [
                const BoxShadow(
                  color: AppTheme.subHeadingbackgroundcolor2,
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(0, -0.5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Note",
                style: TextStyle(
                    color: AppTheme.subHeadingTextColor,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == "phone" ? 13 : 21),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
            child: ListTile(
              leading: Text(
                "Add note here",
                style: TextStyle(
                    color: AppTheme.textColor1,
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
              color: AppTheme.dividerColor.withOpacity(0.25),
            ),
          ),
        ]),
      ),
    );
  }

  void _onButtonPressed() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 180,
            child: Container(
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  _settingModalBottomSheet(
    context,
    obj,
  ) {
    //final List _arr = obj.keys.toList();
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: Color(0xffffffff),
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: new Wrap(
                children: obj
                    .map<Widget>((i) => new ListTile(
                          leading: new Icon(Icons.music_note),
                          title: new Text(
                            '$i',
                            style: TextStyle(
                              color: Color(0xff463DC7),
                              fontSize: 17.0,
                              fontFamily: 'SF UI Display Regular',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () => _selectTemp(i),
                        ))
                    .toList()),
          );
        });
  }

  ListView _buildBottomNavigationMenu() {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(const IconData(0xe1e2, fontFamily: 'MaterialIcons')),
          title: Text('Forehead'),
          onTap: () => _selectItem('Forehead'),
        ),
        ListTile(
          leading: Icon(const IconData(0xe1e2, fontFamily: 'MaterialIcons')),
          title: Text('Ear'),
          onTap: () => _selectItem('Ear'),
        ),
        ListTile(
          leading: Icon(const IconData(0xe1e2, fontFamily: 'MaterialIcons')),
          title: Text('Mouth'),
          onTap: () => _selectItem('Mouth'),
        ),
        ListTile(
          leading: Icon(const IconData(0xe1e2, fontFamily: 'MaterialIcons')),
          title: Text('Underarm'),
          onTap: () => _selectItem('Mouth'),
        ),
      ],
    );
  }

  void _showSymtomModalSheet() {
    Future<void> future = showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter state2) {
            return SingleChildScrollView(
              child: LimitedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: checkboxDataList.map<Widget>(
                    (data) {
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CheckboxListTile(
                              value: data.checked,
                              title: Text(data.displayId),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool val) {
                                state2(() {
                                  data.checked = !data.checked;
                                  // print(data.displayId);
                                  if (tempList.length < 3) {
                                    tempList.add(data.displayId);
                                    distinctIds = tempList.toSet().toList();
                                    print(distinctIds);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            );
          },
        );
      },
    );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    setState(() {
      sypmtoms = [''];
      sypmtoms = distinctIds;
      distinctIds = [''];
      tempList = [''];
    });
    print('modal closed');
  }
  // ListView _buildBottomNavigationMenu() {
  //   return ListView(
  //     children: <Widget>[
  //       ListView.builder(
  //         scrollDirection: Axis.vertical,
  //         shrinkWrap: true,
  //         itemCount: frahenitempratureList.length,
  //         itemBuilder: (context, index) {
  //           return Text('${frahenitempratureList[index]}');
  //         },
  //       )
  //       // ListTile(
  //       //   leading: Icon(const IconData(0xe1e2, fontFamily: 'MaterialIcons')),
  //       //   title: Text('Underarm'),
  //       //   onTap: () => _selectItem('Mouth'),
  //       // ),
  //     ],
  //   );
  // }

  void _selectItem(String name) {
    Navigator.pop(context);
    setState(() {
      postion = name;
    });
  }

  void _selectTemp(String t) {
    Navigator.pop(context);
    setState(() {
      temp = t;
    });
  }
}

class CheckBoxData {
  String id;
  String displayId;
  bool checked;

  CheckBoxData({
    this.id,
    this.displayId,
    this.checked,
  });

  factory CheckBoxData.fromJson(Map<String, dynamic> json) => CheckBoxData(
        id: json["id"] == null ? null : json["id"],
        displayId: json["displayId"] == null ? null : json["displayId"],
        checked: json["checked"] == null ? null : json["checked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "displayId": displayId == null ? null : displayId,
        "checked": checked == null ? null : checked,
      };
}
