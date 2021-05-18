import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/modules/logs/addnote.dart';
import 'package:mobile_app/src/modules/medicines/model/medicinemodel.dart';
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';

List<String> frequencyList = [
  "Once per day",
  "Twice per day",
  "3 times per day",
  "4 times per day",
  "6 times per day",
  "As needed"
];

List<String> unitList = ["cc", "g", "mcg", "mg", "ml", "oz"];

class AddMedicine extends StatefulWidget {
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  String selectedUnit = "";
  String selectedFrequency = "";
  String addNoteText = '';
  TextEditingController medicineController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  FocusNode dosageFocus = new FocusNode();
  FocusNode medicineFocus = new FocusNode();

  var distinctIds;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    selectedUnit = unitList[0];
    selectedFrequency = frequencyList[0];
  }

  void addMedicine(MedicineModel log) async {
    bool isSuccess =
        await DbServices().addData(log, Strings.createMedicineName);

    if (isSuccess != null && isSuccess) {
      Utility.showSnackBar(_scaffoldKey, 'Data Added Successfully', context);
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop(true);
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
              'Add Medicine',
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
                String medicineName = medicineController.text;
                String dosage = dosageController.text;
                if (medicineName != null &&
                    medicineName.isNotEmpty &&
                    dosage != null &&
                    dosage.isNotEmpty) {
                  final medicineModel = MedicineModel(
                      medicineName,
                      '${dosage} $selectedUnit',
                      selectedUnit,
                      selectedFrequency,
                      addNoteText);
                  addMedicine(medicineModel);
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
      body: ListView(children: [
        Container(
          color: Theme.of(context).backgroundColor,
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(top: 2, bottom: 2),
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
                child: TextField(
                  focusNode: medicineFocus,
                  controller: medicineController,
                  decoration: InputDecoration(
                    hintText: 'Enter Medicine Name',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 0, bottom: 8, top: 8, right: 0),
                    hintStyle: TextStyle(
                        color: AppTheme.subHeadingTextColor,
                        fontFamily: "SF UI Display Regular",
                        fontSize: globals.deviceType == "phone" ? 16 : 24),
                  ),
                  style: TextStyle(
                      color: AppTheme.contentColor1,
                      fontFamily: "SF UI Display Regular",
                      fontSize: globals.deviceType == "phone" ? 16 : 24),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 2.5, bottom: 2.5, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 0,
                    child: Text(
                      "Dosage",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: AppTheme.textColor1,
                          fontFamily: "SF UI Display Regular Bold",
                          fontSize: globals.deviceType == "phone" ? 17 : 25),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      textAlign: TextAlign.end,
                      controller: dosageController,
                      focusNode: dosageFocus,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: '0',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 0, bottom: 8, top: 8, right: 0),
                        hintStyle: TextStyle(
                            color: AppTheme.subHeadingTextColor,
                            fontFamily: "SF UI Display Regular",
                            fontSize: globals.deviceType == "phone" ? 16 : 24),
                      ),
                      style: TextStyle(
                          color: AppTheme.textColor2,
                          fontFamily: "SF UI Display Regular",
                          fontSize: globals.deviceType == "phone" ? 16 : 24),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 02),
                      child: Text(
                        "${selectedUnit}",
                        style: TextStyle(
                          color: AppTheme.textColor2,
                          fontFamily: "SF UI Display Regular",
                          fontSize: globals.deviceType == "phone" ? 15 : 23,
                        ),
                      ),
                    ),
                  )
                ],
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
                  "Unit",
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
                      "$selectedUnit",
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
                  dosageFocus.unfocus();
                  medicineFocus.unfocus();
                  _settingModalBottomSheet(context, unitList, 0);
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
                  "Frequency",
                  style: TextStyle(
                      color: AppTheme.textColor1,
                      fontFamily: "SF UI Display Regular",
                      fontSize: globals.deviceType == "phone" ? 17 : 25),
                ),
                trailing: Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    Text(
                      "$selectedFrequency",
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
                  dosageFocus.unfocus();
                  medicineFocus.unfocus();
                  _settingModalBottomSheet(context, frequencyList, 1);
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
                dosageFocus.unfocus();
                medicineFocus.unfocus();
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNote()),
                );
                setState(() {
                  addNoteText = result;
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
            Container(
              height: 1,
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: AppTheme.dividerColor.withOpacity(0.25),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  _settingModalBottomSheet(context, obj, int value) {
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
                          title: new Text(
                            '$i',
                            style: TextStyle(
                              color: Color(0xff463DC7),
                              fontSize:
                                  globals.deviceType == 'phone' ? 17.0 : 25.0,
                              fontFamily: 'SF UI Display Regular',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          onTap: () => _selectValue(i, value),
                        ))
                    .toList()),
          );
        });
  }

  void _selectValue(String t, int value) {
    Navigator.pop(context);
    setState(() {
      if (value == 1) {
        selectedFrequency = t;
      } else {
        selectedUnit = t;
      }
    });
  }
}
