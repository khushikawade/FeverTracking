import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/modules/logs/addnote.dart';
import 'package:mobile_app/src/modules/medicines/model/medicinemodel.dart';
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';
import 'package:mobile_app/src/widgets/model/button_widget.dart';

List<String> frequencyList = [
  "Once per day",
  "Twice per day",
  "3 times per day",
  "4 times per day",
  "5 times per day",
  "6 times per day",
  "As needed"
];

List<String> unitList = ["cc", "g", "mcg", "mg", "ml", "oz"];
List<String> dosageList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

class AddMedicine extends StatefulWidget {
  final String text;
  final String medicineItem;
  final String medicineUnit;
  final String medicineFrequency;
  final String dosage;
  final int index;

  AddMedicine({
    Key key,
    @required this.text,
    @required this.medicineItem,
    @required this.medicineUnit,
    @required this.medicineFrequency,
    @required this.dosage,
    @required this.index,
  }) : super(key: key);
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  String dropdownValue = unitList.first;
  String selectedUnit = "";
  String selectedFrequency = "";
  String addNoteText = '';
  String selectedDosage = "";

  TextEditingController medicineController = TextEditingController();
  // TextEditingController dosageController = TextEditingController();
  FocusNode dosageFocus = new FocusNode();
  FocusNode medicineFocus = new FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var distinctIds;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (widget.text == "edit") {
      medicineController = new TextEditingController(text: widget.medicineItem);
      selectedUnit = widget.medicineUnit;
      selectedFrequency = widget.medicineFrequency;
      selectedDosage = widget.dosage;
      // dosageController = new TextEditingController(text: widget.dosage);
    } else {
      selectedUnit = unitList[0];

      selectedFrequency = frequencyList[0];
      selectedDosage = dosageList[0];
    }
  }

  var logsList;
  getList() async {
    logsList = await DbServices().getListData(Strings.createMedicineName);

    // setState(() {});
  }

  void addMedicine(MedicineModel log) async {
    bool isSuccess =
        await DbServices().addData(log, Strings.createMedicineName);

    if (isSuccess != null && isSuccess) {
      Utility.showSnackBar(
          _scaffoldKey, 'Medicine added successfully', context);
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop(true);
      });
    }
  }

  updateMedicineList(index, value) async {
    bool isSuccess = await DbServices().updateListData(
      Strings.createMedicineName,
      index,
      value,
    );

    if (isSuccess != null && isSuccess) {
      Utility.showSnackBar(
          _scaffoldKey, 'Medicine updated successfully', context);

      Future.delayed(const Duration(seconds: 1), () {
        // Navigator.of(context).pop(1);
        // Navigator.of(context).pop();
        Navigator.of(context).pop(true);
        // Navigator.pop(context, true);
      });
      // setState(() {});
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
      backgroundColor: AppTheme.subHeadingbackgroundcolor,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Color(0xff463DC7),
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.text == "edit" ? 'Edit Medicine' : 'Add Medicine',
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
            getList();
          },
          child: Icon(
            Icons.close,
            size: 30.0,
            color: AppTheme.iconColor,
          ),
        ),
      ),
      body: ListView(children: [
        Container(
          color: Theme.of(context).backgroundColor,
          child: Form(
            key: _formKey,
            child: Column(children: [
              Container(
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
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 30, top: 20),
                    child: TextFormField(
                      cursorColor: AppTheme.textColor2,
                      focusNode: medicineFocus,
                      controller: medicineController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                        //Only letters are allowed
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z_\\s-]")),
                      ],
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Medicine name is required   ';
                        } else {
                          return null;
                        }
                      },
                      // onSaved: (val) => _username = val,

                      style: TextStyle(
                        color: AppTheme.textColor1,
                        fontFamily: 'SF UI Display Bold',
                        fontSize: globals.deviceType == "phone" ? 16.0 : 24,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Enter Medicine Name',
                        labelStyle: TextStyle(
                          fontSize: globals.deviceType == "phone" ? 16.0 : 24,
                          fontFamily: 'SF UI Display Bold',
                          color: AppTheme.textColor1,
                        ),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.textColor2, width: 1.5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.subHeadingTextColor, width: 1.5),
                        ),
                      ),
                    ),
                  )),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: AppTheme.dividerColor.withOpacity(0.25),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
                child: ListTile(
                  leading: Text(
                    "Dosage",
                    style: TextStyle(
                        color: AppTheme.textColor1,
                        fontFamily: "SF UI Display Regular",
                        fontSize: globals.deviceType == "phone" ? 17 : 25),
                  ),
                  trailing: DropdownButton<String>(
                    menuMaxHeight: 200,
                    isDense: true,
                    value: selectedDosage,
                    icon: const Icon(Icons.arrow_drop_down),
                    // elevation: 0,
                    style: const TextStyle(color: AppTheme.textColor2),
                    onChanged: (String value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedDosage = value;
                        print(selectedDosage);
                      });
                    },
                    items: dosageList
                        .map<DropdownMenuItem<String>>((String selectedDosage) {
                      return DropdownMenuItem<String>(
                        value: selectedDosage,
                        child: Text(selectedDosage),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: AppTheme.dividerColor.withOpacity(0.25),
                ),
              ),
              Container(
                child: ListTile(
                  leading: Text(
                    "Unit",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: AppTheme.textColor1,
                        fontFamily: "SF UI Display Regular Bold",
                        fontSize: globals.deviceType == "phone" ? 17 : 25),
                  ),
                  trailing: DropdownButton<String>(
                    value: selectedUnit,
                    icon: const Icon(Icons.arrow_drop_down),
                    // elevation: 0,
                    style: const TextStyle(color: AppTheme.textColor2),
                    onChanged: (String value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedUnit = value;
                        print(selectedUnit);
                      });
                    },
                    items: unitList
                        .map<DropdownMenuItem<String>>((String selectedUnit) {
                      return DropdownMenuItem<String>(
                        value: selectedUnit,
                        child: Text(selectedUnit),
                      );
                    }).toList(),
                  ),
                ),

                // SizedBox(
                //   width: 209,
                // ),
                // Expanded(
                //   flex: 3,
                //   child: TextField(
                //     maxLength: 1,
                //     textAlign: TextAlign.end,
                //     controller: dosageController,
                //     focusNode: dosageFocus,
                //     keyboardType:
                //         TextInputType.numberWithOptions(decimal: true),
                //     decoration: InputDecoration(
                //       hintText: '1',
                //       counterText: '',
                //       focusedBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //             color: AppTheme.textColor2, width: 1),
                //       ),
                //       enabledBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //             color: AppTheme.subtitleTextColor, width: 1),
                //       ),
                //       // errorBorder: InputBorder.none,
                //       // disabledBorder: InputBorder.none,
                //       contentPadding: EdgeInsets.only(
                //           left: 0, bottom: 0, top: 0, right: 0),
                //       hintStyle: TextStyle(
                //           color: AppTheme.subHeadingTextColor,
                //           fontFamily: "SF UI Display Regular",
                //           fontSize:
                //               globals.deviceType == "phone" ? 16 : 24),
                //     ),
                //     style: TextStyle(
                //         color: AppTheme.textColor2,
                //         fontFamily: "SF UI Display Regular",
                //         fontSize: globals.deviceType == "phone" ? 16 : 24),
                //   ),
                // ),

                // SizedBox(
                //   width: 10,
                // ),
                // Expanded(
                //   flex: 0,
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 02),
                //     child: Text(
                //       "${selectedUnit}",
                //       style: TextStyle(
                //         color: AppTheme.textColor2,
                //         fontFamily: "SF UI Display Regular",
                //         fontSize: globals.deviceType == "phone" ? 15 : 23,
                //       ),
                //     ),
                //   ),
                // ),
                // Expanded(
                //   flex: 5,
                //   child: DropdownButton<String>(
                //     value: selectedUnit,
                //     icon: const Icon(Icons.arrow_drop_down),
                //     // elevation: 0,
                //     style: const TextStyle(color: AppTheme.textColor2),
                //     onChanged: (String value) {
                //       // This is called when the user selects an item.
                //       setState(() {
                //         selectedUnit = value;
                //         print(selectedUnit);
                //       });
                //     },
                //     items: unitList.map<DropdownMenuItem<String>>(
                //         (String selectedUnit) {
                //       return DropdownMenuItem<String>(
                //         value: selectedUnit,
                //         child: Text(selectedUnit),
                //       );
                //     }).toList(),
                //   ),
                // )
                //   ],
                // ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 70),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: Container(
              //       height: 2,
              //       width: 30,
              //       color: AppTheme.textColor2,
              //     ),
              //   ),
              // ),

              // Container(
              //   height: 1,
              //   margin: EdgeInsets.only(left: 20),
              //   decoration: BoxDecoration(
              //     color: AppTheme.dividerColor.withOpacity(0.25),
              //   ),
              // ),
              // Container(
              //   padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
              //   child: ListTile(
              //     leading: Text(
              //       "Unit",
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //           color: AppTheme.textColor1,
              //           fontFamily: "SF UI Display Regular Bold",
              //           fontSize: globals.deviceType == "phone" ? 17 : 25),
              //     ),
              //     trailing: Wrap(
              //       alignment: WrapAlignment.center,
              //       children: <Widget>[
              //         Text(
              //           "$selectedUnit",
              //           style: TextStyle(
              //               color: AppTheme.textColor2,
              //               fontFamily: "SF UI Display Regular",
              //               fontSize: globals.deviceType == "phone" ? 17 : 25),
              //         ),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(top: 02),
              //           child: Icon(
              //             Icons.arrow_forward_ios,
              //             color: AppTheme.arrowIconsColor.withOpacity(0.2),
              //             size: globals.deviceType == 'phone' ? 15 : 23,
              //           ),
              //         ),
              //       ],
              //     ),
              //     selected: true,
              //     onTap: () {
              //       dosageFocus.unfocus();
              //       medicineFocus.unfocus();
              //       _settingModalBottomSheet(context, unitList, 0);
              //     },
              //   ),
              // ),

              Container(
                height: 1,
                margin: EdgeInsets.only(left: 10, right: 10),
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
              // Container(
              //   height: 1,
              //   margin: EdgeInsets.only(left: 20),
              //   decoration: BoxDecoration(
              //     color: AppTheme.dividerColor.withOpacity(0.25),
              //   ),
              // ),
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
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                  child: Text(
                    "Note",
                    style: TextStyle(
                        color: AppTheme.subHeadingTextColor,
                        fontFamily: "SF UI Display Regular",
                        fontSize: globals.deviceType == "phone" ? 14 : 21),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  dosageFocus.unfocus();
                  medicineFocus.unfocus();
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNote(
                              notetext:
                                  addNoteText.isNotEmpty ? addNoteText : '',
                            )),
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
                          addNoteText == ''
                              ? "Add Personal Notes Here"
                              : addNoteText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: AppTheme.textColor1,
                              fontFamily: "SF UI Display Regular",
                              fontSize:
                                  globals.deviceType == "phone" ? 17 : 25),
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
                child: GestureDetector(
                    onTap: () {
                      // _submit();
                      _submit();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: buttonWidget(
                        context,
                        widget.text == "edit"
                            ? "Edit Medicine"
                            : "Add Medicine",
                      ),
                    )
                    // child: Padding(
                    //   padding:
                    //       const EdgeInsets.only(left: 20, right: 20, top: 100),
                    //   child: new Container(
                    //     padding: const EdgeInsets.all(16),
                    //     alignment: Alignment.center,
                    //     color: Theme.of(context).primaryColor,
                    //     child: new Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           new Text(
                    //             widget.text == "edit"
                    //                 ? "Edit Medicine"
                    //                 : "Add Medicine",
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontFamily: "SF UI Display",
                    //               color: Colors.white,
                    //               fontSize:
                    //                   globals.deviceType == "phone" ? 17 : 25,
                    //             ),
                    //           )
                    //         ]),
                    //   ),
                    // ),
                    ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      String medicineName = medicineController.text;

      if (widget.text == "edit") {
        final updateItem = MedicineModel(medicineName, selectedDosage,
            selectedUnit, selectedFrequency, addNoteText);
        updateMedicineList(widget.index, updateItem);
      } else {
        if (medicineName != null && medicineName.isNotEmpty) {
          final medicineModel = MedicineModel(medicineName, selectedDosage,
              selectedUnit, selectedFrequency, addNoteText);
          addMedicine(medicineModel);
        } else {
          Utility.showSnackBar(
              _scaffoldKey, 'Please Fill All Required Field ', context);
        }
      }

      form.save();
    }

    void _submit1(index) {
      final form = _formKey.currentState;
      // String dosage = dosageController.text;
      if (form.validate()) {
        if ((medicineController != null) && (medicineController.text.isNotEmpty)
            // &&
            // (symptomsController.text != widget.sysmptomsItem)

            ) {
          String item = medicineController.text;

          final updateItem = MedicineModel(item, selectedDosage, selectedUnit,
              selectedFrequency, addNoteText);
          updateMedicineList(index, updateItem);
        }

        form.save();
      }
    }
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
