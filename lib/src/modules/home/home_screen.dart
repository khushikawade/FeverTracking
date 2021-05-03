import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/home/menu_screen.dart';
import 'package:mobile_app/src/modules/logs/log.dart';
import 'package:mobile_app/src/modules/medicines/medicines.dart';
import 'package:mobile_app/src/modules/profile/setting.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Home',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xffFFFFFF),
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
                    'Apr 23, 2021',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xffFFFFFF).withOpacity(0.6),
                        letterSpacing: 0.08,
                        fontSize: globals.deviceType == 'phone' ? 13 : 21,
                        fontFamily: 'SF UI Display Regular',
                        fontWeight: FontWeight.normal),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xffB5B1E8),
                    size: 18,
                  )
                ],
              )
            ],
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
                    print("Selected Index : ${selectedIndex}");
                  });
                }
              },
              icon: Icon(
                IconData(0xe804, fontFamily: "FeverTrackingIcons"),
                color: Color(0xffFFFFFF),
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
                : Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: IconButton(
                      onPressed: () async {
                        // if (selectedIndex == 3) {
                        //   updateProfileSuccess = await Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => EditProfileScreen()),
                        //   );
                        //   if (updateProfileSuccess != null && updateProfileSuccess) {
                        //     print("Result : ${updateProfileSuccess}");
                        //     setState(() {});
                        //   }
                        // }
                        //Navigator.pop(context);
                      },
                      icon: Icon(
                        IconData(
                            selectedIndex == 0
                                ? 0xe800
                                : selectedIndex == 1
                                    ? 0xe809
                                    : 0xe802,
                            fontFamily: "FeverTrackingIcons"),
                        color: Color(0xffFFFFFF),
                        size: 24,
                      ),
                    ),
                  ),
          ],
        ),
        body: selectedIndex == 0
            ? Container(
                color: Colors.red,
                width: double.infinity,
                height: double.infinity,
              )
            : selectedIndex == 1
                ? LogPage()
                : selectedIndex == 2
                    ? MedicinesPage()
                    : SettingPage());
  }
}
