import 'package:flutter/material.dart';

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
  Color tralingIconColor = Color(0XFFe3e2e5);
  Color iconsColor = Color(0xFF708090);
  Color flottingButtonColor = Color(0XFF463DC7);
  int item = 5;
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: screenbackGroundColor,
        body: Column(children: [
          Expanded(
            child: ListView.separated(
              itemCount: item + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == (item)) {
                  return Container(
                    decoration: BoxDecoration(
                      //                    <-- BoxDecoration
                      border: Border(
                          bottom: BorderSide(
                              width: 1.5,
                              color: dividerColor.withOpacity(0.2))),
                    ),
                  ); // zero height: not visible
                }

                return Container(
                    color: listbackGroundColor,
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 5, top: 5, right: 10, bottom: 5),
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              const IconData(0xea10,
                                  fontFamily: 'FeverTracking'),
                              color: iconsColor,
                            ),
                          ),
                          title: Text(
                            "Crossin",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: listTittleColor,
                                fontFamily: "SF UI Display Bold",
                                fontSize: 17),
                          ),
                          subtitle: Text(
                            "3 Times per day",
                            style: TextStyle(
                                color: listSubtitleColor,
                                fontFamily: "SF UI Display Regular",
                                fontSize: 15),
                          ),
                          trailing: Icon(
                            const IconData(0xea10, fontFamily: 'FeverTracking'),
                            color: Colors.black,
                          ),
                          selected: true,
                          onTap: () {},
                        ),
                      ),
                    ]));
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                  indent: 20, height: 5, color: dividerColor.withOpacity(0.2)),
            ),
          ),
          Container(
              decoration: BoxDecoration(
            //                    <-- BoxDecoration
            border: Border(bottom: BorderSide()),
          )),
        ]),
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
              const IconData(0xea16, fontFamily: 'FeverTracking'),
              color: Colors.white,
              size: 25,
            ),
          ),
        ));
  }
}
