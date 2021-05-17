import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/Symptoms/addsymptoms.dart';
import 'package:mobile_app/src/modules/Symptoms/editsymptoms.dart';
import 'package:mobile_app/src/modules/Symptoms/model/symptomsmodel.dart';
import 'package:mobile_app/src/modules/medicines/add_medicine.dart';

import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/widgets/loaderWidget.dart';

class SymptomsListPage extends StatefulWidget {
  @override
  _SymptomsListPageState createState() => _SymptomsListPageState();
}

class _SymptomsListPageState extends State<SymptomsListPage> {
  List<String> symptoms = [
    "Sweating",
    "Chills and Shivering",
    "Sore Throat",
    // "Loss of Taste or Smell",
    // "Sweating",
    // "Chills and Shivering",
    // "Sore Throat",
    // "Loss of Taste or Smell",
  ];
  var logsList;
  getList() async {
    // final log = SymptomsModel("vomatining");
    logsList = await DbServices().getListData(Strings.createSymptoms);
    // logsList =
    //     await DbServices().updateListData(Strings.createSymptoms, 1, log);
    print(logsList);
    // print("${logsList[0]}");
    // setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text(
            'Symptoms',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppTheme.titleColor,
                letterSpacing: 0,
                fontSize: globals.deviceType == 'phone' ? 20 : 28,
                fontFamily: 'SF UI Display Semibold',
                fontWeight: FontWeight.w600),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
              getList();
            },
            child: Icon(
              Icons.close,
              size: 30.0,
              color: AppTheme.iconColor,
            ),
          ),
        ),
        backgroundColor: AppTheme.screenbackGroundColor,
        body: makeWidget(),
        floatingActionButton: GestureDetector(
          onTap: () async {
            // getList();
            var name = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddSymptomsPage()));
            setState(() {});
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

  Widget makeWidget() {
    return FutureBuilder(
        future: DbServices().getListData(Strings.createSymptoms),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data != null && snapshot.data.length > 0
                ? ListView.separated(
                    separatorBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 20),
                        height: 0.4,
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                      );
                    },
                    padding: EdgeInsets.only(top: 10, bottom: 100),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return itemWidget1(index, snapshot.data);
                    },
                  )
                : Center(
                    child: Text(
                      'No SymptomName Found!!',
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

  Widget itemWidget1(int index, items) {
    return Container(
      color: AppTheme.listbackGroundColor,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: EdgeInsets.all(20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // leading: Container(
            //   child: Icon(
            //     const IconData(0xe814, fontFamily: 'FeverTrackingIcons'),
            //     color: AppTheme.iconsColor,
            //     size: 45,
            //   ),
            // ),
            Container(
              child: Text(
                items[index].symptomName != null &&
                        items[index].symptomName.isNotEmpty
                    ? items[index].symptomName
                    : '',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                    color: AppTheme.textColor1,
                    fontFamily: "SF UI Display Bold",
                    fontSize: globals.deviceType == 'phone' ? 17 : 25),
              ),
            ),
            InkWell(
              onTap: () async {
                print(index);
                {
                  var get = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditSymptomsPage(
                              index: index,
                              sysmptomsItem: items[index].symptomName)));

                  setState(() {
                    print("setstate");
                  });

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DetailScreen(todo: todos[index]),
                  //   ),
                }
              },
              child: Container(
                padding: EdgeInsets.only(right: 0),
                child: Icon(
                  const IconData(0xe802, fontFamily: "FeverTrackingIcons"),
                  // color:AppTheme.iconColor,
                  color: Colors.black54,
                  size: 24,
                ),

                // Icon(
                //   Icons.edit_rounded,
                //   // color: AppTheme.tralingIconColor,
                //   color: Colors.black,
                //   size: 19,
                // ),
              ),
            ),
          ]),
        ),
        // index == (symptoms.length - 1)
        //     ? Container(
        //         height: 1,
        //         color: Color.fromRGBO(0, 0, 0, 0.25),
        //       )
        //     : Container()
      ]),
    );
  }
}

// ListView.separated(
//           separatorBuilder: (BuildContext context, int index) {
//             return Container(
//               height: 0.5,
//               margin: EdgeInsets.only(left: 16),
//               color: Color.fromRGBO(0, 0, 0, 0.25),
//             );
//           },
//           itemCount: symptoms.length,
//           itemBuilder: (BuildContext context, int index) {
//             return itemWidget1(index);
//           },
//         ),

//  Text(
//                 "${logsList[index].symptomName}",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 0,
//                     color: AppTheme.textColor1,
//                     fontFamily: "SF UI Display Bold",
//                     fontSize: globals.deviceType == 'phone' ? 17 : 25),
//               ),
