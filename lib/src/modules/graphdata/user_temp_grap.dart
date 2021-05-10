import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:flutter/material.dart';
import 'package:mobile_app/src/modules/logs/addLog.dart';
import 'package:mobile_app/src/styles/theme.dart';

class UserTemperaturePage extends StatefulWidget {
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
                        ? graphWidget()
                        : Center(
                            child: Text(
                              'This is the $label tab',
                              style: const TextStyle(fontSize: 36),
                            ),
                          );
                  }).toList(),
                ),
              ),
            ],
          )),
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
                  child: TemperatureGraph.withSampleData(),
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
// UI CODE END

// GRAPH CLASSES CODE

class TemperatureGraph extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  TemperatureGraph(this.seriesList, {this.animate});

  factory TemperatureGraph.withSampleData() {
    return new TemperatureGraph(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  State<StatefulWidget> createState() => new _SelectionCallbackState();
  final ax134 = charts.NumericAxisSpec(
      renderSpec: charts.GridlineRendererSpec(
    labelStyle:
        charts.TextStyleSpec(fontSize: 10, color: charts.MaterialPalette.white),
  ));
  static List<charts.Series<TemperatureDataClass, DateTime>>
      _createSampleData() {
    final tempraturedata1 = [
      new TemperatureDataClass(new DateTime(2017, 10, 21), 110),
      new TemperatureDataClass(new DateTime(2017, 10, 23), 120),
      new TemperatureDataClass(new DateTime(2017, 10, 25), 110),
      new TemperatureDataClass(new DateTime(2017, 10, 27), 119),
      new TemperatureDataClass(new DateTime(2017, 10, 30), 110),
      new TemperatureDataClass(new DateTime(2017, 11, 2), 110),
      new TemperatureDataClass(new DateTime(2017, 11, 4), 108),
      new TemperatureDataClass(new DateTime(2017, 11, 5), 110),
      new TemperatureDataClass(new DateTime(2017, 11, 7), 105),
      new TemperatureDataClass(new DateTime(2017, 11, 9), 102),
      new TemperatureDataClass(new DateTime(2017, 11, 11), 112),
      new TemperatureDataClass(new DateTime(2017, 11, 12), 102),
      new TemperatureDataClass(new DateTime(2017, 11, 15), 119),
      new TemperatureDataClass(new DateTime(2017, 11, 17), 112),
      new TemperatureDataClass(new DateTime(2017, 11, 19), 113),
      new TemperatureDataClass(new DateTime(2017, 11, 21), 90),
      new TemperatureDataClass(new DateTime(2017, 11, 23), 85),
      new TemperatureDataClass(new DateTime(2017, 11, 25), 86),
      new TemperatureDataClass(new DateTime(2017, 11, 27), 87),
      new TemperatureDataClass(new DateTime(2017, 11, 31), 99),
      new TemperatureDataClass(new DateTime(2017, 12, 1), 89),
      new TemperatureDataClass(new DateTime(2017, 12, 2), 79),
      new TemperatureDataClass(new DateTime(2017, 12, 4), 87),
      new TemperatureDataClass(new DateTime(2017, 12, 5), 95),
      new TemperatureDataClass(new DateTime(2017, 12, 7), 85),
      new TemperatureDataClass(new DateTime(2017, 12, 9), 95),
      new TemperatureDataClass(new DateTime(2017, 12, 11), 102),
      new TemperatureDataClass(new DateTime(2017, 12, 14), 92),
      new TemperatureDataClass(new DateTime(2017, 12, 16), 95),
      new TemperatureDataClass(new DateTime(2017, 12, 19), 102),
      new TemperatureDataClass(new DateTime(2017, 12, 21), 105),
      new TemperatureDataClass(new DateTime(2017, 12, 24), 115),
    ];

    final tempraturedata2 = [
      new TemperatureDataClass(new DateTime(2017, 10, 21), 82),
      new TemperatureDataClass(new DateTime(2017, 10, 23), 92),
      new TemperatureDataClass(new DateTime(2017, 10, 25), 82),
      new TemperatureDataClass(new DateTime(2017, 10, 27), 99),
      new TemperatureDataClass(new DateTime(2017, 10, 30), 102),
      new TemperatureDataClass(new DateTime(2017, 11, 2), 92),
      new TemperatureDataClass(new DateTime(2017, 11, 4), 106),
      new TemperatureDataClass(new DateTime(2017, 11, 5), 82),
      new TemperatureDataClass(new DateTime(2017, 11, 7), 94),
      new TemperatureDataClass(new DateTime(2017, 11, 9), 92),
      new TemperatureDataClass(new DateTime(2017, 11, 11), 102),
      new TemperatureDataClass(new DateTime(2017, 11, 12), 92),
      new TemperatureDataClass(new DateTime(2017, 11, 15), 109),
      new TemperatureDataClass(new DateTime(2017, 11, 17), 102),
      new TemperatureDataClass(new DateTime(2017, 11, 19), 103),
      new TemperatureDataClass(new DateTime(2017, 11, 21), 106),
      new TemperatureDataClass(new DateTime(2017, 11, 23), 100),
      new TemperatureDataClass(new DateTime(2017, 11, 25), 92),
      new TemperatureDataClass(new DateTime(2017, 11, 27), 94),
      new TemperatureDataClass(new DateTime(2017, 11, 29), 96),
      new TemperatureDataClass(new DateTime(2017, 11, 31), 92),
      new TemperatureDataClass(new DateTime(2017, 12, 1), 90),
      new TemperatureDataClass(new DateTime(2017, 12, 3), 89),
      new TemperatureDataClass(new DateTime(2017, 12, 4), 96),
      new TemperatureDataClass(new DateTime(2017, 12, 5), 102),
      new TemperatureDataClass(new DateTime(2017, 12, 7), 104),
      new TemperatureDataClass(new DateTime(2017, 12, 9), 92),
      new TemperatureDataClass(new DateTime(2017, 12, 11), 75),
      new TemperatureDataClass(new DateTime(2017, 12, 14), 92),
      new TemperatureDataClass(new DateTime(2017, 12, 16), 109),
      new TemperatureDataClass(new DateTime(2017, 12, 19), 102),
      new TemperatureDataClass(new DateTime(2017, 12, 21), 102),
      new TemperatureDataClass(new DateTime(2017, 12, 24), 106),
    ];

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
      )
    ];
  }
}

class _SelectionCallbackState extends State<TemperatureGraph> {
  DateTime _time;
  Map<String, num> _measures;

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime time;
    final measures = <String, num>{};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.time;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum.sales;
      });
    }

    setState(() {
      _time = time;
      _measures = measures;
    });
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      new SizedBox(
          height: 225.0,
          child: new charts.TimeSeriesChart(
            widget.seriesList,
            domainAxis: new charts.DateTimeAxisSpec(
              renderSpec: charts.GridlineRendererSpec(
                labelStyle: new charts.TextStyleSpec(
                  fontSize: 10,
                  color: charts.MaterialPalette.white,
                ),
              ),
            ),
            animate: widget.animate,
            selectionModels: [
              new charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
              )
            ],
          )),
    ];

    if (_time != null) {
      children.add(new Padding(
          padding: new EdgeInsets.only(top: 5.0),
          child: new Text(_time.toString())));
    }
    _measures?.forEach((String series, num value) {
      children.add(new Text('${series}: ${value}'));
    });

    return new Column(children: children);
  }
}

class Temperature {
  int yearval;
  double salesval;

  Temperature(this.yearval, this.salesval);
}

class TemperatureDataClass {
  final DateTime time;
  final int temp;

  TemperatureDataClass(this.time, this.temp);
}

class HeartGraphClass extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HeartGraphClass(this.seriesList, {this.animate});

  factory HeartGraphClass.withSampleData() {
    return new HeartGraphClass(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> string = ["Min", "Avg", "Max"];

    final labels = charts.BasicNumericTickFormatterSpec((num value) {
      var index = value.floor();

      return (index < string.length)
          ? '${string[index]}'
          : 'overflow ${string.length} $index';
    });

    return new charts.TimeSeriesChart(seriesList,
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate,
        primaryMeasureAxis:
            new charts.NumericAxisSpec(tickFormatterSpec: labels),
        domainAxis: new charts.DateTimeAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: new charts.TextStyleSpec(
              fontSize: 10,
              color: charts.MaterialPalette.white,
            ),
          ),
        ));
  }

  static List<charts.Series<HeartDataClass, DateTime>> _createSampleData() {
    final data = [
      new HeartDataClass(new DateTime(2017, 9, 28), 0),
      new HeartDataClass(new DateTime(2017, 9, 29), 1),
      new HeartDataClass(new DateTime(2017, 9, 30), 1),
      new HeartDataClass(new DateTime(2017, 10, 01), 1),
      new HeartDataClass(new DateTime(2017, 10, 02), 1),
      new HeartDataClass(new DateTime(2017, 10, 03), 1),
      new HeartDataClass(new DateTime(2017, 10, 04), 1),
      new HeartDataClass(new DateTime(2017, 10, 05), 1),
      new HeartDataClass(new DateTime(2017, 10, 06), 1),
      new HeartDataClass(new DateTime(2017, 10, 07), 1),
      new HeartDataClass(new DateTime(2017, 10, 08), 1),
      new HeartDataClass(new DateTime(2017, 10, 09), 1),
      new HeartDataClass(new DateTime(2017, 10, 10), 1),
      new HeartDataClass(new DateTime(2017, 10, 11), 0),
      new HeartDataClass(new DateTime(2017, 10, 11), 2),
    ];

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
}

class HeartDataClass {
  final DateTime timeStamp;
  final int range;

  HeartDataClass(this.timeStamp, this.range);
}
