import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/logs/addLog.dart';
import 'package:mobile_app/src/modules/logs/model/logsmodel.dart';
import 'package:mobile_app/src/modules/logs/sliders/monthslider.dart';
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';
import 'package:mobile_app/src/widgets/loaderWidget.dart';
import 'package:mobile_app/src/widgets/timeago.dart';

class LogPage extends StatefulWidget {
  Function onUpdateWidget;
  bool deleteLog;
  LogPage({Key key, this.onUpdateWidget, this.deleteLog = false})
      : super(key: key);
  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<bool> deleteLog(index) async {
    bool isSuccess = await DbServices().deleteData(Strings.hiveLogName, index);
    if (isSuccess != null && isSuccess) {
      Utility.showSnackBar(_scaffoldKey, 'Log deleted successfully', context);

      setState(() {
        widget.deleteLog = false;
      });
    }
    return isSuccess;
  }

  var logsList;
  static GlobalKey previewContainer = new GlobalKey();
  @override
  void initState() {
    getLogs();
    super.initState();
  }

  // get Logs List
  getLogs() async {
    logsList = await DbServices().getSelectedDateData(Strings.hiveLogName);

    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.screenbackGroundColor,
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: ListView(children: [
            // makeSliders(),
            Container(
              height: 1,
              decoration: BoxDecoration(
                color: AppTheme.dividerColor.withOpacity(0.25),
              ),
            ),
            makeWidget(),
          ]),
        ),
        floatingActionButton: GestureDetector(
          onTap: () async {
            bool result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (
                  context,
                ) =>
                        AddLogPage(
                          fromHomePage: false,
                        )));

            if (result != null && result) {
              widget.onUpdateWidget(true);
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

  Widget makeSliders() {
    return SizedBox(
      // width: 200.0,
      //height: MediaQuery.of(context).size.height * .22,
      height: 160,
      child: MonthSlider(
        onUpdateWidget: (bool result) {
          print(" called ...... ");
          setState(() {});
        },
        isdefaultcall: true,
      ),
    );
  }

  List<LogsModel> listofSelectedDate;
  // getLogs() async {
  //   print("getlogs");
  //   listofSelectedDate = new List();
  //   var logsList = await DbServices().getListData(Strings.hiveLogName);
  //   // globals.getdatefromslider !=null ?    globals.getdatefromslider=

  //   if (logsList != null && logsList.length > 0) {
  //     for (int i = 0; i < logsList.length; i++) {
  //       // print(logsList[i].dateTime);

  //       String logTemp1 = "${logsList[i].dateTime}".split(' ')[0];
  //       String logTemp2 = "${globals.getdatefromslider}".split(' ')[0];

  //       if (logTemp1 == logTemp2) {
  //         // DateTime dateTime = logsList[i].dateTime;
  //         // String position;
  //         // String temprature;
  //         // String symptoms;
  //         // var addMedinceLog;
  //         // String addNotehere;
  //         var item = LogsModel(
  //             logsList[i].dateTime,
  //             logsList[i].position,
  //             logsList[i].temprature,
  //             logsList[i].symptoms,
  //             logsList[i].addMedinceLog,
  //             logsList[i].addNotehere);
  //         print("inside loop  $logTemp1  $logTemp2");
  //         listofSelectedDate.add(item);

  //         for (int i = 0; i < listofSelectedDate.length; i++) {
  //           print("loglistitem");
  //           print(listofSelectedDate[i].dateTime);
  //           // var filteredUsers = logsList.values
  //           //     .where((LogsModel) => LogsModel.dateTime == "")
  //           //     .toList();
  //           // print(filteredUsers.length);
  //         }
  //       }
  //     }
  //   }
  // }

  // make logs scrren list
  Widget makeWidget() {
    return FutureBuilder(
        future: DbServices().getSelectedDateData(Strings.hiveLogName),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data != null && snapshot.data.length > 0
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 100),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return itemWidget(index, snapshot.data);
                    },
                  )
                // : ListView.builder(
                //     scrollDirection: Axis.vertical,
                //     shrinkWrap: true,
                //     padding: EdgeInsets.only(top: 10, bottom: 100),
                //     itemCount: snapshot.data.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return itemWidget(index, snapshot.data);
                //     },
                //   )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        'No Data Found.',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor1,
                            fontFamily: "SF UI Display Regular",
                            fontSize: globals.deviceType == 'phone' ? 17 : 25),
                      ),
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

  Widget itemWidget(int index, items) {
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
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
            // Icon(
            //   const IconData(0xea10, fontFamily: 'FeverTrackingIcons'),
            //   color: AppTheme.leadingiconsColor,
            // ),

            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      items[index].temprature != null &&
                              items[index].temprature.isNotEmpty
                          ? '${items[index].temprature} ${Strings.feranahiteString}'
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
                            items[index].addMedinceLog != null
                                ? '${items[index].addMedinceLog.medicineName}, ${items[index].addMedinceLog.dosage}'
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
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
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              items[index].symptoms != null &&
                                      items[index].symptoms.isNotEmpty
                                  ? items[index].symptoms
                                  : '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: AppTheme.subtitleTextColor,
                                  fontFamily: "SF UI Display Regular",
                                  fontSize:
                                      globals.deviceType == 'phone' ? 14 : 22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            SizedBox(
              width: 10,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    items[index].dateTime != null
                        ? DateFormat('dd-MM-yyyy')
                                .format(items[index].dateTime) +
                            "  " +
                            DateFormat.jm().format(items[index].dateTime)
                        // items[index].dateTime : '',
                        // ? Utility.timeAgoSinceDate(items[index].dateTime)
                        // ? DateFormat('HH:mm').format(items[index].dateTime) ==
                        //         DateFormat('HH:mm').format(DateTime.now())
                        //     ? 'Just Now'
                        //     : DateFormat('yyyy-MM-dd')
                        //                 .format(items[index].dateTime) ==
                        //             DateFormat('yyyy-MM-dd')
                        //                 .format(DateTime.now())
                        //         ? DateFormat.yMMMEd()
                        //             .format(items[index].dateTime)
                        //         : DateFormat.jm().format(items[index].dateTime)
                        : '',
                    style: TextStyle(
                        color: AppTheme.textColor2,
                        fontWeight: FontWeight.normal,
                        fontFamily: "SF UI Display Regular",
                        fontSize: globals.deviceType == 'phone' ? 13 : 20),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    // InkWell(
                    //   onTap: () async {
                    //     bool result = await Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => AddLogPage(
                    //                   fromHomePage: false,
                    //                 )));

                    //     if (result != null && result) {
                    //       widget.onUpdateWidget(true);
                    //       setState(() {});
                    //       // getList();
                    //     }
                    //   },
                    //   child: Icon(
                    //     const IconData(0xe802,
                    //         fontFamily: "FeverTrackingIcons"),
                    //     // color:AppTheme.iconColor,
                    //     color: Colors.black54,
                    //     size: 24,
                    //   ),
                    // ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        deleteLog(index);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.delete_outline,
                          size: 17,
                          color: Colors.red,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 1)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
