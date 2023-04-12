import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/Symptoms/symptom.dart';
import 'package:mobile_app/src/modules/profile/googlefit.dart';
import 'package:mobile_app/src/modules/profile/updateprofie.dart';

import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SettingPage extends StatefulWidget {
  String imagePath;
  SettingPage({this.imagePath});
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _lights = false;
  int _selectedIndexValue = 1;
  bool isSwitched = false;
  var logsList;
  String _image;
  String _name;
  String tempValue;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  getUserDetail() async {
    var userData = await DbServices().getListData(Strings.updateProile);

    globals.userObj = userData;

    _image = globals.userObj != null && globals.userObj.length > 0
        ? globals.userObj[0].path
        : null;

    _name = globals.userObj != null && globals.userObj.length > 0
        ? globals.userObj[0].name
        : null;

    setState(() {});
  }

  @override
  initState() {
    print("path");
    print(widget.imagePath);
    // if (widget.imagePath != null) {
    //   _image = widget.imagePath;
    // } else {

    _image = globals.userObj != null && globals.userObj.length > 0
        ? globals.userObj[0].path
        : null;
    // }
    Utility.getStringValuesSF().then((value) {
      if (value == "C") {
        _selectedIndexValue = 0;
        // globals.calculateTemp();
      } else {
        _selectedIndexValue = 1;
      }
    });
    getUserDetail();
    // getLogs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   elevation: 5,
        //   backgroundColor: Theme.of(context).primaryColor,
        //   centerTitle: true,
        //   title: Text(
        //     'Settings',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //         color: AppTheme.titleColor,
        //         letterSpacing: 0,
        //         fontSize: globals.deviceType == 'phone' ? 20 : 28,
        //         fontFamily: 'SF UI Display Semibold',
        //         fontWeight: FontWeight.w600),
        //   ),
        //   leading: InkWell(
        //     onTap: () {
        //       Future.delayed(
        //         Duration.zero,
        //         () {
        //           Navigator.of(context).pop(false);
        //         },
        //       );
        //     },
        //     child: Icon(
        //       Icons.close,
        //       size: 30.0,
        //       color: AppTheme.iconColor,
        //     ),
        //   ),
        // ),
        body: ListView(children: [
      Container(
        color: Theme.of(context).backgroundColor,
        child: Column(children: [
          SizedBox(
            height: 35,
          ),
          upperitemWidget(),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 0.7,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppTheme.dividerColor,
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(top: 7, bottom: 7),
          //   child: ListTile(
          //     leading: Container(
          //       padding: EdgeInsets.all(4),
          //       decoration: BoxDecoration(
          //           color: AppTheme.iconBackgroundColor,
          //           shape: BoxShape.circle),
          //       child: Icon(
          //         const IconData(0xe811, fontFamily: 'FeverTrackingIcons'),
          //         color: AppTheme.iconColor1,
          //         size: 26,
          //       ),
          //     ),
          //     //minLeadingWidth: 30,
          //     title: Text(
          //       "Reminders",
          //       style: TextStyle(
          //           color: AppTheme.textColor1,
          //           letterSpacing: 0,
          //           fontFamily: "SF UI Display Regular",
          //           fontSize: globals.deviceType == 'phone' ? 17 : 25),
          //     ),
          //     trailing: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: <Widget>[
          //           Transform.scale(
          //             scale: 1.0,
          //             child: Padding(
          //               padding: const EdgeInsets.only(left: 28.0, right: 0),
          //               child: CupertinoSwitch(
          //                 value: _lights,
          //                 onChanged: (bool value) {
          //                   setState(() {
          //                     _lights = value;
          //                   });
          //                 },
          //               ),
          //             ),
          //           ),
          //         ]),
          //     selected: true,
          //     onTap: () {},
          //   ),
          // ),
          // Container(
          //   height: 0.7,
          //   margin: EdgeInsets.only(left: 65),
          //   decoration: BoxDecoration(
          //     color: AppTheme.dividerColor,
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: ListTile(
              leading: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: AppTheme.iconBackgroundColor,
                    shape: BoxShape.circle),
                child: Icon(
                  const IconData(0xe813, fontFamily: 'FeverTrackingIcons'),
                  color: AppTheme.iconColor1,
                  size: 24,
                ),
              ),
              title: Text(
                "Symptoms",
                style: TextStyle(
                    color: AppTheme.textColor1,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == 'phone' ? 17 : 25),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.iconsColor3,
                size: 15,
              ),
              selected: true,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SymptomsListPage()));
              },
            ),
          ),
          Container(
            height: 0.7,
            margin: EdgeInsets.only(left: 65),
            // width: MediaQuery.of(context).size.width * 60,
            decoration: BoxDecoration(
              color: AppTheme.dividerColor,
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(top: 7, bottom: 7),
          //   child: ListTile(
          //     leading: Container(
          //       padding: EdgeInsets.all(4),
          //       decoration: BoxDecoration(
          //           color: AppTheme.iconBackgroundColor,
          //           shape: BoxShape.circle),
          //       child: Icon(
          //         const IconData(0xe812, fontFamily: 'FeverTrackingIcons'),
          //         color: AppTheme.iconColor1,
          //         size: 26,
          //       ),
          //     ),
          //     title: Text(
          //       "Sync with Google Fit",
          //       style: TextStyle(
          //           color: AppTheme.textColor1,
          //           fontFamily: "SF UI Display Regular",
          //           fontSize: globals.deviceType == 'phone' ? 17 : 25),
          //     ),
          //     trailing: Icon(
          //       Icons.arrow_forward_ios,
          //       color: AppTheme.iconsColor3,
          //       size: 15,
          //     ),
          //     selected: true,
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => GoogleFit()),
          //       );
          //     },
          //   ),
          // ),
          // Container(
          //   height: 0.7,
          //   margin: EdgeInsets.only(left: 65),
          //   decoration: BoxDecoration(
          //     color: AppTheme.dividerColor,
          //   ),
          // ),
        ]),
      ),
    ]));
    // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget upperitemWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor.withOpacity(0.4),
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children:

              // <Widget>
              [
            SizedBox(
              width: 45,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () async {
                        bool result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateProfielPage()));

                        if (result != null && result) {
                          print("999999");
                          print(result);
                          setState(() {});
                        }
                        setState(() {});
                      },
                      child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(47.06),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                              radius: 47.06,
                              // child:
                              //  (_image != null )Utility.getImageFromPreferences().toString()
                              // ? Utility.getImageFromPreferences().then((value)
                              backgroundImage: _image != null
                                  ? FileImage(File(_image))
                                  : ExactAssetImage(
                                      'assets/images/profileimage.png'))))
                ]),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _name != null ? _name : "Default Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.headingTextColor,
                            fontFamily: "SF UI Display Bold",
                            fontSize: globals.deviceType == 'phone' ? 18 : 26),
                      ),
                      IconButton(
                        onPressed: () async {
                          bool result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateProfielPage()));

                          if (result != null && result) {
                            getUserDetail();
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppTheme.dropdowniconColor,
                          size: 20,
                        ),
                      )
                    ],
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Passcode :",
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //           color: AppTheme.headingTextColor,
                  //           letterSpacing: 0,
                  //           fontFamily: "SF UI Display Regulars",
                  //           fontSize: globals.deviceType == 'phone' ? 14 : 22),
                  //     ),
                  //     Text(
                  //       "Disable",
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //           color: AppTheme.textColor2,
                  //           fontFamily: "SF UI Display Regular",
                  //           fontSize: globals.deviceType == 'phone' ? 14 : 22),
                  //     ),
                  //   ],
                  // ),

                  Container(
                    margin: const EdgeInsets.all(0),
                    width: 110,
                    child: CupertinoSegmentedControl(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      children: {
                        0: Container(
                          alignment: Alignment.center,
                          color: _selectedIndexValue == 0
                              ? Colors.blue
                              : Colors.white,
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, right: 5, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 4,
                                  height: 4,
                                  decoration: _selectedIndexValue == 0
                                      ? BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ))
                                      : BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 1,
                                          ))),
                              Text(
                                'C',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      globals.deviceType == 'phone' ? 16 : 24,
                                  color: _selectedIndexValue == 0
                                      ? Colors.white
                                      : Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        1: Container(
                          alignment: Alignment.center,
                          color: _selectedIndexValue == 1
                              ? Colors.blue
                              : Colors.white,
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, right: 5, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 4,
                                  height: 4,
                                  decoration: _selectedIndexValue == 1
                                      ? BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ))
                                      : BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 1,
                                          ))),
                              Text(
                                'F',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      globals.deviceType == 'phone' ? 16 : 24,
                                  color: _selectedIndexValue == 1
                                      ? Colors.white
                                      : Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      },
                      onValueChanged: (value) {
                        setState(() {
                          _selectedIndexValue = value;
                          if (_selectedIndexValue == 0) {
                            globals.addIntToSF('C');
                          } else if (_selectedIndexValue == 1) {
                            globals.addIntToSF('F');
                          } else {}

                          globals.calculateTemp();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  // addIntToSF(value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('stringValue', value);
  // }

  // getLogs() async {
  //   var logsList = await DbServices().getSelectedDateData(Strings.hiveLogName);
  //   globals.logObj = logsList;
  //   for (int i = 0; i < globals.logObj.length; i++) {
  //     if (globals.logObj[i].value == 'C') {
  //       globals.calculateTemp();

  //       bool isSuccess = await DbServices().updateListData(
  //         Strings.hiveLogName,
  //         i,
  //         globals.logObj,
  //       );
  //     } else {}
  //   }
  //   print(tempValue);
  //   setState(() {});
  // }
}
