import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:flutter_switch/flutter_switch.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Color backGroundColor = Color(0xFFFFFFFF);
  Color dropdowniconColor = Color(0XFFB5B1E8);
  Color textColor = Color(0xFFFFFFFF);
  Color dividerColor = Color.fromRGBO(0, 0, 0, 0.25);
  Color listTextColor = Color(0xFF030303);
  Color headingTextColor = Color(0xFF000000);
  Color iconsColor = Color(0xFFd6d6d6);
  Color upperWidgetBackgroundColor = Color(0xFFFFFFFF).withOpacity(0.4);
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
              color: dividerColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: ListTile(
              leading: Container(
                height: 30,
                width: 30,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  border: Border.all(width: 0.0, color: Colors.white54),
                  borderRadius: BorderRadius.all(Radius.circular(
                          20.0) //                 <--- border radius here
                      ),
                ),
                // child: Icon(
                //   const IconData(0xe808, fontFamily: 'FeverTracking'),
                //   color: iconsColor,
                //   size: 15,
                // ),
              ),
              minLeadingWidth: 30,
              title: Text(
                "Reminders",
                style: TextStyle(
                    color: listTextColor,
                    letterSpacing: 0,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == 'phone' ? 17 : 25),
              ),
              trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Transform.scale(
                      scale: 1.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0, right: 0),
                        child: CupertinoSwitch(
                          value: _lights,
                          onChanged: (bool value) {
                            setState(() {
                              _lights = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ]),
              selected: true,
              onTap: () {},
            ),
          ),
          // Divider(
          //   thickness: 1,
          //   height: 1,
          //   indent: 80,
          //   endIndent: 10,
          //   color: dividerColor,
          // ),
          Container(
            height: 0.7,
            margin: EdgeInsets.only(left: 65),
            decoration: BoxDecoration(
              color: dividerColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: ListTile(
              leading: Container(
                width: 30,
                height: 30,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  border: Border.all(width: 0.0, color: Colors.white54),
                  borderRadius: BorderRadius.all(Radius.circular(
                          20.0) //                 <--- border radius here
                      ),
                ),
                // child: Icon(
                //   const IconData(0xe813, fontFamily: 'FeverTracking'),
                //   color: iconsColor,
                // ),
              ),
              minLeadingWidth: 30,
              title: Text(
                "Symptoms",
                style: TextStyle(
                    color: listTextColor,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == 'phone' ? 17 : 25),
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
          Container(
            height: 0.7,
            margin: EdgeInsets.only(left: 65),
            // width: MediaQuery.of(context).size.width * 60,
            decoration: BoxDecoration(
              color: dividerColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: ListTile(
              leading: Container(
                width: 30,
                height: 30,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  border: Border.all(width: 0.0, color: Colors.white54),
                  borderRadius: BorderRadius.all(Radius.circular(
                          20.0) //                 <--- border radius here
                      ),
                ),
                // child: Icon(
                //   const IconData(0xe803, fontFamily: 'FeverTracking'),
                //   color: iconsColor,
                // ),
              ),
              minLeadingWidth: 30,
              title: Text(
                "Health",
                style: TextStyle(
                    color: listTextColor,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == 'phone' ? 17 : 25),
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
          Container(
            height: 0.7,
            margin: EdgeInsets.only(left: 65),
            decoration: BoxDecoration(
              color: dividerColor,
            ),
          ),
        ]),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget upperitemWidget() {
    return Container(
      decoration: BoxDecoration(
        color: upperWidgetBackgroundColor,
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
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(0, 0, 0, 0.2),
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
                      backgroundImage:
                          NetworkImage('https://picsum.photos/250?image=9'),
                    ),
                  ),
                ]),
            SizedBox(
              width: 10,
            ),
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
                        "Default Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: headingTextColor,
                            fontFamily: "SF UI Display Bold",
                            fontSize: globals.deviceType == 'phone' ? 18 : 26),
                      ),
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        color: dropdowniconColor,
                        size: 28,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Passcode :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // fontWeight: FontWeight.w600,
                            color: headingTextColor,
                            letterSpacing: 0,
                            fontFamily: "SF UI Display Regulars",
                            fontSize: globals.deviceType == 'phone' ? 14 : 22),
                      ),
                      Text(
                        "Disable",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0XFF463DC7),
                            fontFamily: "SF UI Display Regular",
                            fontSize: globals.deviceType == 'phone' ? 14 : 22),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(0),
                    width: 110,
                    height: 30,
                    child: CupertinoSegmentedControl(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      children: {
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
                                'C',
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
                        2: Container(
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
                                  fontSize:
                                      globals.deviceType == 'phone' ? 16 : 24,
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
            ),
          ]),
    );
  }
}
