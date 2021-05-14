import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/graphdata/user_temp_grap.dart';
import 'package:mobile_app/src/modules/home/createPDF.dart';

import 'package:mobile_app/src/modules/home/menu_screen.dart';

import 'package:mobile_app/src/modules/logs/addLog.dart';
import 'package:mobile_app/src/modules/logs/log.dart';
import 'package:mobile_app/src/modules/medicines/medicine.dart';

import 'package:mobile_app/src/modules/profile/setting.dart';
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'dart:io';

import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  var logsList;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getLogs();
    super.initState();
  }

  // get Logs List
  getLogs() async {
    logsList = await DbServices().getListData(Strings.hiveLogName);
    print("Lenght : ${logsList.length}");
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    getLogs();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                            onPressed: () {
                              if (logsList != null && logsList.length > 0) {
                                generatePDFFile();
                              } else {
                                Utility.showSnackBar(
                                    _scaffoldKey, 'No Logs Found', context);
                              }

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => PdfViewerPage()));
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
              ? LogPage(
                  onUpdateWidget: (bool result) {
                    if (result != null && result) {
                      getLogs();
                    }
                  },
                )
              // ? FutureBuilder(
              //     future: Hive.openBox(
              //       'Logs',
              //       compactionStrategy: (int total, int deleted) {
              //         return deleted > 20;
              //       },
              //     ),
              //     builder: (BuildContext context, AsyncSnapshot snapshot) {
              //       if (snapshot.connectionState == ConnectionState.done) {
              //         if (snapshot.hasError)
              //           return Text(snapshot.error.toString());
              //         else
              //           return LogPage();
              //       } else
              //         return Scaffold();
              //     })
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

  // generate Pdf File
  generatePDFFile() async {
    var columns = [
      "Temp(${Strings.feranahiteString})",
      "Symptoms",
      "Position",
      "Date",
      "Dosage",
      "Description"
    ];
    ProgressDialog dialog = new ProgressDialog(context);
    await dialog.show();

    File pdfFile = await generatePDF(columns, _generateTableData());
    if (pdfFile != null) {
      print(pdfFile.path);
      _onShare(pdfFile, context);
    }
    await dialog.hide();
  }

  _onShare(File pdfFile, BuildContext context) async {
    await Share.shareFiles([pdfFile.path],
        subject: 'Log File', text: 'Log File');
  }

  _generateTableData() {
    List<List<String>> data = new List();
    for (dynamic d in logsList != null && logsList.length > 0 ? logsList : null)
      data.add(<String>[
        d.temprature != null && d.temprature.isNotEmpty
            ? d.temprature.toString()
            : '',
        d.symptoms != null && d.symptoms.isNotEmpty
            ? d.symptoms.toString()
            : "",
        d.position != null && d.position.isNotEmpty
            ? d.position.toString()
            : '',
        d.dateTime != null
            ? DateFormat('dd-MM-yyyy')
                .format(DateTime.parse(d.dateTime.toString()))
                .toString()
            : '',
        d.addMedinceLog != null
            ? d.addMedinceLog.medicineName != null &&
                    d.addMedinceLog.medicineName.isNotEmpty &&
                    d.addMedinceLog.dosage != null &&
                    d.addMedinceLog.dosage.isNotEmpty
                ? '${d.addMedinceLog.medicineName}, ${d.addMedinceLog.dosage}'
                : d.addMedinceLog.medicineName != null &&
                        d.addMedinceLog.medicineName.isNotEmpty
                    ? '${d.addMedinceLog.medicineName}'
                    : d.addMedinceLog.dosage != null &&
                            d.addMedinceLog.dosage.isNotEmpty
                        ? '${d.addMedinceLog.dosage}'
                        : ''
            : "",
        d.addNotehere != null && d.addNotehere.isNotEmpty
            ? d.addNotehere.toString()
            : '',
      ]);
    return data;
  }
}
