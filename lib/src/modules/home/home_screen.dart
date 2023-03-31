import 'package:bubble_showcase/bubble_showcase.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/logs/sliders/monthslider.dart';
import 'package:mobile_app/src/modules/profile/googlefit.dart';

import 'package:mobile_app/src/modules/profile/updateprofie.dart';
import 'package:mobile_app/src/widgets/bubbleWidget.dart';
import 'package:mobile_app/src/widgets/registration_success_dialog.dart';
import 'package:mobile_app/src/widgets/user_temp_grap.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  var logsList;
  bool deletemedicine = false;
  DateTime currentDate = DateTime.now();
  final DateFormat formatter = DateFormat.yMMMMd('en_US');
  DateTime selectedDate;
  DateTime pervious7days;
  DateTime pervious30days;
  bool dayIndex = false;
  bool monthIndex = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static GlobalKey previewContainer = new GlobalKey();
  GlobalKey _secondButtonKey = GlobalKey();
  @override
  void initState() {
    getLogs();
    super.initState();
  }

  // get Logs List
  getLogs() async {
    logsList = await DbServices().getListData(Strings.hiveLogName);

    setState(() {});
  }

  // DateTime getCurrentdate = DateTime.now();
  getdate(int index) {
    if (index == 1) {
      pervious7days = new DateTime(
          currentDate.year, currentDate.month, currentDate.day - 6);
      pervious30days = null;
      monthIndex = false;
    } else if (index == 2) {
      pervious30days = new DateTime(
          currentDate.year, currentDate.month - 1, currentDate.day + 1);
      pervious7days = null;
      monthIndex = false;
    } else if (index == 0) {
      currentDate = DateTime.now();
      pervious7days = null;
      pervious30days = null;
      monthIndex = false;
    } else if (index == 3) {
      monthIndex = true;
      pervious30days = null;
      pervious7days = null;
    }

    // currentDate = formatter.format(now);

    // pervious7days = new DateTime(now.year, now.month, now.day - 6);

    // pervious30days = new DateTime(now.year, now.month - 1, now.day + 1);

    setState(() {});
    // something like 2013-04-20
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
                        pervious7days != null
                            ? '${formatter.format(pervious7days)} - ${formatter.format(currentDate)}'
                            : pervious30days != null
                                ? '${formatter.format(pervious30days)} - ${formatter.format(currentDate)}'
                                : monthIndex
                                    ? " ALL"
                                    : formatter.format(currentDate),
                        // "$currentDate",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: AppTheme.titleColor.withOpacity(0.6),
                            letterSpacing: 0.08,
                            fontSize: globals.deviceType == 'phone' ? 13 : 21,
                            fontFamily: 'SF UI Display Regular',
                            fontWeight: FontWeight.normal),
                      ),
                      // Icon(
                      //   Icons.arrow_drop_down,
                      //   color: AppTheme.dropdowniconColor,
                      //   size: 18,
                      // )
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
                        onPressed: () async {
                          bottomsheet();
                          // bool result =
                          //     await Utility().takeScreenShot(previewContainer);
                          // if (result != null && result) {
                          //   Utility.showSnackBar(
                          //       _scaffoldKey,
                          //       Platform.isAndroid
                          //           ? 'The Report has been downloaded to the Download folder.'
                          //           : 'The Report has been downloaded to the Files folder.',
                          //       context);
                          // }
                        },
                        icon: Icon(
                          Icons.share,
                          // Icons.more_vert,
                          size: 24,
                          color: AppTheme.iconColor,
                        ),
                        // icon: Icon(
                        //   const IconData(0xe800,
                        //       fontFamily: "FeverTrackingIcons"),
                        //   // color:AppTheme.iconColor,
                        //   size: 24,
                        // ),
                      ),
                    )
                  : selectedIndex == 1
                      ? Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: IconButton(
                            onPressed: () {
                              checkProfile();

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
                            onPressed: () {
                              setState(() {
                                deletemedicine = !deletemedicine;
                              });
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
          ? RepaintBoundary(
              key: previewContainer,
              child: UserTemperaturePage(
                onUpdateWidget: (int index) {
                  if (index != null) {
                    getdate(index);
                    print(index);
                    setState(() {
                      // selectedDate = DateTime.now();
                    });
                  } else {
                    getdate(0);
                    setState(() {
                      // selectedDate = DateTime.now();
                    });
                  }
                },
              ),
            )
          : selectedIndex == 1
              ? LogPage(
                  onUpdateWidget: (bool result) {
                    if (result != null && result) {
                      getLogs();
                    }
                  },
                )
              : selectedIndex == 2
                  ? MedicinesPage(
                      fromHomePage: true,
                      deleteMedicine: deletemedicine,
                    )
                  : SettingPage(),
      floatingActionButton: selectedIndex == 0
          ?
          // InkWell(
          //     onTap: () async {
          //       // Navigator.push(
          //       //     context,
          //       //     MaterialPageRoute(
          //       //         builder: (context) =>
          //       //             // DatePickerTimeLine(title: "this dateTimePicker")

          //       //             GoogleFit()));

          //       int index = await Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => AddLogPage(
          //                   fromHomePage: true,
          //                 )),
          //       );

          //       if (index != null) {
          //         setState(() {
          //           selectedIndex = index;
          //         });
          //       }
          //     },
          //     child: Container(
          //       child: bubble(
          //         context,
          //         _secondButtonKey,
          //       ),
          //     ),
          //   )
          GestureDetector(
              onTap: () async {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             // DatePickerTimeLine(title: "this dateTimePicker")

                //             GoogleFit()));

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

  getUserDetail() async {
    var userData = await DbServices().getListData(Strings.updateProile);

    globals.userObj = userData;

    setState(() {});
  }

  // show success dialog
  void showSuccessDialog(BuildContext context) async {
    bool result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return RegistrationSuccessDialog();
        });
    if (result != null && result) {
      bool isValue = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => UpdateProfielPage()));

      if (isValue != null && isValue) {
        getLogs();
        getUserDetail();
      }
    }
  }

  // generate Pdf File
  generatePDFFile() async {
    var columns = [
      "Temp",
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

  checkProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isResult = pref.getBool('ISPROFILE_UPDATED');

    if (isResult != null && isResult) {
      if (logsList != null && logsList.length > 0) {
        generatePDFFile();
      } else {
        Utility.showSnackBar(_scaffoldKey, 'No Logs Found', context);
      }
    } else {
      showSuccessDialog(context);
      //Utility.showSnackBar(_scaffoldKey, 'Please Update Your Profile', context);
    }
  }

  bottomsheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          bottom: true,
          child: SingleChildScrollView(
              child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 5, right: 10, bottom: 5, top: 5),
                    child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border:
                                Border.all(width: 0.0, color: Colors.white54),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    14.0) //                 <--- border radius here
                                ),
                          ),
                          child: Icon(
                            const IconData(0xe800,
                                fontFamily: "FeverTrackingIcons"),
                            // color:AppTheme.iconColor,
                            size: 22,
                            color: AppTheme.iconColor,
                          ),
                        ),
                        title: Text(
                          "Take Screenshot",
                          style: TextStyle(
                              fontFamily: 'SF UI Display Bold',
                              fontWeight: FontWeight.w700,
                              color: AppTheme.buttomSheetTextColor,
                              fontSize:
                                  globals.deviceType == 'phone' ? 17 : 25),
                        ),
                        selected: true,
                        onTap: () {
                          Navigator.pop(context);
                          takeScreenshot();
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 5, right: 10, bottom: 0, top: 0),
                    child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border:
                                Border.all(width: 0.0, color: Colors.white54),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    14.0) //                 <--- border radius here
                                ),
                          ),
                          child: Icon(
                            const IconData(0xe809,
                                fontFamily: "FeverTrackingIcons"),
                            // color:AppTheme.iconColor,
                            size: 22,
                            color: AppTheme.iconColor,
                          ),
                        ),
                        title: Text(
                          "Share Report to Doctor",
                          style: TextStyle(
                              fontFamily: 'SF UI Display Bold',
                              fontWeight: FontWeight.w700,
                              color: AppTheme.buttomSheetTextColor,
                              fontSize:
                                  globals.deviceType == 'phone' ? 17 : 25),
                        ),
                        selected: true,
                        onTap: () {
                          Navigator.pop(context);
                          checkProfile();
                        }),
                  ),
                ],
              ),
            ),
          )),
        );
      },
    );
  }

  // take screenshot
  takeScreenshot() async {
    bool result = await Utility().takeScreenShot(previewContainer);
    if (result != null && result) {
      Utility.showSnackBar(
          _scaffoldKey,
          Platform.isAndroid
              ? 'The Report has been downloaded to the Download folder.'
              : 'The Report has been downloaded to the Files folder.',
          context);
    }
  }
}
