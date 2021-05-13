import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/logs/addLog.dart';
import 'package:mobile_app/src/modules/logs/model/logsmodel.dart';
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';
import 'package:mobile_app/src/widgets/loaderWidget.dart';
import 'package:mobile_app/src/widgets/timeago.dart';

class LogPage extends StatefulWidget {
  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  var logsList;
  @override
  void initState() {
    super.initState();

    //getList();
  }

  // get List Data
  getList() async {
    logsList = await DbServices().getListData(Strings.hiveLogName);
    // List<LogsModel> list = hiveBox.get(Strings.hiveLogName);
    print("Data : ${logsList}");
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.screenbackGroundColor,
        body: makeWidget(),
        floatingActionButton: GestureDetector(
          onTap: () async {
            bool result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddLogPage(
                          fromHomePage: false,
                        )));

            if (result != null && result) {
              setState(() {});
              //getList();
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
        future: DbServices().getListData(Strings.hiveLogName),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data != null && snapshot.data.length > 0
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 10, bottom: 100),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return itemWidget(index, snapshot.data);
                    },
                  )
                : Center(
                    child: Text(
                      'No Logs Found!!',
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
    //           'No Logs Found!!',
    //           style: TextStyle(
    //               fontWeight: FontWeight.w600,
    //               color: AppTheme.textColor1,
    //               fontFamily: "SF UI Display Regular",
    //               fontSize: globals.deviceType == 'phone' ? 17 : 25),
    //         ),
    //       );
  }

  Widget itemWidget(int index, items) {
    if (index == items.length - 1) {
      print(DateFormat('HH:mm').format(items[index].dateTime));
      print(DateFormat('HH:mm').format(DateTime.now()));
    }
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
              const IconData(0xea10, fontFamily: 'FeverTrackingIcons'),
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
                      items[index].temprature != null &&
                              items[index].temprature.isNotEmpty
                          ? items[index].temprature
                          : '',
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
                            items[index].temprature != null &&
                                    items[index].temprature.isNotEmpty
                                ? items[index].temprature
                                : '',
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
                            items[index].symptoms != null &&
                                    items[index].symptoms.isNotEmpty
                                ? items[index].symptoms
                                : '',
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
                items[index].dateTime != null
                    ? Utility.timeAgoSinceDate(items[index].dateTime)
                    // DateFormat('HH:mm').format(items[index].dateTime) ==
                    //         DateFormat('HH:mm').format(DateTime.now())
                    //     ? 'Just Now'
                    //     : DateFormat('yyyy-MM-dd')
                    //                 .format(items[index].dateTime) ==
                    //             DateFormat('yyyy-MM-dd').format(DateTime.now())
                    //         ? DateFormat.MMMEd().format(items[index].dateTime)
                    //         : DateFormat.jm().format(items[index].dateTime)
                    : '',
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
