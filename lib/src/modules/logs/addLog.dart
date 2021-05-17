import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/modules/logs/addnote.dart';
import 'package:mobile_app/src/modules/logs/model/logsmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/src/modules/medicines/medicine.dart';

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
  List<String> sypmtomsTempList = [];
  String sypmtoms = '';
  String celsiusORfahrenheit = "celsius";
  var medicineList = [];

  List<String> postionList = [
    " Ear ",
    " ForeHead ",
    " Underarm ",
    " Mouth ",
    " Neck ",
    " Rectum "
  ];

  List<CheckBoxData> checkboxDataList = [
    new CheckBoxData(id: '1', displayId: 'Sweating', checked: false),
    new CheckBoxData(
        id: '2', displayId: 'Chills and Shivering', checked: false),
    new CheckBoxData(id: '3', displayId: 'Headache', checked: false),
    new CheckBoxData(id: '4', displayId: 'Muscle Aches', checked: false),
    new CheckBoxData(id: '5', displayId: 'Loss of Appetite', checked: false),
    new CheckBoxData(id: '6', displayId: 'Irritability', checked: false),
    new CheckBoxData(id: '7', displayId: 'Dehydration', checked: false),
    new CheckBoxData(id: '8', displayId: 'General Weakness', checked: false),
    new CheckBoxData(
        id: '9', displayId: 'Loss of Taste or Smell', checked: false),
    new CheckBoxData(id: '10', displayId: 'Cough ', checked: false),
    new CheckBoxData(id: '11', displayId: 'Short of Breath ', checked: false),
    new CheckBoxData(id: '12', displayId: 'Runny Noise ', checked: false),
    new CheckBoxData(id: '13', displayId: 'Sore Throat ', checked: false),
  ];

  var distinctIds;
  DateTime dateTime;
  String addNoteText = "";
  String postion = "";
  String temp = "";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  String now = DateFormat('yyyy-MM-dd , kk:mm').format(DateTime.now());

  // DATABASE CODE
  void addLog(LogsModel log) async {
    bool isSuccess = await DbServices().addData(log, Strings.hiveLogName);

    if (isSuccess != null && isSuccess) {
      Utility.showSnackBar(_scaffoldKey, 'Data Added Successfully', context);
      Future.delayed(const Duration(seconds: 1), () {
        if (widget.fromHomePage != null && widget.fromHomePage) {
          Navigator.of(context).pop(1);
        } else {
          Navigator.of(context).pop(true);
        }
      });
    }
  }

  getList() async {
    var logsList = await DbServices().getListData(Strings.hiveLogName);
    // List<LogsModel> list = hiveBox.get(Strings.hiveLogName);
    print("Data : ${logsList[2].addNotehere}");
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
        print(newdate);
        setState(() {
          //dateTime = DateFormat("yyyy-MM-dd , kk:mm").format(newdate);
          dateTime = newdate;
          print("Date : ${dateTime}");
        });
      },
      use24hFormat: true,
      minimumYear: 2010,
      maximumDate: DateTime.now(),
      minuteInterval: 1,
      // mode: CupertinoDatePickerMode.dateAndTime,
      mode: CupertinoDatePickerMode.dateAndTime,
    );
  }

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
                if ((dateTime != null) &&
                    (postion.isNotEmpty) &&
                    (temp.isNotEmpty) &&
                    (sypmtoms.isNotEmpty) &&
                    (medicineList.isNotEmpty)) {
                  final log = LogsModel(
                      dateTime,
                      postion,
                      temp,
                      sypmtoms,
                      medicineList != null ? medicineList[0] : null,
                      addNoteText);
                  addLog(log);
                } else {
                  Utility.showSnackBar(
                      _scaffoldKey, 'Please Fill All Required Field ', context);
                }
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
        child: ListView(children: [
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
                postionAndTemperatureBottomSheet(context, postionList, 0);
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
                postionAndTemperatureBottomSheet(
                    context, globals.tempertureList, 1);
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
              _showSymtomModalSheet();
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
                          fontSize: 17),
                    ),
                  ),
                  Container(
                      width: 150,
                      child: Text(
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
            // child: ListTile(
            //   leading: Text(
            //     "Add Medicine Log",
            //     style: TextStyle(
            //         color: AppTheme.textColor1,
            //         fontFamily: "SF UI Display Regular",
            //         fontSize: globals.deviceType == "phone" ? 17 : 25),
            //   ),
            //   trailing: Icon(
            //     Icons.arrow_forward_ios,
            //     color: AppTheme.arrowIconsColor.withOpacity(0.25),
            //     size: globals.deviceType == 'phone' ? 15 : 23,
            //   ),
            //   selected: true,
            //   onTap: () async {
            //     var medicineModel = await Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => MedicinesPage(
            //                   fromHomePage: false,
            //                 )));

            //                 if(medicineModel != null) {
            //                   medicineList.add(medicineModel);
            //                   ffsd
            //                 }
            //   },
            // ),
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
                print(result);
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
                      addNoteText == '' ? "Add note here" : addNoteText,
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

  // make selected medicine item view
  Widget selectedMedicineWidget(medicineItems, index) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              medicineList.removeAt(index);
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(2),
              alignment: Alignment.center,
              child: Icon(
                Icons.remove,
                size: 16,
                color: Colors.grey,
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 1)),
            ),
          ),
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
          Icon(
            Icons.arrow_forward_ios,
            color: AppTheme.arrowIconsColor.withOpacity(0.25),
            size: globals.deviceType == 'phone' ? 15 : 23,
          ),
        ],
      ),
    );
  }

  // add Medicine Widget
  Widget addMedicineWidget() {
    return ListTile(
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
    );
  }

  postionAndTemperatureBottomSheet(context, obj, int value) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: Theme.of(context).backgroundColor,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: new Wrap(
                children: obj
                    .map<Widget>(
                      (i) => new ListTile(
                        // leading: new Icon(Icons.music_note),UNCOMMENT
                        title: new Text(
                          '$i',
                          style: TextStyle(
                            color: AppTheme.textColor1,
                            fontSize: 17.0,
                            fontFamily: 'SF UI Display Regular',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () => _selectTemp(i, value),
                      ),
                    )
                    .toList()),
          );
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

                                  if (sypmtomsTempList.length < 3) {
                                    sypmtomsTempList.add(data.displayId);
                                    distinctIds =
                                        sypmtomsTempList.toSet().toList();
                                    print(distinctIds);
                                  }
                                });
                              },
                            ),
                            // Container(
                            //   height: 1,
                            //   margin: EdgeInsets.only(left: 40),
                            //   decoration: BoxDecoration(
                            //     color: AppTheme.dividerColor.withOpacity(0.25),
                            //   ),
                            // ),
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
    for (int i = 0; i < checkboxDataList.length; i++) {
      if (checkboxDataList[i].checked) {
        checkboxDataList[i].checked = false;
      }
    }
    setState(() {
      sypmtoms = '';
      sypmtoms = distinctIds != null ? distinctIds.join(', ') : '';
      distinctIds = [];
      sypmtomsTempList = [];
    });
    print('modal closed');
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
