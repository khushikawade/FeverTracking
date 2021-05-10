import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';

class MedicinesPage extends StatefulWidget {
  @override
  _MedicinesPageState createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  // Color flottingButtonColor = Color(0XFF463DC7);
  // Color dividerColor = Color(0XFF000000);
  // Color listTittleColor = Color(0XFF030303);

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.screenbackGroundColor,
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

  Widget itemWidget1(int index) {
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
            "Crossin",
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
              "3 Times per day",
              style: TextStyle(
                  color: AppTheme.listSubtitleColor,
                  letterSpacing: 0,
                  fontFamily: "SF UI Display ",
                  fontSize: globals.deviceType == "phone" ? 15 : 23),
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              const IconData(0xe815, fontFamily: 'FeverTrackingIcons'),
              color: AppTheme.tralingIconColor,
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
