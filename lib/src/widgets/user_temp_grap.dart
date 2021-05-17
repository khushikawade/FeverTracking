import 'package:charts_flutter/flutter.dart' as charts;

import 'package:mobile_app/src/db/db_services.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/widgets/heart_graph.dart';
import 'package:mobile_app/src/widgets/loaderWidget.dart';
import 'package:mobile_app/src/widgets/model/temperature_model.dart';
import 'package:mobile_app/src/widgets/selection_callback_state.dart';

// final tempraturedata1 = [
//   new TemperatureDataClass(new DateTime(2017, 10, 21), 0),
//   new TemperatureDataClass(new DateTime(2017, 10, 23), 1),
//   new TemperatureDataClass(new DateTime(2017, 10, 25), 2),
//   new TemperatureDataClass(new DateTime(2017, 10, 27), 1),
//   new TemperatureDataClass(new DateTime(2017, 10, 30), 2),
//   new TemperatureDataClass(new DateTime(2017, 11, 2), 3),
//   new TemperatureDataClass(new DateTime(2017, 11, 4), 4),
//   new TemperatureDataClass(new DateTime(2017, 11, 5), 4),
//   new TemperatureDataClass(new DateTime(2017, 11, 7), 4),
//   new TemperatureDataClass(new DateTime(2017, 11, 9), 3),
//   new TemperatureDataClass(new DateTime(2017, 11, 11), 3),
//   new TemperatureDataClass(new DateTime(2017, 11, 12), 3),
//   new TemperatureDataClass(new DateTime(2017, 11, 15), 3),
//   new TemperatureDataClass(new DateTime(2017, 11, 17), 5),
//   new TemperatureDataClass(new DateTime(2017, 11, 19), 5),
//   new TemperatureDataClass(new DateTime(2017, 11, 21), 4),
//   new TemperatureDataClass(new DateTime(2017, 11, 23), 4),
//   new TemperatureDataClass(new DateTime(2017, 11, 25), 4),
//   new TemperatureDataClass(new DateTime(2017, 11, 27), 5),
//   new TemperatureDataClass(new DateTime(2017, 11, 31), 5),
//   new TemperatureDataClass(new DateTime(2017, 12, 1), 5),
//   new TemperatureDataClass(new DateTime(2017, 12, 2), 6),
//   new TemperatureDataClass(new DateTime(2017, 12, 4), 7),
//   new TemperatureDataClass(new DateTime(2017, 12, 5), 8),
//   new TemperatureDataClass(new DateTime(2017, 12, 7), 9),
//   new TemperatureDataClass(new DateTime(2017, 12, 9), 10),
//   new TemperatureDataClass(new DateTime(2017, 12, 11), 11),
//   new TemperatureDataClass(new DateTime(2017, 12, 14), 12),
//   new TemperatureDataClass(new DateTime(2017, 12, 16), 13),
//   new TemperatureDataClass(new DateTime(2017, 12, 19), 14),
//   new TemperatureDataClass(new DateTime(2017, 12, 21), 15),
//   new TemperatureDataClass(new DateTime(2017, 12, 24), 16),
// ];

// final tempraturedata2 = [
//   new TemperatureDataClass(new DateTime(2017, 10, 21), 5),
//   new TemperatureDataClass(new DateTime(2017, 10, 23), 5),
//   new TemperatureDataClass(new DateTime(2017, 10, 25), 2),
//   new TemperatureDataClass(new DateTime(2017, 10, 27), 2),
//   new TemperatureDataClass(new DateTime(2017, 10, 30), 3),
//   new TemperatureDataClass(new DateTime(2017, 11, 2), 3),
//   new TemperatureDataClass(new DateTime(2017, 11, 4), 3),
//   new TemperatureDataClass(new DateTime(2017, 11, 5), 3),
//   new TemperatureDataClass(new DateTime(2017, 11, 7), 5),
//   new TemperatureDataClass(new DateTime(2017, 11, 9), 5),
//   new TemperatureDataClass(new DateTime(2017, 11, 11), 5),
//   new TemperatureDataClass(new DateTime(2017, 11, 12), 5),
//   new TemperatureDataClass(new DateTime(2017, 11, 15), 5),
//   new TemperatureDataClass(new DateTime(2017, 11, 17), 6),
//   new TemperatureDataClass(new DateTime(2017, 11, 19), 7),
//   new TemperatureDataClass(new DateTime(2017, 11, 21), 8),
//   new TemperatureDataClass(new DateTime(2017, 11, 23), 9),
//   new TemperatureDataClass(new DateTime(2017, 11, 25), 11),
//   new TemperatureDataClass(new DateTime(2017, 11, 27), 10),
//   new TemperatureDataClass(new DateTime(2017, 11, 29), 11),
//   new TemperatureDataClass(new DateTime(2017, 11, 31), 12),
//   new TemperatureDataClass(new DateTime(2017, 12, 1), 13),
//   new TemperatureDataClass(new DateTime(2017, 12, 3), 14),
//   new TemperatureDataClass(new DateTime(2017, 12, 4), 15),
//   new TemperatureDataClass(new DateTime(2017, 12, 5), 16),
//   new TemperatureDataClass(new DateTime(2017, 12, 7), 17),
//   new TemperatureDataClass(new DateTime(2017, 12, 9), 18),
//   new TemperatureDataClass(new DateTime(2017, 12, 11), 19),
//   new TemperatureDataClass(new DateTime(2017, 12, 14), 20),
//   new TemperatureDataClass(new DateTime(2017, 12, 16), 21),
//   new TemperatureDataClass(new DateTime(2017, 12, 19), 22),
//   new TemperatureDataClass(new DateTime(2017, 12, 21), 23),
//   new TemperatureDataClass(new DateTime(2017, 12, 24), 23),
// ];

// List<charts.Series<TemperatureDataClass, DateTime>> seriesList = [
//   new charts.Series<TemperatureDataClass, DateTime>(
//     id: 'Temprature MAX',
//     colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffFAA45F)),
//     domainFn: (TemperatureDataClass obj, _) => obj.time,
//     measureFn: (TemperatureDataClass obj, _) => obj.temp,
//     data: tempraturedata1,
//   ),
//   new charts.Series<TemperatureDataClass, DateTime>(
//     id: 'Temprature Normal',
//     colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff41AFF4)),
//     domainFn: (TemperatureDataClass obj, _) => obj.time,
//     measureFn: (TemperatureDataClass obj, _) => obj.temp,
//     data: tempraturedata2,
//   )
// ];

class UserTemperaturePage extends StatefulWidget {
  Function onUpdateWidget;
  UserTemperaturePage({Key key, this.onUpdateWidget}) : super(key: key);
  @override
  _UserTemperaturePageState createState() => _UserTemperaturePageState();
}

class _UserTemperaturePageState extends State<UserTemperaturePage> {
  final List<Tab> tabcontent = <Tab>[
    Tab(text: 'Day'),
    Tab(text: 'Week'),
    Tab(text: 'Month'),
    Tab(text: 'Custom'),
  ];
  int selectedTabIndex = 0;

  var logsList;
  List<charts.Series> seriesList;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    setState(() {
      isLoading = true;
    });
    logsList = await DbServices().getListData(Strings.hiveLogName);

    if (logsList != null && logsList.length > 0) {
      seriesList = _createSampleData(logsList);
      print("Series List Lenght : ${seriesList.length}");
      setState(() {
        isLoading = false;
      });
    }
  }

  DateTime getCurrentdate = DateTime.now();
  getdate() {
    print(getCurrentdate);

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    var newDate = new DateTime(now.year, now.month, now.day - 7);
    print(formatted);
    print(formatter.format(newDate)); // something like 2013-04-20
  }

  List<charts.Series<TemperatureDataClass, DateTime>> _createSampleData(
      logsList) {
    List<TemperatureDataClass> tempraturedata1 = List<TemperatureDataClass>();
    //List<TemperatureDataClass> tempraturedata2 = List<TemperatureDataClass>();
    if (logsList != null && logsList.length > 0) {
      for (int i = 0; i < logsList.length; i++) {
        tempraturedata1
            .add(new TemperatureDataClass(logsList[i].dateTime, i + 1));
        // if (double.parse(logsList[i].temprature) >= 100.0) {
        //   tempraturedata2
        //       .add(new TemperatureDataClass(logsList[i].dateTime, i + 1));
        // } else {
        //   tempraturedata1
        //       .add(new TemperatureDataClass(logsList[i].dateTime, i + 1));
        // }
      }
    }
    // final tempraturedata1 = [
    //   new TemperatureDataClass(new DateTime(2017, 10, 21), 0),
    //   new TemperatureDataClass(new DateTime(2017, 10, 23), 1),
    //   new TemperatureDataClass(new DateTime(2017, 10, 25), 2),
    //   new TemperatureDataClass(new DateTime(2017, 10, 27), 1),
    //   new TemperatureDataClass(new DateTime(2017, 10, 30), 2),
    //   new TemperatureDataClass(new DateTime(2017, 11, 2), 3),
    //   new TemperatureDataClass(new DateTime(2017, 11, 4), 4),
    //   new TemperatureDataClass(new DateTime(2017, 11, 5), 4),
    //   new TemperatureDataClass(new DateTime(2017, 11, 7), 4),
    //   new TemperatureDataClass(new DateTime(2017, 11, 9), 3),
    //   new TemperatureDataClass(new DateTime(2017, 11, 11), 3),
    //   new TemperatureDataClass(new DateTime(2017, 11, 12), 3),
    //   new TemperatureDataClass(new DateTime(2017, 11, 15), 3),
    //   new TemperatureDataClass(new DateTime(2017, 11, 17), 5),
    //   new TemperatureDataClass(new DateTime(2017, 11, 19), 5),
    //   new TemperatureDataClass(new DateTime(2017, 11, 21), 4),
    //   new TemperatureDataClass(new DateTime(2017, 11, 23), 4),
    //   new TemperatureDataClass(new DateTime(2017, 11, 25), 4),
    //   new TemperatureDataClass(new DateTime(2017, 11, 27), 5),
    //   new TemperatureDataClass(new DateTime(2017, 11, 31), 5),
    //   new TemperatureDataClass(new DateTime(2017, 12, 1), 5),
    //   new TemperatureDataClass(new DateTime(2017, 12, 2), 6),
    //   new TemperatureDataClass(new DateTime(2017, 12, 4), 7),
    //   new TemperatureDataClass(new DateTime(2017, 12, 5), 8),
    //   new TemperatureDataClass(new DateTime(2017, 12, 7), 9),
    //   new TemperatureDataClass(new DateTime(2017, 12, 9), 10),
    //   new TemperatureDataClass(new DateTime(2017, 12, 11), 11),
    //   new TemperatureDataClass(new DateTime(2017, 12, 14), 12),
    //   new TemperatureDataClass(new DateTime(2017, 12, 16), 13),
    //   new TemperatureDataClass(new DateTime(2017, 12, 19), 14),
    //   new TemperatureDataClass(new DateTime(2017, 12, 21), 15),
    //   new TemperatureDataClass(new DateTime(2017, 12, 24), 16),
    // ];

    // final tempraturedata2 = [
    //   new TemperatureDataClass(new DateTime(2017, 10, 21), 5),
    //   new TemperatureDataClass(new DateTime(2017, 10, 23), 5),
    //   new TemperatureDataClass(new DateTime(2017, 10, 25), 2),
    //   new TemperatureDataClass(new DateTime(2017, 10, 27), 2),
    //   new TemperatureDataClass(new DateTime(2017, 10, 30), 3),
    //   new TemperatureDataClass(new DateTime(2017, 11, 2), 3),
    //   new TemperatureDataClass(new DateTime(2017, 11, 4), 3),
    //   new TemperatureDataClass(new DateTime(2017, 11, 5), 3),
    //   new TemperatureDataClass(new DateTime(2017, 11, 7), 5),
    //   new TemperatureDataClass(new DateTime(2017, 11, 9), 5),
    //   new TemperatureDataClass(new DateTime(2017, 11, 11), 5),
    //   new TemperatureDataClass(new DateTime(2017, 11, 12), 5),
    //   new TemperatureDataClass(new DateTime(2017, 11, 15), 5),
    //   new TemperatureDataClass(new DateTime(2017, 11, 17), 6),
    //   new TemperatureDataClass(new DateTime(2017, 11, 19), 7),
    //   new TemperatureDataClass(new DateTime(2017, 11, 21), 8),
    //   new TemperatureDataClass(new DateTime(2017, 11, 23), 9),
    //   new TemperatureDataClass(new DateTime(2017, 11, 25), 11),
    //   new TemperatureDataClass(new DateTime(2017, 11, 27), 10),
    //   new TemperatureDataClass(new DateTime(2017, 11, 29), 11),
    //   new TemperatureDataClass(new DateTime(2017, 11, 31), 12),
    //   new TemperatureDataClass(new DateTime(2017, 12, 1), 13),
    //   new TemperatureDataClass(new DateTime(2017, 12, 3), 14),
    //   new TemperatureDataClass(new DateTime(2017, 12, 4), 15),
    //   new TemperatureDataClass(new DateTime(2017, 12, 5), 16),
    //   new TemperatureDataClass(new DateTime(2017, 12, 7), 17),
    //   new TemperatureDataClass(new DateTime(2017, 12, 9), 18),
    //   new TemperatureDataClass(new DateTime(2017, 12, 11), 19),
    //   new TemperatureDataClass(new DateTime(2017, 12, 14), 20),
    //   new TemperatureDataClass(new DateTime(2017, 12, 16), 21),
    //   new TemperatureDataClass(new DateTime(2017, 12, 19), 22),
    //   new TemperatureDataClass(new DateTime(2017, 12, 21), 23),
    //   new TemperatureDataClass(new DateTime(2017, 12, 24), 23),
    // ];

    return [
      new charts.Series<TemperatureDataClass, DateTime>(
        id: 'Temprature MAX',
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffFAA45F)),
        domainFn: (TemperatureDataClass obj, _) => obj.time,
        measureFn: (TemperatureDataClass obj, _) => obj.temp,
        data: tempraturedata1,
      ),
      new charts.Series<TemperatureDataClass, DateTime>(
        id: 'Temprature Normal',
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff41AFF4)),
        domainFn: (TemperatureDataClass obj, _) => obj.time,
        measureFn: (TemperatureDataClass obj, _) => obj.temp,
        data: tempraturedata1,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: tabcontent.length,
          child: Column(
            children: [
              Container(
                height: 44,
                color: Theme.of(context).primaryColor,
                child: TabBar(
                  onTap: (int index) {
                    setState(() {
                      selectedTabIndex = index;
                    });

                    widget.onUpdateWidget(index);
                  },
                  tabs: tabcontent,
                  indicatorColor: Theme.of(context).accentColor,
                  indicatorWeight: 4,

                  // labelColor: Colors.white,
                  labelStyle: TextStyle(
                      fontSize: 14.0,
                      color: AppTheme.titleColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SF UI Display Semibold'),
                  unselectedLabelStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.titleColor.withOpacity(0.50),
                      fontFamily:
                          'SF UI Display Semibold'), //For Un-selected Tabs
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: tabcontent.map((Tab tab) {
                    final String label = tab.text.toLowerCase();
                    return label == "day"
                        ? isLoading
                            ? CustomLoader()
                            : graphWidget()
                        : label == "week"
                            ? isLoading
                                ? CustomLoader()
                                : graphWidget()
                            : label == "day"
                                ? isLoading
                                    ? CustomLoader()
                                    : graphWidget()
                                : graphWidget();
                  }).toList(),
                ),
              ),
            ],
          )),
    );
  }

  printLabel(String label) {}
  Widget graphWidget() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Temperature \u00B0F',
                  style: TextStyle(
                      fontFamily: "SF UI Display Regular",
                      fontSize: 10.0,
                      color: AppTheme.graphTextColor,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                            color: AppTheme.graphIndictor1,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: AppTheme.graphIndictor1,
                            ))),
                    SizedBox(
                      width: 2.5,
                    ),
                    Text(
                      'Max',
                      style: TextStyle(
                          fontFamily: "SF UI Display Regular",
                          fontSize: 10.0,
                          color: AppTheme.graphTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                            color: AppTheme.graphIndictor2,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: AppTheme.graphIndictor2,
                            ))),
                    SizedBox(
                      width: 2.5,
                    ),
                    Text(
                      'Normal',
                      style: TextStyle(
                          fontFamily: "SF UI Display Regular",
                          fontSize: 10.0,
                          color: AppTheme.graphTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                            color: AppTheme.graphIndictor3,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: AppTheme.graphIndictor3,
                            ))),
                    SizedBox(
                      width: 2.5,
                    ),
                    Text(
                      'Temp',
                      style: TextStyle(
                          fontFamily: "SF UI Display Regular",
                          fontSize: 10.0,
                          color: AppTheme.graphTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ]),
              Container(
                color: Theme.of(context).backgroundColor.withOpacity(.4),
                child: SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: TemperatureGraph(seriesList: seriesList),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '  Range  (\u2109) ',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: "SF UI Display Regular",
                      fontSize: 13.0,
                      color: AppTheme.graphTextColor2,
                    ),
                  ),
                  Text(
                    '1 Reading',
                    style: TextStyle(
                      fontFamily: "SF UI Display Regular",
                      fontSize: 12.0,
                      color: AppTheme.graphTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: HeartGraphClass.withSampleData(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
