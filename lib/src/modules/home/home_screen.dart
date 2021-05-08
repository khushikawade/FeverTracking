import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/graphdata/user_temp_grap.dart';

import 'package:mobile_app/src/modules/home/menu_screen.dart';
import 'package:mobile_app/src/modules/logs/addLog.dart';
import 'package:mobile_app/src/modules/logs/log.dart';
import 'package:mobile_app/src/modules/medicines/medicine.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_app/src/modules/profile/setting.dart';
import 'package:mobile_app/src/styles/colors_file.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colour.AppbarBackgroundColor,
        centerTitle: true,
        title: selectedIndex == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        letterSpacing: 0,
                        fontSize: globals.deviceType == 'phone' ? 20 : 28,
                        fontFamily: 'SF UI Display Semibold',
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Apr 23, 2021',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffFFFFFF).withOpacity(0.6),
                            letterSpacing: 0.08,
                            fontSize: globals.deviceType == 'phone' ? 13 : 21,
                            fontFamily: 'SF UI Display Regular',
                            fontWeight: FontWeight.normal),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xffB5B1E8),
                        size: 18,
                      )
                    ],
                  )
                ],
              )
            : selectedIndex == 1
                ? Text(
                    'Logs',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        letterSpacing: 0,
                        fontSize: globals.deviceType == 'phone' ? 20 : 28,
                        fontFamily: 'SF UI Display Semibold',
                        fontWeight: FontWeight.w600),
                  )
                : selectedIndex == 2
                    ? Text(
                        'Medicines',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            letterSpacing: 0,
                            fontSize: globals.deviceType == 'phone' ? 20 : 28,
                            fontFamily: 'SF UI Display Semibold',
                            fontWeight: FontWeight.w600),
                      )
                    : Text(
                        'Settings',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            letterSpacing: 0,
                            fontSize: globals.deviceType == 'phone' ? 20 : 28,
                            fontFamily: 'SF UI Display Semibold',
                            fontWeight: FontWeight.w600),
                      ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(
            onPressed: () async {
              int index = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MenuScreen(selectedIndex)),
              );
              if (index != null) {
                setState(() {
                  selectedIndex = index;
                  print("Selected Index : ${selectedIndex}");
                });
              }
            },
            icon: Icon(
              IconData(0xe804, fontFamily: "FeverTrackingIcons"),
              color: Color(0xffFFFFFF),
              size: 24,
            ),
          ),
        ),
        actions: [
          selectedIndex == 3
              ? Container(
                  height: 0,
                  width: 0,
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    onPressed: () async {
                      // if (selectedIndex == 3) {
                      //   updateProfileSuccess = await Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => EditProfileScreen()),
                      //   );
                      //   if (updateProfileSuccess != null && updateProfileSuccess) {
                      //     print("Result : ${updateProfileSuccess}");
                      //     setState(() {});
                      //   }
                      // }
                      //Navigator.pop(context);
                    },
                    icon: Icon(
                      IconData(
                          selectedIndex == 0
                              ? 0xe800
                              : selectedIndex == 1
                                  ? 0xe809
                                  : 0xe802,
                          fontFamily: "FeverTrackingIcons"),
                      color: Color(0xffFFFFFF),
                      size: 24,
                    ),
                  ),
                ),
        ],
      ),
      body: selectedIndex == 0
          ? UserTemperaturePage()
          // Container(
          //     color: Colors.red,
          //     width: double.infinity,
          //     height: double.infinity,
          //   )
          : selectedIndex == 1
              ? LogPage()
              : selectedIndex == 2
                  ? MedicinesPage()
                  : SettingPage(),
      floatingActionButton: selectedIndex == 0
          ? GestureDetector(
              onTap: () async {
                int index = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddLogPage()),
                );

                if (index != null) {
                  setState(() {
                    selectedIndex = index;
                    print("Selected Index : ${selectedIndex}");
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0XFFFAA45F),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(250, 164, 95, 60),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  const IconData(0xea16, fontFamily: 'FeverTracking'),
                  color: Colors.white,
                  size: 25,
                ),
              ),
            )
          : Container(
              height: 0,
              width: 0,
            ),
    );
  }
}
