import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:flutter/material.dart';
import 'package:mobile_app/src/modules/logs/addLog.dart';
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/utilities/strings.dart';

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

  var logsList;

  getList() async {
    logsList = await DbServices().getListData(Strings.hiveLogName);
    for (int i = 1; i < logsList.length; i++)
      debugPrint("${logsList[i].temprature}");

    // print("${logsList[0].symptomName}");

    // setState(() {});
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
              ElevatedButton(
                child: Text('GET DATA'),
                onPressed: () {
                  print('Pressed');
                  getList();
                },
              )
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
  static getLogList() async {
    var logsList = await DbServices().getListData(Strings.hiveLogName);
    return logsList;
  }

  static List<charts.Series<TemperatureDataClass, DateTime>>
      _createSampleData() {
    var logsList = getLogList();
    var tempraturedata1;
    if (logsList != null && logsList.length > 0) {
      for (int i = 0; i < logsList.length; i++) {
        tempraturedata1.add(TemperatureDataClass(
            DateTime.parse(
                DateFormat('dd-MM-yyyy').format(logsList[i].dateTime)),
            int.parse(logsList[i].temprature)));
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

  List<charts.TickSpec<num>> _createTickSpec() {
    List<charts.TickSpec<num>> _tickProvidSpecs =
        new List<charts.TickSpec<num>>();
    double d = 90.0;
    while (d <= 95.0) {
      _tickProvidSpecs.add(new charts.TickSpec(d,
          label: '$d%', style: charts.TextStyleSpec(fontSize: 8)));
      d += 0.5;
    }
    return _tickProvidSpecs;
  }

  final staticTicks = <charts.TickSpec<String>>[
    new charts.TickSpec(
        // Value must match the domain value.
        '2014',
        // Optional label for this tick, defaults to domain value if not set.
        label: 'Year 2014',
        // The styling for this tick.
        style: new charts.TextStyleSpec(
            color: new charts.Color(r: 0x4C, g: 0xAF, b: 0x50))),
    // If no text style is specified - the style from renderSpec will be used
    // if one is specified.
    new charts.TickSpec('99.0'),
    new charts.TickSpec('100.0'),
    new charts.TickSpec('102.0'),
  ];

  @override
  Widget build(BuildContext context) {
    final List<dynamic> string = [
      97.1,
      97.2,
      97.3,
      97.4,
      97.5,
      97.6,
      97.8,
      97.9,
      98.0,
      98.1,
      98.2,
      98.3,
      98.4,
      98.5,
      98.6,
      98.7,
      98.8,
      98.9,
      99.0,
      99.1,
      99.2,
      99.3,
      99.4,
      99.5,
      99.6,
      99.7,
      99.8,
      99.9,
      100.0,
      100.1,
      100.2,
      100.3,
      100.4,
      100.5,
      100.6,
      100.7,
      100.8,
      100.9,
      101.0,
      101.1,
      101.2,
      101.3,
      101.4,
      101.5,
      101.6,
      101.7,
      101.8,
      101.9,
      102.0
    ];

    final labels = charts.BasicNumericTickFormatterSpec((num value) {
      var index = value.floor();

      return (index < string.length)
          ? '${string[index]}'
          : 'overflow ${string.length} $index';
    });

    final children = <Widget>[
      new SizedBox(
          height: 225.0,
          child: new charts.TimeSeriesChart(
            widget.seriesList,
            // UNCOMMENT   MAKE Y AXIS  POINT  DOUBLE (0.0)
            // primaryMeasureAxis: new charts.NumericAxisSpec(
            //   tickProviderSpec: new charts.StaticNumericTickProviderSpec(
            //     _createTickSpec(),
            //   ),
            // ),

            primaryMeasureAxis: new charts.NumericAxisSpec(
              tickFormatterSpec: labels,
              tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                zeroBound: false,
                dataIsInWholeNumbers: false,
                desiredTickCount: 12,
              ),
            ),

            // primaryMeasureAxis: new charts.NumericAxisSpec(
            //     // viewport: new charts.NumericExtents(2017, 2021),
            //     tickProviderSpec: new charts.BasicNumericTickProviderSpec(
            //       zeroBound: false,
            //       dataIsInWholeNumbers: false,
            //       desiredTickCount: 11,
            //     ),
            //     // tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
            //     //   _formaterYear,
            //     // ),
            //     renderSpec: charts.GridlineRendererSpec(
            //       tickLengthPx: 0,
            //       labelOffsetFromAxisPx: 12,
            //     )),
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

    // List<charts.TickSpec<num>> _createTickSpec() {
    //   List<charts.TickSpec<num>> _tickProvidSpecs =
    //       new List<charts.TickSpec<num>>();
    //   double d = 97;
    //   while (d <= 102) {
    //     _tickProvidSpecs.add(new charts.TickSpec(d,
    //         label: '$d%', style: charts.TextStyleSpec(fontSize: 14)));
    //     d += 0.1;
    //   }
    // }

    return new charts.TimeSeriesChart(seriesList,
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate,
        primaryMeasureAxis:
            new charts.NumericAxisSpec(tickFormatterSpec: labels),

        // primaryMeasureAxis: new charts.NumericAxisSpec(
        //   tickProviderSpec: new charts.StaticNumericTickProviderSpec(
        //     _createTickSpec(),
        //   ),
        // ),
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
