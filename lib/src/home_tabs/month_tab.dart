import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/widgets/heart_graph.dart';
import 'package:mobile_app/src/widgets/loaderWidget.dart';
import 'package:mobile_app/src/widgets/model/heart_data_model.dart';
import 'package:mobile_app/src/widgets/model/temperature_model.dart';
import 'package:mobile_app/src/widgets/selection_callback_state.dart';

class MonthTab extends StatefulWidget {
  int selectedTabIndex;
  MonthTab({Key key, this.selectedTabIndex}) : super(key: key);
  @override
  _MonthTab createState() => _MonthTab();
}

class _MonthTab extends State<MonthTab> {
  var logsList = [];
  var newLogsList = [];
  List<charts.Series> seriesList;
  List<charts.Series> seriesListSecond;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // print('Init Callled -------------------------');
    getList();
  }

  getList() async {
    newLogsList.clear();
    logsList.clear();
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    var now = new DateTime.now();

    var now_1m = new DateTime(now.year, now.month - 1, now.day);

    logsList = await DbServices().getListData(Strings.hiveLogName);

    if (logsList != null && logsList.length > 0) {
      if (widget.selectedTabIndex == 2) {
        for (int i = 0; i < logsList.length; i++) {
          if (now_1m.isBefore(logsList[i].dateTime)) {
            newLogsList.add(logsList[i]);
          }
        }
        print("Length : ${newLogsList.length}");
      }

      seriesList = _createSampleData(newLogsList);
      seriesListSecond = _createSampleDataSecond(newLogsList);

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  List<charts.Series<TemperatureDataClass, DateTime>> _createSampleData(
      logsList) {
    List<TemperatureDataClass> tempraturedata1 = List<TemperatureDataClass>();
    List<TemperatureDataClass> tempraturedata2 = List<TemperatureDataClass>();
    List<TemperatureDataClass> tempraturedata3 = List<TemperatureDataClass>();
    if (logsList != null && logsList.length > 0) {
      for (int i = 0; i < logsList.length; i++) {
        for (int j = 0; j < globals.tempertureList.length; j++) {
          if (globals.tempertureList[j] == logsList[i].temprature) {
            if (double.parse(logsList[i].temprature) <= 97.9) {
              tempraturedata3
                  .add(new TemperatureDataClass(logsList[i].dateTime, j));
            } else if (double.parse(logsList[i].temprature) <= 99) {
              tempraturedata2
                  .add(new TemperatureDataClass(logsList[i].dateTime, j));
            } else {
              tempraturedata1
                  .add(new TemperatureDataClass(logsList[i].dateTime, j));
            }
          }
        }
      }
    }

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
        data: tempraturedata2,
      ),
      new charts.Series<TemperatureDataClass, DateTime>(
        id: 'Temprature Minimum',
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffDF3F3F)),
        domainFn: (TemperatureDataClass obj, _) => obj.time,
        measureFn: (TemperatureDataClass obj, _) => obj.temp,
        data: tempraturedata3,
      )
    ];
  }

  List<charts.Series<HeartDataClass, DateTime>> _createSampleDataSecond(
      logsList) {
    List<HeartDataClass> data = List<HeartDataClass>();

    if (logsList != null && logsList.length > 0) {
      for (int i = 0; i < logsList.length; i++) {
        for (int j = 0; j < globals.tempertureList.length; j++) {
          if (globals.tempertureList[j] == logsList[i].temprature) {
            data.add(new HeartDataClass(logsList[i].dateTime, j));
          }
        }
      }
    }

    return [
      new charts.Series<HeartDataClass, DateTime>(
        id: ' Heart',
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(144, 238, 126, 1)),
        domainFn: (HeartDataClass object, _) => object.timeStamp,
        measureFn: (HeartDataClass object, _) => object.range,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CustomLoader()
        : newLogsList != null && newLogsList.length > 0
            ? graphWidget()
            : Center(
                child: Text(
                  'Create your first report using below button.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textColor1,
                      fontFamily: "SF UI Display Regular",
                      fontSize: globals.deviceType == 'phone' ? 17 : 25),
                ),
              );
  }

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
                      fontSize: globals.deviceType == 'phone' ? 10 : 18,
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
                          fontSize: globals.deviceType == 'phone' ? 10 : 18,
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
                          fontSize: globals.deviceType == 'phone' ? 10 : 18,
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
                      'Min',
                      style: TextStyle(
                          fontFamily: "SF UI Display Regular",
                          fontSize: globals.deviceType == 'phone' ? 10 : 18,
                          color: AppTheme.graphTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ]),
              Container(
                color: Theme.of(context).backgroundColor.withOpacity(.4),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  child: seriesList != null && seriesList.length > 0
                      ? TemperatureGraph(seriesList: seriesList)
                      : Container(
                          width: 0,
                          height: 0,
                        ),
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
                      fontSize: globals.deviceType == 'phone' ? 13 : 21,
                      color: AppTheme.graphTextColor2,
                    ),
                  ),
                  Text(
                    '1 Reading',
                    style: TextStyle(
                      fontFamily: "SF UI Display Regular",
                      fontSize: globals.deviceType == 'phone' ? 12 : 20,
                      color: AppTheme.graphTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: double.infinity,
                child: seriesListSecond != null && seriesListSecond.length > 0
                    ? HeartGraphClass(seriesList: seriesListSecond)
                    : Container(
                        width: 0,
                        height: 0,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
