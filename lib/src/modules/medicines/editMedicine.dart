// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hive/hive.dart';
// import 'package:intl/intl.dart';

// import 'package:mobile_app/src/db/db_services.dart';
// import 'package:mobile_app/src/modules/Symptoms/model/symptomsmodel.dart';
// import 'package:mobile_app/src/modules/logs/addnote.dart';
// import 'package:mobile_app/src/modules/medicines/model/medicinemodel.dart';
// import 'package:mobile_app/src/styles/theme.dart';
// import 'package:mobile_app/src/globals.dart' as globals;
// import 'package:mobile_app/src/utilities/strings.dart';
// import 'package:mobile_app/src/utils/utility.dart';
// import 'package:mobile_app/src/widgets/model/button_widget.dart';

// List<String> unitList = ["cc", "g", "mcg", "mg", "ml", "oz"];
// List<String> frequencyList = [
//   "Once per day",
//   "Twice per day",
//   "3 times per day",
//   "4 times per day",
//   "5 times per day",
//   "6 times per day",
//   "As needed"
// ];

// class EditMedicinePage extends StatefulWidget {
//   final int index;
//   final String medicineName;
//   final String dosageName;

//   EditMedicinePage(
//       {Key key,
//       @required this.index,
//       @required this.medicineName,
//       @required this.dosageName})
//       : super(key: key);
//   @override
//   _EditMedicinePageState createState() => _EditMedicinePageState();
// }

// class _EditMedicinePageState extends State<EditMedicinePage> {
//   String dropdownValue = unitList.first;
//   TextEditingController medicineController = TextEditingController();
//   TextEditingController dosageController = TextEditingController();
//   FocusNode dosageFocus = new FocusNode();
//   FocusNode medicineFocus = new FocusNode();

//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     super.initState();
//     medicineController = new TextEditingController(text: widget.medicineName);
//     dosageController = new TextEditingController(text: widget.dosageName);
//     selectedUnit = unitList[0];
//     selectedFrequency = frequencyList[0];
//   }

//   var logsList;
//   getList() async {
//     logsList = await DbServices().getListData(Strings.createSymptoms);

//     setState(() {});
//   }

//   updateMedicineList(index, value) async {
//     bool isSuccess = await DbServices().updateListData(
//       Strings.createMedicineName,
//       index,
//       value,
//     );

//     if (isSuccess != null && isSuccess) {
//       Utility.showSnackBar(
//           _scaffoldKey, 'Symptoms updated successfully', context);
//       Future.delayed(const Duration(seconds: 1), () {
//         Navigator.of(context).pop(1);
//       });
//     }
//   }

//   String selectedUnit = "";
//   String selectedFrequency = "";
//   String addNoteText = '';

//   bool fromHomePage;
//   var distinctIds;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         elevation: 5,
//         backgroundColor: AppTheme.textColor2,
//         centerTitle: true,
//         title: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Edit Medicine',
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
//             Navigator.pop(context, 1);
//           },
//           child: Icon(
//             Icons.close,
//             size: 30.0,
//             color: AppTheme.iconColor,
//           ),
//         ),
//         // actions: [
//         //   Padding(
//         //     padding: const EdgeInsets.only(right: 10),
//         //     child: IconButton(
//         //       onPressed: () {
//         //         if ((symptomsController != null) &&
//         //                 (symptomsController.text.isNotEmpty)
//         //             // &&
//         //             // (symptomsController.text != widget.sysmptomsItem)

//         //             ) {
//         //           String item = symptomsController.text;

//         //           final updateItem = SymptomsModel(item);
//         //           updateSysmptomsList(widget.index, updateItem);
//         //         }
//         //       },
//         //       icon: Icon(
//         //         const IconData(59809, fontFamily: "MaterialIcons"),
//         //         color: AppTheme.iconColor,
//         //         size: 24,
//         //       ),
//         //     ),
//         //   ),
//         // ],
//       ),
//       body:
//           // Container(
//           //   color: AppTheme.subHeadingbackgroundcolor,
//           //   child: Column(children: [
//           //     Container(
//           //       padding: EdgeInsets.only(top: 2, bottom: 2),
//           //       width: MediaQuery.of(context).size.width,
//           //       decoration: BoxDecoration(
//           //         color: AppTheme.subHeadingbackgroundcolor,
//           //         boxShadow: [
//           //           const BoxShadow(
//           //             color: AppTheme.subHeadingbackgroundcolor2,
//           //             spreadRadius: 0,
//           //             blurRadius: 0,
//           //             offset: Offset(0, -0.5),
//           //           ),
//           //         ],
//           //       ),
//           //       child: Padding(
//           //         padding: const EdgeInsets.only(
//           //             left: 20, right: 20, bottom: 30, top: 20),
//           //         child: Form(
//           //           key: _formKey,
//           //           child: TextFormField(
//           //             cursorColor: AppTheme.textColor2,
//           //             autovalidateMode: AutovalidateMode.onUserInteraction,
//           //             controller: medicineController,
//           //             decoration: InputDecoration(
//           //               hintText: 'Enter Symptoms Name',
//           //               focusedBorder: UnderlineInputBorder(
//           //                 borderSide:
//           //                     BorderSide(color: AppTheme.textColor2, width: 1.5),
//           //               ),
//           //               enabledBorder: UnderlineInputBorder(
//           //                 borderSide: BorderSide(
//           //                     color: AppTheme.subHeadingTextColor, width: 1.5),
//           //               ),
//           //               contentPadding:
//           //                   EdgeInsets.only(left: 0, bottom: 8, top: 8, right: 0),
//           //               hintStyle: TextStyle(
//           //                   color: AppTheme.subHeadingTextColor,
//           //                   fontFamily: "SF UI Display Regular",
//           //                   fontSize: globals.deviceType == "phone" ? 16 : 24),
//           //             ),
//           //             validator: (val) {
//           //               if (val.isEmpty) {
//           //                 return 'Please enter symptoms   ';
//           //               } else {
//           //                 return null;
//           //               }
//           //             },
//           //             style: TextStyle(
//           //                 color: AppTheme.contentColor1,
//           //                 fontFamily: "SF UI Display Regular",
//           //                 fontSize: globals.deviceType == "phone" ? 16 : 24),
//           //           ),
//           //         ),
//           //       ),
//           //     ),
//           //     InkWell(
//           //       onTap: () {
//           //         _submit();
//           //       },
//           //       child: Padding(
//           //         padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
//           //         child: new Container(
//           //           padding: const EdgeInsets.all(16),
//           //           alignment: Alignment.center,
//           //           color: Theme.of(context).primaryColor,
//           //           child: new Column(
//           //               mainAxisAlignment: MainAxisAlignment.center,
//           //               children: [
//           //                 new Text(
//           //                   "Update Medicine",
//           //                   style: TextStyle(
//           //                     fontWeight: FontWeight.bold,
//           //                     fontFamily: "SF UI Display",
//           //                     color: Colors.white,
//           //                     fontSize: globals.deviceType == "phone" ? 17 : 25,
//           //                   ),
//           //                 )
//           //               ]),
//           //         ),
//           //       ),
//           //     ),
//           //   ]),
//           // ),
//           ListView(children: [
//         Container(
//           color: Theme.of(context).backgroundColor,
//           child: Form(
//             key: _formKey,
//             child: Column(children: [
//               Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     color: AppTheme.subHeadingbackgroundcolor,
//                     boxShadow: [
//                       const BoxShadow(
//                         color: AppTheme.subHeadingbackgroundcolor2,
//                         spreadRadius: 0,
//                         blurRadius: 0,
//                         offset: Offset(0, -0.5),
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 20, right: 20, bottom: 30, top: 20),
//                     child: TextFormField(
//                       cursorColor: AppTheme.textColor2,
//                       focusNode: medicineFocus,
//                       controller: medicineController,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       inputFormatters: [
//                         //Only letters are allowed
//                         FilteringTextInputFormatter.allow(
//                             RegExp("[a-zA-Z_\\s-]")),
//                       ],
//                       validator: (val) {
//                         if (val.isEmpty) {
//                           return 'Medicine name is required   ';
//                         } else {
//                           return null;
//                         }
//                       },
//                       // onSaved: (val) => _username = val,

//                       style: TextStyle(
//                         color: AppTheme.textColor1,
//                         fontFamily: 'SF UI Display Bold',
//                         fontSize: globals.deviceType == "phone" ? 16.0 : 24,
//                       ),
//                       decoration: InputDecoration(
//                         labelText: 'Enter Medicine Name',
//                         labelStyle: TextStyle(
//                           fontSize: globals.deviceType == "phone" ? 16.0 : 24,
//                           fontFamily: 'SF UI Display Bold',
//                           color: AppTheme.textColor1,
//                         ),
//                         // contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                         focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                               color: AppTheme.textColor2, width: 1.5),
//                         ),
//                         enabledBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                               color: AppTheme.subHeadingTextColor, width: 1.5),
//                         ),
//                       ),
//                     ),
//                   )),
//               Container(
//                 padding:
//                     EdgeInsets.only(top: 2.5, bottom: 2.5, left: 16, right: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       flex: 0,
//                       child: Text(
//                         "Dosage",
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                             color: AppTheme.textColor1,
//                             fontFamily: "SF UI Display Regular Bold",
//                             fontSize: globals.deviceType == "phone" ? 17 : 25),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 209,
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: TextField(
//                         textAlign: TextAlign.end,
//                         controller: dosageController,
//                         focusNode: dosageFocus,
//                         keyboardType:
//                             TextInputType.numberWithOptions(decimal: true),
//                         decoration: InputDecoration(
//                           hintText: '1',

//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: AppTheme.textColor2, width: 1),
//                           ),
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: AppTheme.subtitleTextColor, width: 1),
//                           ),
//                           // errorBorder: InputBorder.none,
//                           // disabledBorder: InputBorder.none,
                        
//                           hintStyle: TextStyle(
//                               color: AppTheme.subHeadingTextColor,
//                               fontFamily: "SF UI Display Regular",
//                               fontSize:
                              
//                                   globals.deviceType == "phone" ? 16 : 24),
//                         ),
//                         style: TextStyle(
//                             color: AppTheme.textColor2,
//                             fontFamily: "SF UI Display Regular",
//                             fontSize: globals.deviceType == "phone" ? 16 : 24),
//                       ),
//                     ),

//                     SizedBox(
//                       width: 10,
//                     ),
//                     // Expanded(
//                     //   flex: 0,
//                     //   child: Padding(
//                     //     padding: const EdgeInsets.only(top: 02),
//                     //     child: Text(
//                     //       "${selectedUnit}",
//                     //       style: TextStyle(
//                     //         color: AppTheme.textColor2,
//                     //         fontFamily: "SF UI Display Regular",
//                     //         fontSize: globals.deviceType == "phone" ? 15 : 23,
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
//                     Expanded(
//                       flex: 5,
//                       child: DropdownButton<String>(
//                         value: dropdownValue,
//                         icon: const Icon(Icons.arrow_drop_down),
//                         // elevation: 0,
//                         style: const TextStyle(color: AppTheme.textColor2),
//                         onChanged: (String value) {
//                           // This is called when the user selects an item.
//                           setState(() {
//                             dropdownValue = value;
//                             print(dropdownValue);
//                           });
//                         },
//                         items: unitList
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.only(right: 70),
//               //   child: Align(
//               //     alignment: Alignment.topRight,
//               //     child: Container(
//               //       height: 2,
//               //       width: 30,
//               //       color: AppTheme.textColor2,
//               //     ),
//               //   ),
//               // ),
//               SizedBox(
//                 height: 10,
//               ),

//               Container(
//                 height: 1,
//                 margin: EdgeInsets.only(left: 20),
//                 decoration: BoxDecoration(
//                   color: AppTheme.dividerColor.withOpacity(0.25),
//                 ),
//               ),
//               // Container(
//               //   padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
//               //   child: ListTile(
//               //     leading: Text(
//               //       "Unit",
//               //       textAlign: TextAlign.center,
//               //       style: TextStyle(
//               //           color: AppTheme.textColor1,
//               //           fontFamily: "SF UI Display Regular Bold",
//               //           fontSize: globals.deviceType == "phone" ? 17 : 25),
//               //     ),
//               //     trailing: Wrap(
//               //       alignment: WrapAlignment.center,
//               //       children: <Widget>[
//               //         Text(
//               //           "$selectedUnit",
//               //           style: TextStyle(
//               //               color: AppTheme.textColor2,
//               //               fontFamily: "SF UI Display Regular",
//               //               fontSize: globals.deviceType == "phone" ? 17 : 25),
//               //         ),
//               //         SizedBox(
//               //           width: 10,
//               //         ),
//               //         Padding(
//               //           padding: const EdgeInsets.only(top: 02),
//               //           child: Icon(
//               //             Icons.arrow_forward_ios,
//               //             color: AppTheme.arrowIconsColor.withOpacity(0.2),
//               //             size: globals.deviceType == 'phone' ? 15 : 23,
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //     selected: true,
//               //     onTap: () {
//               //       dosageFocus.unfocus();
//               //       medicineFocus.unfocus();
//               //       _settingModalBottomSheet(context, unitList, 0);
//               //     },
//               //   ),
//               // ),
//               Container(
//                 height: 1,
//                 margin: EdgeInsets.only(left: 20),
//                 decoration: BoxDecoration(
//                   color: AppTheme.dividerColor.withOpacity(0.25),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
//                 child: ListTile(
//                   leading: Text(
//                     "Frequency",
//                     style: TextStyle(
//                         color: AppTheme.textColor1,
//                         fontFamily: "SF UI Display Regular",
//                         fontSize: globals.deviceType == "phone" ? 17 : 25),
//                   ),
//                   trailing: Wrap(
//                     alignment: WrapAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         "$selectedFrequency",
//                         style: TextStyle(
//                             color: AppTheme.textColor2,
//                             fontFamily: "SF UI Display Regular",
//                             fontSize: globals.deviceType == "phone" ? 17 : 25),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           top: 02,
//                         ),
//                         child: Icon(
//                           Icons.arrow_forward_ios,
//                           color: AppTheme.arrowIconsColor.withOpacity(0.25),
//                           size: 15,
//                         ),
//                       ),
//                     ],
//                   ),
//                   selected: true,
//                   onTap: () {
//                     dosageFocus.unfocus();
//                     medicineFocus.unfocus();
//                     _settingModalBottomSheet(context, frequencyList, 1);
//                   },
//                 ),
//               ),
//               // Container(
//               //   height: 1,
//               //   margin: EdgeInsets.only(left: 20),
//               //   decoration: BoxDecoration(
//               //     color: AppTheme.dividerColor.withOpacity(0.25),
//               //   ),
//               // ),
//               Container(
//                 padding: EdgeInsets.only(top: 10, bottom: 10),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: AppTheme.subHeadingbackgroundcolor,
//                   boxShadow: [
//                     const BoxShadow(
//                       color: AppTheme.subHeadingbackgroundcolor2,
//                       spreadRadius: 0,
//                       blurRadius: 0,
//                       offset: Offset(0, -0.5),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
//                   child: Text(
//                     "Note",
//                     style: TextStyle(
//                         color: AppTheme.subHeadingTextColor,
//                         fontFamily: "SF UI Display Regular",
//                         fontSize: globals.deviceType == "phone" ? 14 : 21),
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () async {
//                   dosageFocus.unfocus();
//                   medicineFocus.unfocus();
//                   var result = await Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => AddNote()),
//                   );
//                   setState(() {
//                     addNoteText = result;
//                   });
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           addNoteText == ''
//                               ? "Add Personal Notes Here"
//                               : addNoteText,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                           style: TextStyle(
//                               color: AppTheme.textColor1,
//                               fontFamily: "SF UI Display Regular",
//                               fontSize:
//                                   globals.deviceType == "phone" ? 17 : 25),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           top: 02,
//                         ),
//                         child: Icon(
//                           Icons.arrow_forward_ios,
//                           color: AppTheme.arrowIconsColor.withOpacity(0.25),
//                           size: 15,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: AppTheme.subHeadingbackgroundcolor,
//                   boxShadow: [
//                     const BoxShadow(
//                       color: AppTheme.subHeadingbackgroundcolor2,
//                       spreadRadius: 0,
//                       blurRadius: 0,
//                       offset: Offset(0, -0.5),
//                     ),
//                   ],
//                 ),
//                 child: GestureDetector(
//                   onTap: () {
//                     _submit();
//                   },
//                   child: buttonWidget(context, "Add Medicine"),
//                   // Padding(
//                   //   padding:
//                   //       const EdgeInsets.only(left: 20, right: 20, top: 100),
//                   //   child: new Container(
//                   //     padding: const EdgeInsets.all(16),
//                   //     alignment: Alignment.center,
//                   //     color: Theme.of(context).primaryColor,
//                   //     child: new Column(
//                   //         mainAxisAlignment: MainAxisAlignment.center,
//                   //         children: [
//                   //           new Text(
//                   //             "Add Medicine",
//                   //             style: TextStyle(
//                   //               fontWeight: FontWeight.bold,
//                   //               fontFamily: "SF UI Display",
//                   //               color: Colors.white,
//                   //               fontSize:
//                   //                   globals.deviceType == "phone" ? 17 : 25,
//                   //             ),
//                   //           )
//                   //         ]),
//                   //   ),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       ]),
//     );
//   }

//   void _submit() {
//     final form = _formKey.currentState;

//     if (form.validate()) {
//       if ((medicineController != null) &&
//               (medicineController.text.isNotEmpty) &&
//               ((dosageController != null) && dosageController.text.isNotEmpty)
//           // &&
//           // (symptomsController.text != widget.sysmptomsItem)

//           ) {
//         String medicineItem = medicineController.text;
//         String dosage = dosageController.text;

//         final updateItem = MedicineModel(
//             medicineItem, dosage, selectedUnit, selectedFrequency, addNoteText);
//         updateMedicineList(widget.index, updateItem);
//       }

//       form.save();
//     }
//   }

//   _settingModalBottomSheet(context, obj, int value) {
//     showModalBottomSheet(
//         context: context,
//         isDismissible: true,
//         enableDrag: true,
//         backgroundColor: Color(0xffffffff),
//         builder: (BuildContext bc) {
//           return SingleChildScrollView(
//             child: new Wrap(
//                 children: obj
//                     .map<Widget>((i) => new ListTile(
//                           title: new Text(
//                             '$i',
//                             style: TextStyle(
//                               color: Color(0xff463DC7),
//                               fontSize:
//                                   globals.deviceType == 'phone' ? 17.0 : 25.0,
//                               fontFamily: 'SF UI Display Regular',
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                           onTap: () => _selectValue(i, value),
//                         ))
//                     .toList()),
//           );
//         });
//   }

//   void _selectValue(String t, int value) {
//     Navigator.pop(context);
//     setState(() {
//       if (value == 1) {
//         selectedFrequency = t;
//       } else {
//         selectedUnit = t;
//       }
//     });
//   }
// }
