import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;

class MedicinesPage extends StatefulWidget {
  @override
  _MedicinesPageState createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  Color screenbackGroundColor = Color(0XFFF7F7F7);
  Color listbackGroundColor = Color(0XFFFFFFFF);
  Color dividerColor = Color(0XFF000000);
  Color listTittleColor = Color(0XFF030303);
  Color listSubtitleColor = Color(0XFF8F8E94);
  Color tralingIconColor = Color(0XFFe2e2e2);
  Color iconsColor = Color(0xFF708090);
  Color flottingButtonColor = Color(0XFF463DC7);

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: screenbackGroundColor,
        body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 0.5,
              margin: EdgeInsets.only(left: 16),
              color: Color.fromRGBO(0, 0, 0, 0.25),
            );
          },
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return itemWidget1(index);
          },
        ),
        floatingActionButton: GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: flottingButtonColor,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              boxShadow: [
                BoxShadow(
                  color: flottingButtonColor.withOpacity(0.6),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              const IconData(0xe806, fontFamily: 'FeverTrackingIcons'),
              color: Colors.white,
              size: 25,
            ),
          ),
        ));
  }

  Widget itemWidget1(int index) {
    return Container(
      color: listbackGroundColor,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ListTile(
          leading: Container(
            child: Icon(
              const IconData(0xe814, fontFamily: 'FeverTrackingIcons'),
              color: iconsColor,
              size: 45,
            ),
          ),
          title: Text(
            "Crossin",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 0,
                color: listTittleColor,
                fontFamily: "SF UI Display Bold",
                fontSize: globals.deviceType == 'phone' ? 17 : 25),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "3 Times per day",
              style: TextStyle(
                  color: listSubtitleColor,
                  letterSpacing: 0,
                  fontFamily: "SF UI Display ",
                  fontSize: globals.deviceType == "phone" ? 15 : 23),
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              const IconData(0xe815, fontFamily: 'FeverTrackingIcons'),
              color: tralingIconColor,
              size: 9,
            ),
          ),
          selected: true,
          onTap: () {},
        ),
        index == 4
            ? Container(
                height: 1,
                color: Color.fromRGBO(0, 0, 0, 0.25),
              )
            : Container()
      ]),
    );
  }
}
