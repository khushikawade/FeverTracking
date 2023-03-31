import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/modules/logs/addnote.dart';
import 'package:mobile_app/src/modules/logs/model/checkboxmodel.dart';
import 'package:mobile_app/src/modules/logs/model/logsmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/src/modules/logs/sliders/monthslider.dart';
import 'package:mobile_app/src/modules/medicines/medicine.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';

import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

List<CheckBoxModel> checkBoxModelList = [
  new CheckBoxModel(displayId: 'Sweating', checked: false),
  new CheckBoxModel(displayId: 'Chills and Shivering', checked: false),
  new CheckBoxModel(displayId: 'Headache', checked: false),
  new CheckBoxModel(displayId: 'Muscle Aches', checked: false),
  new CheckBoxModel(displayId: 'Loss of Appetite', checked: false),
  new CheckBoxModel(displayId: 'Irritability', checked: false),
  new CheckBoxModel(displayId: 'Dehydration', checked: false),
  new CheckBoxModel(displayId: 'General Weakness', checked: false),
  new CheckBoxModel(displayId: 'Loss of Taste or Smell', checked: false),
  new CheckBoxModel(displayId: 'Cough ', checked: false),
  new CheckBoxModel(displayId: 'Short of Breath ', checked: false),
  new CheckBoxModel(displayId: 'Runny Noise ', checked: false),
  new CheckBoxModel(displayId: 'Sore Throat ', checked: false),
];

class AddLogPage extends StatefulWidget {
  bool fromHomePage;

  AddLogPage({
    Key key,
    this.fromHomePage,
  }) : super(key: key);
  @override
  _AddLogPageState createState() => _AddLogPageState();
}

class _AddLogPageState extends State<AddLogPage> {
  String time;
  List<String> sypmtomsTempList = [];

  String sypmtoms = "";

  final DateFormat timeformatter = DateFormat('Hms');

  var medicineList = [];

  DateTime finaldate;
  var distinctIds;
  DateTime dateTime = DateTime.now();
  String timeString;
  String addNoteText = "";
  String postion = "";
  String temp = "";
  bool ClickAddLog = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<CheckBoxModel> completeSymptomsList = new List();
  List<String> newList = [];

  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

//  List<String> namesList =sypmtomsTempList.map((e) => e["Name"].toString()).toList();
// print(namesList);

  // DATABASE CODE
  void addLog(LogsModel log) async {
    bool isSuccess = await DbServices().addData(log, Strings.hiveLogName);

    if (isSuccess != null && isSuccess) {
      Utility.showSnackBar(
          _scaffoldKey, 'Log data added successfully', context);
      Future.delayed(const Duration(seconds: 2), () {
        if (widget.fromHomePage != null && widget.fromHomePage) {
          Navigator.of(context).pop(1);
        } else {
          Navigator.of(context).pop(true);
        }
      });
    }
  }

  getsymptomsDetail() async {
    List<CheckBoxModel> itemList = new List();
    var symptomsData = await DbServices().getListData(Strings.createSymptoms);

    if (symptomsData != null && symptomsData.length > 0) {
      for (int i = 0; i < symptomsData.length; i++) {
        var item = CheckBoxModel(
            displayId: '${symptomsData[i].symptomName}', checked: false);

        itemList.add(item);
      }

      completeSymptomsList = checkBoxModelList + itemList;
    } else {
      completeSymptomsList = checkBoxModelList;
    }
  }

  @override
  void initState() {
    super.initState();
    timeString = timeformatter.format(DateTime.now());
    postion = globals.postionList[3];
    temp = globals.tempertureList[0];
    getsymptomsDetail();
  }

  getList() async {
    var logsList = await DbServices().getListData(Strings.hiveLogName);

    setState(() {});
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
      // backgroundColor: Colors.amberAccent,
      initialDateTime: DateTime.now(),
      onDateTimeChanged: (DateTime newdate) {
        setState(() {
          //dateTime = DateFormat("yyyy-MM-dd , kk:mm").format(newdate);
          dateTime = newdate;
        });
      },
      use24hFormat: true,
      minimumYear: 2010,
      // maximumDate: DateTime.now(),
      // maximumDate: 2021,
      maximumYear: 2021,
      minuteInterval: 1,
      // mode: CupertinoDatePickerMode.dateAndTime,
      mode: CupertinoDatePickerMode.dateAndTime,
    );
  }

  getcurrentdate() {
    String dateString;
    if (globals.getdatefromslider != null) {
      String date = "${globals.getdatefromslider}".split(' ')[0];
      var dateAndTimeString = "$date $timeString";
      print(dateAndTimeString);

      finaldate =
          new DateFormat("yyyy-MM-dd hh:mm:ss").parse("$dateAndTimeString");

      print("FINALDATE $finaldate");
    } else {
      Utility.showSnackBar(_scaffoldKey, 'Please Select Month & Date', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.subHeadingbackgroundcolor,
      appBar: AppBar(
        backgroundColor: AppTheme.textColor2,
        elevation: 5,
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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: IconButton(
        //       onPressed: () {
        //         getcurrentdate();
        //         if ((finaldate != null) &&
        //             (postion.isNotEmpty) &&
        //             (temp.isNotEmpty) &&
        //             (sypmtoms.isNotEmpty) &&
        //             (medicineList.isNotEmpty)) {
        //           final log = LogsModel(
        //               finaldate,
        //               postion,
        //               temp,
        //               sypmtoms,
        //               medicineList != null ? medicineList[0] : null,
        //               addNoteText);

        //           addLog(log);
        //         } else {
        //           Utility.showSnackBar(
        //               _scaffoldKey, 'Please Fill All Required Field ', context);
        //         }
        //       },
        //       icon: Icon(
        //         const IconData(59809, fontFamily: "MaterialIcons"),
        //         color: AppTheme.iconColor,
        //         size: 24,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(children: [
          SizedBox(
            // width: 200.0,
            height: MediaQuery.of(context).size.height * .22,
            child: MonthSlider(
              onUpdateWidget: (bool result) {
                print(" called ...... ");
                // setState(() {});
              },
              isdefaultcall: true,
            ),
          ),
          Container(
            height: 1,
            // margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: AppTheme.dividerColor.withOpacity(0.25),
            ),
          ),
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
                          "",
                          style: TextStyle(
                              color: AppTheme.textColor2,
                              fontFamily: "SF UI Display Regular",
                              fontSize:
                                  globals.deviceType == "phone" ? 17 : 25),
                        )
                      : Text(
                          DateFormat("HH:mm").format(dateTime),
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
                Navigator.of(context).push(
                  showPicker(
                    unselectedColor: AppTheme.subHeadingTextColor,
                    context: context,
                    value: Time.fromTimeOfDay(_time, 0),
                    onChange: onTimeChanged,
                    // minuteInterval: MinuteInterval.FIVE,

                    accentColor: Theme.of(context).primaryColor,
                    disableHour: false,
                    disableMinute: false,
                    minMinute: 0,
                    maxMinute: 59,
                    onChangeDateTime: (DateTime timeNow) {
                      setState(() {
                        timeString = timeformatter.format(timeNow);
                        dateTime = timeNow;
                      });

                      print(timeString);
                    },
                  ),
                );
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
                "Position",
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
                postionAndTemperatureBottomSheet(
                    context, globals.postionList, 0, globals.postionListIcon);
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
                  temp == ''
                      ? Text(
                          "",
                        )
                      : Text(
                          "$temp ",
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
                postionAndTemperatureBottomSheet(context,
                    globals.tempertureList, 1, globals.postionListIcon);
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
          InkWell(
            onTap: () {
              setState(() {
                _showSymtomModalSheet();
                print(sypmtomsTempList.length);
              });
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Symptoms",
                      style: TextStyle(
                          color: AppTheme.textColor1,
                          fontFamily: "SF UI Display Regular",
                          fontSize: globals.deviceType == 'phone' ? 17 : 25),
                    ),
                  ),
                  Container(
                      width: sypmtomsTempList.length == 1
                          ? MediaQuery.of(context).size.width * 0.20
                          : MediaQuery.of(context).size.width * 0.40,
                      child: Text(
                        // (sypmtomsTempList.join("") + " "),
                        // ("$newList"),
                        "$sypmtoms",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: AppTheme.textColor2,
                            fontFamily: "SF UI Display Regular",
                            fontSize: globals.deviceType == "phone" ? 17 : 25),
                      )),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 5),
            child: sypmtomsTempList.isEmpty &&
                    ClickAddLog &&
                    sypmtomsTempList.length == 0
                ? Text(
                    "Please select the symptoms",
                    style: TextStyle(
                        color: AppTheme.titleColor1,
                        fontFamily: "SF UI Display Regular",
                        fontSize: globals.deviceType == "phone" ? 13 : 21),
                  )
                : Text(""),
          ),
          // sypmtomsTempList.length == 0 || sypmtomsTempList.isEmpty
          //     ? Text(
          //         "Please Select the symptoms",
          //         style: TextStyle(color: Colors.red),
          //       )
          //     : Text(""),
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
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Container(
                    height: 0.6,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  );
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: medicineList != null ? medicineList.length + 1 : 1,
                itemBuilder: (context, index) {
                  if (medicineList != null) {
                    if (index == medicineList.length) {
                      return addMedicineWidget();
                    } else {
                      return selectedMedicineWidget(medicineList, index);
                    }
                  } else {
                    return addMedicineWidget();
                  }
                }),
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
          InkWell(
            onTap: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNote()),
              );
              setState(() {
                if (result != addNoteText && result != '') addNoteText = result;
              });
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      addNoteText == '' ? "Add Note Here" : addNoteText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: AppTheme.textColor1,
                          fontFamily: "SF UI Display Regular",
                          fontSize: globals.deviceType == "phone" ? 17 : 25),
                    ),
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
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                ClickAddLog = true;
                getcurrentdate();
                if ((finaldate != null) &&
                    (postion.isNotEmpty) &&
                    (temp.isNotEmpty) &&
                    (sypmtoms.isNotEmpty) &&
                    (medicineList.isNotEmpty)) {
                  ClickAddLog = false;
                  final log = LogsModel(
                      finaldate,
                      postion,
                      temp,
                      sypmtoms,
                      medicineList != null ? medicineList[0] : null,
                      addNoteText);
                  addLog(log);
                } else {
                  // Utility.showSnackBar(
                  //     _scaffoldKey, 'Please Fill All Required Field ', context);
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 20),
              child: new Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                color: Theme.of(context).primaryColor,
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Text(
                        "Add Log",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "SF UI Display",
                          color: Colors.white,
                          fontSize: globals.deviceType == "phone" ? 17 : 25,
                        ),
                      )
                    ]),
              ),
            ),
          ),
          // Container(
          //   height: 1,
          //   margin: EdgeInsets.only(left: 20),
          //   decoration: BoxDecoration(
          //     color: AppTheme.dividerColor.withOpacity(0.25),
          //   ),
          // ),
        ]),
      ),
    );
  }

  // make selected medicine item view
  Widget selectedMedicineWidget(medicineItems, index) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // InkWell(
          //   onTap: () {
          //     medicineList.removeAt(index);
          //     setState(() {});
          //     Utility.showSnackBar(_scaffoldKey,
          //         'Medicine successfully removed from log.', context);
          //   },
          //   child: Container(
          //     padding: EdgeInsets.all(2),
          //     alignment: Alignment.center,
          //     child: Icon(
          //       Icons.delete,
          //       size: 16,
          //       color: Colors.red,
          //     ),
          //     decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         border: Border.all(color: Colors.grey, width: 1)),
          //   ),
          // ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              medicineItems[index].medicineName != null &&
                      medicineItems[index].medicineName.isNotEmpty
                  ? medicineItems[index].medicineName
                  : '',
              style: TextStyle(
                  color: AppTheme.textColor2,
                  fontFamily: "SF UI Display Regular Bold",
                  fontSize: globals.deviceType == "phone" ? 13 : 21),
            ),
          ),
          Text(
            medicineItems[index].dosage != null &&
                    medicineItems[index].dosage.isNotEmpty
                ? medicineItems[index].dosage
                : '',
            style: TextStyle(
                color: AppTheme.textColor2,
                fontFamily: "SF UI Display Regular Bold",
                fontSize: globals.deviceType == "phone" ? 13 : 21),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              medicineList.removeAt(index);
              setState(() {});
              Utility.showSnackBar(_scaffoldKey,
                  'Medicine successfully removed from log.', context);
            },
            child: Container(
              padding: EdgeInsets.all(2),
              alignment: Alignment.center,
              child: Icon(
                Icons.delete_outline,
                size: 20,
                color: Colors.red,
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 1)),
            ),
          )
          // Icon(
          //   Icons.arrow_forward_ios,
          //   color: AppTheme.arrowIconsColor.withOpacity(0.25),
          //   size: globals.deviceType == 'phone' ? 15 : 23,
          // ),
        ],
      ),
    );
  }

  // add Medicine Widget
  Widget addMedicineWidget() {
    return Column(
      children: [
        ListTile(
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
          onTap: () async {
            var medicineModel = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MedicinesPage(
                          fromHomePage: false,
                        )));

            if (medicineModel != null) {
              medicineList.add(medicineModel);
              setState(() {});
            }
          },
        ),
        Container(
          padding: EdgeInsets.only(top: 2, bottom: 2),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              // color: AppTheme.subHeadingbackgroundcolor,
              ),
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 5),
            child:
                medicineList.isEmpty && ClickAddLog && medicineList.length == 0
                    ? Text(
                        "Please add the medicines",
                        style: TextStyle(
                            color: AppTheme.titleColor1,
                            fontFamily: "SF UI Display Regular",
                            fontSize: globals.deviceType == "phone" ? 13 : 21),
                      )
                    : Text(""),
          ),
        ),
        // Container(
        //   height: 2,
        //   margin: EdgeInsets.only(left: 20),
        //   decoration: BoxDecoration(
        //     color: AppTheme.dividerColor.withOpacity(0.25),
        //   ),
        // ),
      ],
    );
  }

  // postionAndTemperatureBottomSheet(context, obj, int value) {
  //   showModalBottomSheet(
  //       context: context,
  //       isDismissible: true,
  //       enableDrag: true,
  //       backgroundColor: Theme.of(context).backgroundColor,
  //       builder: (BuildContext bc) {
  //         return SingleChildScrollView(
  //           child: new Wrap(
  //               children: obj
  //                   .map<Widget>(
  //                     (i) => new ListTile(
  //                       leading: Icon(Icons.add),
  //                       title: new Text(
  //                         '$i',
  //                         style: TextStyle(
  //                           color: AppTheme.textColor1,
  //                           fontSize:
  //                               globals.deviceType == 'phone' ? 17.0 : 25.0,
  //                           fontFamily: 'SF UI Display Regular',
  //                           fontWeight: FontWeight.w600,
  //                         ),
  //                       ),
  //                       onTap: () => _selectTemp(i, value),
  //                     ),
  //                   )
  //                   .toList()),
  //         );
  //       });
  // }

  postionAndTemperatureBottomSheet(context, obj, int value, icon) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: Theme.of(context).backgroundColor,
        builder: (BuildContext bc) {
          return ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: ListTile(
                      trailing: value == 1 ? null : icon[index],
                      title: new Text(
                        obj[index],
                        style: TextStyle(
                          color: AppTheme.textColor1,
                          fontSize: globals.deviceType == 'phone' ? 17.0 : 25.0,
                          fontFamily: 'SF UI Display Regular',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () => _selectTemp(obj[index], value),
                    ),
                  ),
                );
              });
        });
  }

  void _selectTemp(String t, int value) {
    Navigator.pop(context);
    setState(() {
      if (value == 1) {
        temp = t;
      } else {
        postion = t;
      }
    });
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
                  children: completeSymptomsList.map<Widget>(
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
                                setState(() {
                                  data.checked = !data.checked;

                                  completeSymptomsList.forEach((element) {
                                    // ... Do something here with items here
                                    print(element.checked);

                                    if (element.checked == true) {
                                      sypmtomsTempList = [];
                                      sypmtomsTempList.add(data.displayId);
                                      distinctIds =
                                          sypmtomsTempList.toSet().toList();
                                    }
                                  });

                                  // if (sypmtomsTempList.length < 3) {
                                  //   if (data.checked) {
                                  //     sypmtomsTempList = [];
                                  //     sypmtomsTempList.add(data.displayId);
                                  //     distinctIds =
                                  //         sypmtomsTempList.toSet().toList();
                                  //   }

                                  //   sypmtomsTempList.length;
                                  // }
                                });
                                state2(() {
                                  //   sypmtomsTempList.length;
                                  //   data.checked = !data.checked;

                                  //   if (sypmtomsTempList.length < 3) {
                                  //     sypmtomsTempList.add(data.displayId);
                                  //     distinctIds =
                                  //         sypmtomsTempList.toSet().toList();
                                  //     sypmtomsTempList.length;
                                  //   }
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
    for (int i = 0; i < completeSymptomsList.length; i++) {
      if (completeSymptomsList[i].checked) {
      } else {}
    }

    setState(() {
      sypmtoms = '';

      sypmtoms = distinctIds != null ? distinctIds.join(', ') : '';
      distinctIds = [];
      print(distinctIds);
      print(sypmtoms);
      // sypmtomsTempList = [];
    });
  }
}
