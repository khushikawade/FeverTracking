import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(HomePage());

class PointModel {
  final String name;
  final int pointX;
  final int pointY;

  PointModel({this.name, this.pointX, this.pointY});
}

class Config {
  static List<PointModel> _chartDataList = [];
  static bool _isDataloaded = false;

  static isLoaded() {
    return _isDataloaded;
  }

  static loadChartDataList() async {
    // fetch data from web ...
    await loadFromWeb();
    _isDataloaded = true;
  }

  static loadFromWeb() {
    // but here i will add test data
    _chartDataList.add(PointModel(pointX: 0, pointY: 24));
    _chartDataList.add(PointModel(pointX: 12, pointY: 40));
    _chartDataList.add(PointModel(pointX: 20, pointY: 18));
    _chartDataList.add(PointModel(pointX: 23, pointY: 30));
    _chartDataList.add(PointModel(pointX: 40, pointY: 12));
    _chartDataList.add(PointModel(pointX: 60, pointY: 15));
  }

  static getChartDataList() {
    if (!_isDataloaded) loadChartDataList();
    return _chartDataList;
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<PointModel, int>> _chartDataSeries = [];
  List<PointModel> chartDataList = [];
  Widget lineChart = Text("Loading ...");

  @override
  Widget build(BuildContext context) {
    // this is where i use Config class to perform my asynchronous load data
    // and check if it's loaded so this section will occur only once
    if (!Config.isLoaded())
      Config.loadChartDataList().then((value) =>

          // call the setState() to tell flutter that it should re-evaluate the widget tree based
          // on this code changing the state of the class (the vars i.e. lineChart) and decide if
          // it wants to redraw, this is the reason to put lineChart as a var of the class
          // so when it changes - it changes the class state
          setState(() {
            print("Finished loading Json config from web!");
            chartDataList = Config.getChartDataList();

            // construct you'r chart data series
            _chartDataSeries.add(
              charts.Series(
                colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.blue),
                id: 'My test Chart',
                data: chartDataList,
                domainFn: (PointModel pointModel, _) => pointModel.pointX,
                measureFn: (PointModel pointModel, _) => pointModel.pointY,
              ),
            );

            // now change the 'Loading...' widget with the real chart widget
            lineChart = charts.LineChart(_chartDataSeries,
                defaultRenderer: new charts.LineRendererConfig(
                    includeArea: true, stacked: true),
                animate: true,
                animationDuration: Duration(seconds: 2),
                behaviors: [
                  new charts.ChartTitle('Y axis name',
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleOutsideJustification:
                          charts.OutsideJustification.middleDrawArea),
                  new charts.ChartTitle('X axis name',
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleOutsideJustification:
                          charts.OutsideJustification.middleDrawArea),
                ]);
          }));

    // here return your widget where the chart is drawn
    return MaterialApp(
      home: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Hello world line chart',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff747A80)),
                ),
                Expanded(
                  child: lineChart,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
