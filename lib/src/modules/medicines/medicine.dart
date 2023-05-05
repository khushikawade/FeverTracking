import 'package:flutter/material.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/Symptoms/editsymptoms.dart';
import 'package:mobile_app/src/modules/medicines/add_medicine.dart';
import 'package:mobile_app/src/modules/medicines/editMedicine.dart';
import 'package:mobile_app/src/modules/medicines/model/medicinemodel.dart';
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';
import 'package:mobile_app/src/widgets/add_to_log.dart';
import 'package:mobile_app/src/widgets/loaderWidget.dart';
import 'package:mobile_app/src/widgets/skip_button.dart';

class MedicinesPage extends StatefulWidget {
  bool fromHomePage;
  bool deleteMedicine;

  MedicinesPage({Key key, this.fromHomePage, this.deleteMedicine = false})
      : super(key: key);
  // MedicinesPage({
  //   Key key,
  //   this.fromHomePage,
  // }) : super(key: key);
  @override
  _MedicinesPageState createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  Future<bool> deleteMedicine(index) async {
    bool isSuccess =
        await DbServices().deleteData(Strings.createMedicineName, index);
    if (isSuccess != null && isSuccess) {
      Utility.showSnackBar(
          _scaffoldKey, 'Medicine deleted successfully', context);

      setState(() {
        widget.deleteMedicine = false;
      });
    }
    return isSuccess;
  }

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: widget.fromHomePage != null && widget.fromHomePage
            ? null
            : AppBar(
                elevation: 5,
                backgroundColor: Theme.of(context).primaryColor,
                centerTitle: true,
                title: Text(
                  'Medicines',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppTheme.titleColor,
                      letterSpacing: 0,
                      fontSize: globals.deviceType == 'phone' ? 20 : 28,
                      fontFamily: 'SF UI Display Semibold',
                      fontWeight: FontWeight.w600),
                ),
              ),
        backgroundColor: AppTheme.screenbackGroundColor,
        body: makeWidget(),
        floatingActionButton: GestureDetector(
          onTap: () async {
            bool result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddMedicine()));

            if (result != null && result) {
              setState(() {});
            }
          },
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
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
        ));
  }

  // make logs scrren list
  Widget makeWidget() {
    return FutureBuilder(
        future: DbServices().getListData(Strings.createMedicineName),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data != null && snapshot.data.length > 0
                ? ListView.separated(
                    separatorBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        height: 0.6,
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                      );
                    },
                    padding: EdgeInsets.only(top: 10, bottom: 100),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return itemWidget1(index, snapshot.data, context);
                    },
                  )
                : Center(
                    child: Text(
                      'No Medicines Found!!',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textColor1,
                          fontFamily: "SF UI Display Regular",
                          fontSize: globals.deviceType == 'phone' ? 17 : 25),
                    ),
                  );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomLoader();
          } else
            return Scaffold();
        });
    // return logsList != null && logsList.length > 0
    //     ? ListView.builder(
    //         padding: EdgeInsets.only(top: 10),
    //         itemCount: logsList.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return itemWidget(index, logsList);
    //         },
    //       )
    //     : Center(
    //         child: Text(
    //           '',
    //           style: TextStyle(
    //               fontWeight: FontWeight.w600,
    //               color: AppTheme.textColor1,
    //               fontFamily: "SF UI Display Regular",
    //               fontSize: globals.deviceType == 'phone' ? 17 : 25),
    //         ),
    //       );
  }

  Widget itemWidget1(int index, items, context) {
    return Container(
      color: AppTheme.listbackGroundColor,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ListTile(
          leading: Container(
            child: Icon(
              const IconData(0xe814, fontFamily: 'FeverTrackingIcons'),
              color: AppTheme.iconsColor,
              size: 45,
            ),
          ),
          title: Text(
            items[index].medicineName != null &&
                    items[index].medicineName.isNotEmpty
                ? items[index].medicineName
                : '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 0,
                color: AppTheme.textColor1,
                fontFamily: "SF UI Display Bold",
                fontSize: globals.deviceType == 'phone' ? 17 : 25),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              items[index].medicineFrequency != null &&
                      items[index].medicineFrequency.isNotEmpty
                  ? items[index].medicineFrequency
                  : '',
              style: TextStyle(
                  color: AppTheme.listSubtitleColor,
                  letterSpacing: 0,
                  fontFamily: "SF UI Display ",
                  fontSize: globals.deviceType == "phone" ? 15 : 23),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.fromHomePage
                  ? Container()
                  : addToLogButton(
                      widget.fromHomePage, _scaffoldKey, index, items, context),
              SizedBox(
                width: 10,
              ),
              // InkWell(
              //   onTap: () async {
              //     // {
              //     //   print(items.length);
              //     //   var get = await Navigator.push(
              //     //       context,
              //     //       MaterialPageRoute(
              //     //           builder: (context) => EditMedicinePage(
              //     //                 medicineItem: items[index].medicineName,
              //     //                 index: index,
              //     //               )));

              //     //   setState(() {});
              //     // }
              //   },
              //   child: Icon(
              //     const IconData(0xe802, fontFamily: "FeverTrackingIcons"),
              //     // color:AppTheme.iconColor,
              //     color: Colors.black54,
              //     size: 24,
              //   ),
              // ),
              SizedBox(
                width: 10,
              ),
              iconWidget(index, items, context),
            ],
          ),
          selected: true,
          // onTap: () {
          //   widget.fromHomePage
          //       ? print("fromhomepage")
          //       : Future.delayed(const Duration(seconds: 0), () {
          //           Utility.showSnackBar(_scaffoldKey,
          //               'Medicine successfully added to log', context);
          //           Future.delayed(const Duration(seconds: 2), () {
          //             Navigator.of(context).pop(items[index]);
          //           });
          //         });
          //   //
          // },
        ),
        index == items.length - 1
            ? Container(
                height: 1,
                color: Color.fromRGBO(0, 0, 0, 0.25),
              )
            : Container()
      ]),
    );
  }

  Widget iconWidget(int index, items, context) {
    {
      return
          // popup menu button

          PopupMenuButton<int>(
        position: PopupMenuPosition.under,
        constraints: BoxConstraints.expand(width: 130, height: 100),
        // padding: EdgeInsets.only(left: 50, right: 50),
        offset: Offset(100, 15),

        color: AppTheme.subHeadingbackgroundcolor,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              // color: const Color(0xff334155),
              border: Border.all(
                color: AppTheme.subHeadingbackgroundcolor2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: Center(
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.more_vert,
                  color: AppTheme.subHeadingbackgroundcolor2,
                )),
          ),
        ),
        itemBuilder: (context) => [
          // popupmenu item 1
          PopupMenuItem(
              onTap: () {
                WidgetsBinding.instance?.addPostFrameCallback((_) async {
                  // Write your code here

                  bool result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddMedicine(
                                text: "edit",
                                index: index,
                                dosage: items[index].dosage,
                                medicineFrequency:
                                    items[index].medicineFrequency,
                                medicineItem: items[index].medicineName,
                                medicineUnit: items[index].medicineUnit,
                              )));

                  if (result != null && result) {
                    print(result);
                    setState(() {});
                    //getList();
                  }

                  if (globals.medicineNameList.isNotEmpty) {
                    for (int i = 0; i < globals.medicineNameList.length; i++) {
                      print(globals.medicineNameList);
                    }
                  }
                  // setState(() {});
                });

                // WidgetsBinding.instance
                //     .addPostFrameCallback((_) => Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) {
                //               return AddMedicine(
                //                 medicineItem: items[index].medicineName,
                //                 text: "edit",
                //                 index: index,
                //               );
                //             },
                //           ),
                //         ));

                // bool result = await Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => AddMedicine(
                //               medicineItem: items[index].medicineName,
                //               text: "edit",
                //               index: index,
                //             )));

                // if (result != null && result) {
                //   print("kjljljljljljljljljljljljljljljljljljl");
                //   print(result);
                //   setState(() {});
                //   //getList();
                // }

                // WidgetsBinding.instance.addPostFrameCallback((_) {});
                // bool result = await Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => AddMedicine(
                //               medicineItem: items[index].medicineName,
                //               text: "edit",
                //               index: index,
                //             )));

                // if (result != null && result) {
                //   print("kjljljljljljljljljljljljljljljljljljl");
                //   print(result);
                //   setState(() {});
                //   //getList();
                // }
              },
              padding: EdgeInsets.zero,
              value: 1,
              child: StatefulBuilder(builder: (context, setState) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          IconData(0xe802, fontFamily: 'FeverTrackingIcons'),
                          color: AppTheme.textColor2,
                        ),
                        SizedBox(
                          // sized box with width 10
                          width: 15,
                        ),
                        Text("Edit",
                            style: TextStyle(color: AppTheme.textColor2))
                      ],
                    ));
              })),

          // popupmenu item 2
          PopupMenuItem(
            onTap: () {
              deleteMedicine(index);
            },
            padding: EdgeInsets.zero,
            value: 2,
            // row has two child icon and text
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: AppTheme.textColor2,
                  ),
                  SizedBox(
                    // sized box with width 10
                    width: 15,
                  ),
                  Text("Delete", style: TextStyle(color: AppTheme.textColor2))
                ],
              ),
            ),
          ),
        ],

        elevation: 2,
      );

      // widget.deleteMedicine == false
      //     ?
      //     InkWell(
      //   onTap: () {
      //     deleteMedicine(index);
      //   },
      //   child: Container(
      //     padding: EdgeInsets.all(2),
      //     alignment: Alignment.center,
      //     child: Icon(
      //       Icons.delete_outline,
      //       size: 20,
      //       color: Colors.red,
      //     ),
      //     decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         border: Border.all(color: Colors.grey, width: 1)),
      //   ),
      // );
      //     IconButton(
      //   icon: Icon(Icons.delete_outline),
      //   iconSize: 25,
      //   color: Colors.grey,
      //   onPressed: () {
      //     deleteMedicine(index);
      //   },
      // );
      // Container(
      //     padding: EdgeInsets.only(right: 12),
      //     child: Icon(
      //       const IconData(0xe802, fontFamily: 'FeverTrackingIcons'),
      //       color: AppTheme.tralingIconColor,
      //       size: 9,
      //     ),
      //   )
      // : Row(mainAxisSize: MainAxisSize.min, children: [
      //     Container(
      //       padding: EdgeInsets.only(right: 12),
      //       child: Icon(
      //         const IconData(0xe815, fontFamily: 'FeverTrackingIcons'),
      //         color: AppTheme.tralingIconColor,
      //         size: 9,
      //       ),
      //     ),

      //     IconButton(
      //       icon: Icon(
      //         Icons.delete,
      //       ),
      //       iconSize: 18,
      //       color: Colors.redAccent,
      //       onPressed: () {
      //         deleteMedicine(index);
      //       },
      //     ),

      // InkWell(
      //   onTap: () async {
      //     bool sucess;
      //     widget.deleteMedicine == true
      //         ? sucess = await deleteMedicine(index)
      //         : print("");
      //     if (sucess) {
      //       setState(() {
      //         widget.deleteMedicine = false;
      //       });
      //     }
      //   },
      //   child: Container(
      //     padding: EdgeInsets.only(right: 0),
      //     child: Icon(
      //       Icons.delete,
      //       // color: AppTheme.iconsColor2,
      //       color: Colors.black54,
      //       size: 18,
      //     ),
      //   ),
      // ),
      // ]);
    }
  }
}
