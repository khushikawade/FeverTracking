import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_switch/flutter_switch.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Color backGroundColor = Color(0xFFFFFFFF);
  Color dropdowniconColor = Color(0XFFB5B1E8);
  Color textColor = Color(0xFFFFFFFF);
  Color dividerColor = Color(0xffC4CADF);
  Color listTextColor = Color(0xFF030303);
  Color headingTextColor = Color(0xFF000000);
  Color iconsColor = Color(0xFFd6d6d6);

  Color iconBackgroundColor = Color(0xff929292);
  Color toggleSwitchActiveColor = Color(0XFF4CD964);
  bool _lights = false;
  int _selectedIndexValue;
  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backGroundColor,
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 47.06,
                      backgroundImage:
                          NetworkImage('https://picsum.photos/250?image=9'),
                    ),
                  ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "Default Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: headingTextColor,
                          fontFamily: "SF UI Display",
                          fontSize: 18),
                    ),
                    Icon(
                      Icons.arrow_drop_down_sharp,
                      color: dropdowniconColor,
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "Passcode :",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: headingTextColor,
                          fontFamily: "SF UI Display",
                          fontSize: 14),
                    ),
                    Text(
                      "Disable",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF463DC7),
                          fontFamily: "SF UI Display Regular",
                          fontSize: 16),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(0),
                  width: 150,
                  height: 50,
                  child: CupertinoSegmentedControl(
                    children: {
                      1: Container(
                        width: 145,
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
                              'C',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                color: _selectedIndexValue == 1
                                    ? Colors.white
                                    : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      2: Container(
                        width: 145,
                        alignment: Alignment.center,
                        color: _selectedIndexValue == 2
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
                                decoration: _selectedIndexValue == 2
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
                                fontSize: 17,
                                color: _selectedIndexValue == 2
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
                      });
                    },
                  ),
                ),
              ],
            ),
          ]),
          Divider(
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: dividerColor,
          ),
          Container(
            padding: EdgeInsets.only(left: 5, top: 5, right: 10, bottom: 5),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  border: Border.all(width: 0.0, color: Colors.white54),
                  borderRadius: BorderRadius.all(Radius.circular(
                          20.0) //                 <--- border radius here
                      ),
                ),
                child: Icon(
                  const IconData(0xea10, fontFamily: 'FeverTracking'),
                  color: iconsColor,
                ),
              ),
              title: Text(
                "Reminders",
                style: TextStyle(
                    color: listTextColor,
                    fontFamily: "SF UI Display Regular",
                    fontSize: 17),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Transform.scale(
                      scale: 1.0,
                      child: Container(
                        width: 60,
                        child: FlutterSwitch(
                          width: 51,
                          height: 31,
                          // toggleSize: 29,
                          activeColor: toggleSwitchActiveColor,
                          value: _lights,
                          onToggle: (val) {
                            setState(() {
                              _lights = val;
                            });
                          },
                        ),
                      )),
                ],
              ),

              // Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: <Widget>[
              //       Transform.scale(
              //         scale: 1.0,
              //         child: Padding(
              //           padding: const EdgeInsets.only(left: 28.0, right: 0),
              //           child: CupertinoSwitch(
              //             value: _lights,
              //             onChanged: (bool value) {
              //               setState(() {
              //                 _lights = value;
              //               });
              //             },
              //           ),
              //         ),
              //       )

              //   Transform.scale(
              //     scale: 1.5,
              //     child: MergeSemantics(
              //       child: ListTile(
              //         title: Text('Lights'),
              //         trailing: CupertinoSwitch(
              //           value: _lights,
              //           onChanged: (bool value) {
              //             setState(() {
              //               _lights = value;
              //             });
              //           },
              //         ),
              //         onTap: () {
              //           setState(() {
              //             _lights = !_lights;
              //           });
              //         },
              //       ),
              //     ),
              //   )
              // Transform.scale(
              //     scale: 1.5,
              //     child: Switch(
              //       onChanged: toggleSwitch,
              //       value: isSwitched,
              //       activeColor: Colors.white,
              //       activeTrackColor: Colors.greenAccent,
              //       inactiveThumbColor: Colors.white,
              //       inactiveTrackColor: Colors.white54,
              //     )),
              // ]

              // ),
              selected: true,
              onTap: () {},
            ),
          ),
          Divider(
            thickness: 1,
            height: 1,
            indent: 80,
            endIndent: 10,
            color: dividerColor,
          ),
          Container(
            padding: EdgeInsets.only(left: 5, top: 5, right: 10, bottom: 5),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  border: Border.all(width: 0.0, color: Colors.white54),
                  borderRadius: BorderRadius.all(Radius.circular(
                          20.0) //                 <--- border radius here
                      ),
                ),
                child: Icon(
                  const IconData(0xea10, fontFamily: 'FeverTracking'),
                  color: iconsColor,
                ),
              ),
              title: Text(
                "Symptoms",
                style: TextStyle(
                    color: listTextColor,
                    fontFamily: "SF UI Display Regular",
                    fontSize: 17),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF536274),
                size: 15,
              ),
              selected: true,
              onTap: () {},
            ),
          ),
          Divider(
            thickness: 1,
            height: 1,
            indent: 80,
            endIndent: 10,
            color: dividerColor,
          ),
          Container(
            padding: EdgeInsets.only(left: 5, top: 5, right: 10, bottom: 5),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  border: Border.all(width: 0.0, color: Colors.white54),
                  borderRadius: BorderRadius.all(Radius.circular(
                          20.0) //                 <--- border radius here
                      ),
                ),
                child: Icon(
                  const IconData(0xea10, fontFamily: 'FeverTracking'),
                  color: iconsColor,
                ),
              ),
              title: Text(
                "Health",
                style: TextStyle(
                    color: listTextColor,
                    fontFamily: "SF UI Display Regular",
                    fontSize: 17),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF536274),
                size: 15,
              ),
              selected: true,
              onTap: () {},
            ),
          ),
          Divider(
            thickness: 1,
            height: 1,
            indent: 80,
            endIndent: 0,
            color: dividerColor,
          ),
        ]),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
