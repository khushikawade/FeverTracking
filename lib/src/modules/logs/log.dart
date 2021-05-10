import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';

class LogPage extends StatefulWidget {
  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  // Color flottingButtonColor = Color(0XFF463DC7);
  // Color listTittleColor = Color(0XFF030303);
  // Color listSubtitleColor = Color(0XFF666666);
  // Color tralingTextColor = Color(0XFF463DC7);

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.screenbackGroundColor,
        body: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return itemWidget(index);
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

  Widget itemWidget(int index) {
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
        padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.listbackGroundColor,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              spreadRadius: 0,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(
              const IconData(0xea10, fontFamily: 'FeverTracking'),
              color: AppTheme.leadingiconsColor,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "100.7 F",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textColor1,
                          fontFamily: "SF UI Display Bold",
                          fontSize: globals.deviceType == 'phone' ? 17 : 25),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Meds: ",
                          style: TextStyle(
                              color: AppTheme.subtitleTextColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: "SF UI Display Semibold",
                              fontSize:
                                  globals.deviceType == 'phone' ? 14 : 22),
                        ),
                        Expanded(
                          child: Text(
                            "Crossin 5mg",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppTheme.subtitleTextColor,
                                fontFamily: "SF UI Display Regular",
                                fontSize:
                                    globals.deviceType == 'phone' ? 14 : 22),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Symptoms: ",
                          style: TextStyle(
                              color: AppTheme.subtitleTextColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: "SF UI Display Semibold",
                              fontSize:
                                  globals.deviceType == 'phone' ? 14 : 22),
                        ),
                        Expanded(
                          child: Text(
                            "Headache, Runny Nose",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppTheme.subtitleTextColor,
                                fontFamily: "SF UI Display Regular",
                                fontSize:
                                    globals.deviceType == 'phone' ? 14 : 22),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Text(
                "Just Now ",
                style: TextStyle(
                    color: AppTheme.textColor2,
                    fontWeight: FontWeight.normal,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == 'phone' ? 12 : 20),
              ),
            ),
          ],
        ));
  }
}
