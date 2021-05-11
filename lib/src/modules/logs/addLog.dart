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

import 'package:mobile_app/src/modules/logs/model/logsmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/globals.dart' as globals;

class AddLogPage extends StatefulWidget {
  @override
  _AddLogPageState createState() => _AddLogPageState();
}

class _AddLogPageState extends State<AddLogPage> {
  String time;
  String dateTime;
  //String deviceType = "Phone";
  String postion = "underarm";
  String temp = "97  \u00B0C";
  String symptoms = "Cold, cuff,fever";

  DateTime selectedDate = DateTime.now();
  String now = DateFormat('yyyy-MM-dd , kk:mm').format(DateTime.now());

  void addLog(LogsModel log) async {
    final contactsBox = await Hive.openBox('log');
    contactsBox.add(log);
    print('${contactsBox.values}');
    print(contactsBox.getAt(0));
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
        dateTime = DateFormat("yyyy-MM-dd , kk:mm").format(newdate);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          InkWell(
            onTap: () {
              final log = LogsModel(dateTime, postion, temp, symptoms);
              addLog(log);
              Navigator.of(context).pop(1);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
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
                    "$temp",
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
}
