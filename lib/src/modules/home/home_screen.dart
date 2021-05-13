import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/graphdata/user_temp_grap.dart';

import 'package:mobile_app/src/modules/home/menu_screen.dart';
import 'package:mobile_app/src/modules/home/pdf_viewer_page.dart';
import 'package:mobile_app/src/modules/logs/addLog.dart';
import 'package:mobile_app/src/modules/logs/log.dart';
import 'package:mobile_app/src/modules/medicines/medicine.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_app/src/modules/profile/setting.dart';
import 'package:mobile_app/src/styles/theme.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:mobile_app/src/modules/logs/addLog.dart';
import 'package:mobile_app/src/modules/logs/model/logsmodel.dart';

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
        backgroundColor: Theme.of(context).primaryColor,
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
                        color: AppTheme.titleColor,
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
                            color: AppTheme.titleColor.withOpacity(0.6),
                            letterSpacing: 0.08,
                            fontSize: globals.deviceType == 'phone' ? 13 : 21,
                            fontFamily: 'SF UI Display Regular',
                            fontWeight: FontWeight.normal),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: AppTheme.dropdowniconColor,
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
                        color: AppTheme.titleColor,
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
                            color: AppTheme.titleColor,
                            letterSpacing: 0,
                            fontSize: globals.deviceType == 'phone' ? 20 : 28,
                            fontFamily: 'SF UI Display Semibold',
                            fontWeight: FontWeight.w600),
                      )
                    : Text(
                        'Settings',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppTheme.titleColor,
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
                });
              }
            },
            icon: Icon(
              const IconData(0xe804, fontFamily: "FeverTrackingIcons"),
              // color: AppTheme.iconColor,
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
              : selectedIndex == 0
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: IconButton(
                        onPressed: () async {},
                        icon: Icon(
                          const IconData(0xe800,
                              fontFamily: "FeverTrackingIcons"),
                          // color:AppTheme.iconColor,
                          size: 24,
                        ),
                      ),
                    )
                  : selectedIndex == 1
                      ? Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: IconButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PdfViewerPage()));
                            },
                            icon: Icon(
                              const IconData(0xe809,
                                  fontFamily: "FeverTrackingIcons"),
                              // color:AppTheme.iconColor,
                              size: 24,
                            ),
                          ),
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
                              const IconData(0xe802,
                                  fontFamily: "FeverTrackingIcons"),
                              // color:AppTheme.iconColor,
                              size: 24,
                            ),
                          ),
                        )
        ],
      ),
      body: selectedIndex == 0
          ? UserTemperaturePage()
          : selectedIndex == 1
              ? FutureBuilder(
                  future: Hive.openBox(
                    'Logs',
                    compactionStrategy: (int total, int deleted) {
                      return deleted > 20;
                    },
                  ),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError)
                        return Text(snapshot.error.toString());
                      else
                        return LogPage();
                    } else
                      return Scaffold();
                  })
              : selectedIndex == 2
                  ? MedicinesPage(
                      fromHomePage: true,
                    )
                  : SettingPage(),
      floatingActionButton: selectedIndex == 0
          ? GestureDetector(
              onTap: () async {
                int index = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddLogPage(
                            fromHomePage: true,
                          )),
                );

                if (index != null) {
                  setState(() {
                    selectedIndex = index;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
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
                  const IconData(0xe806, fontFamily: 'FeverTrackingIcons'),
                  color: AppTheme.iconColor,
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

  @override
  void dispose() {
    Hive.box('Logs').compact();
    Hive.close();
    super.dispose();
  }
}
