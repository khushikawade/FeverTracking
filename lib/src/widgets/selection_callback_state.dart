import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/widgets/model/temperature_model.dart';
import 'package:mobile_app/src/widgets/user_temp_grap.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_app/src/globals.dart' as globals;

class TemperatureGraph extends StatefulWidget {
  List<charts.Series<TemperatureDataClass, DateTime>> seriesList;

  TemperatureGraph({Key key, this.seriesList}) : super(key: key);
  // factory TemperatureGraph.withSampleData() {
  //   return new TemperatureGraph(
  //     _createSampleData(),
  //     animate: false,
  //   );
  // }

  // @override
  // State<StatefulWidget> createState() => new _SelectionCallbackState();

  _TemperatureGraphState createState() => _TemperatureGraphState();

  final ax134 = charts.NumericAxisSpec(
      renderSpec: charts.GridlineRendererSpec(
    labelStyle:
        charts.TextStyleSpec(fontSize: 10, color: charts.MaterialPalette.white),
  ));

  // static getLogList() async {
  //   var logsList = await DbServices().getListData(Strings.hiveLogName);
  //   return logsList;
  // }

  // static List<charts.Series<TemperatureDataClass, DateTime>>
  //     _createSampleData() {
  //   // var logsList = getLogList();
  //   // var tempraturedata1;
  //   // if (logsList != null && logsList.length > 0) {
  //   //   for (int i = 0; i < logsList.length; i++) {
  //   //     tempraturedata1.add(TemperatureDataClass(
  //   //         DateTime.parse(
  //   //             DateFormat('dd-MM-yyyy').format(logsList[i].dateTime)),
  //   //         int.parse(logsList[i].temprature)));
  //   //   }
  //   // }
  //   final tempraturedata1 = [
  //     new TemperatureDataClass(new DateTime(2017, 10, 21), 0),
  //     new TemperatureDataClass(new DateTime(2017, 10, 23), 1),
  //     new TemperatureDataClass(new DateTime(2017, 10, 25), 2),
  //     new TemperatureDataClass(new DateTime(2017, 10, 27), 1),
  //     new TemperatureDataClass(new DateTime(2017, 10, 30), 2),
  //     new TemperatureDataClass(new DateTime(2017, 11, 2), 3),
  //     new TemperatureDataClass(new DateTime(2017, 11, 4), 4),
  //     new TemperatureDataClass(new DateTime(2017, 11, 5), 4),
  //     new TemperatureDataClass(new DateTime(2017, 11, 7), 4),
  //     new TemperatureDataClass(new DateTime(2017, 11, 9), 3),
  //     new TemperatureDataClass(new DateTime(2017, 11, 11), 3),
  //     new TemperatureDataClass(new DateTime(2017, 11, 12), 3),
  //     new TemperatureDataClass(new DateTime(2017, 11, 15), 3),
  //     new TemperatureDataClass(new DateTime(2017, 11, 17), 5),
  //     new TemperatureDataClass(new DateTime(2017, 11, 19), 5),
  //     new TemperatureDataClass(new DateTime(2017, 11, 21), 4),
  //     new TemperatureDataClass(new DateTime(2017, 11, 23), 4),
  //     new TemperatureDataClass(new DateTime(2017, 11, 25), 4),
  //     new TemperatureDataClass(new DateTime(2017, 11, 27), 5),
  //     new TemperatureDataClass(new DateTime(2017, 11, 31), 5),
  //     new TemperatureDataClass(new DateTime(2017, 12, 1), 5),
  //     new TemperatureDataClass(new DateTime(2017, 12, 2), 6),
  //     new TemperatureDataClass(new DateTime(2017, 12, 4), 7),
  //     new TemperatureDataClass(new DateTime(2017, 12, 5), 8),
  //     new TemperatureDataClass(new DateTime(2017, 12, 7), 9),
  //     new TemperatureDataClass(new DateTime(2017, 12, 9), 10),
  //     new TemperatureDataClass(new DateTime(2017, 12, 11), 11),
  //     new TemperatureDataClass(new DateTime(2017, 12, 14), 12),
  //     new TemperatureDataClass(new DateTime(2017, 12, 16), 13),
  //     new TemperatureDataClass(new DateTime(2017, 12, 19), 14),
  //     new TemperatureDataClass(new DateTime(2017, 12, 21), 15),
  //     new TemperatureDataClass(new DateTime(2017, 12, 24), 16),
  //   ];

  //   final tempraturedata2 = [
  //     new TemperatureDataClass(new DateTime(2017, 10, 21), 5),
  //     new TemperatureDataClass(new DateTime(2017, 10, 23), 5),
  //     new TemperatureDataClass(new DateTime(2017, 10, 25), 2),
  //     new TemperatureDataClass(new DateTime(2017, 10, 27), 2),
  //     new TemperatureDataClass(new DateTime(2017, 10, 30), 3),
  //     new TemperatureDataClass(new DateTime(2017, 11, 2), 3),
  //     new TemperatureDataClass(new DateTime(2017, 11, 4), 3),
  //     new TemperatureDataClass(new DateTime(2017, 11, 5), 3),
  //     new TemperatureDataClass(new DateTime(2017, 11, 7), 5),
  //     new TemperatureDataClass(new DateTime(2017, 11, 9), 5),
  //     new TemperatureDataClass(new DateTime(2017, 11, 11), 5),
  //     new TemperatureDataClass(new DateTime(2017, 11, 12), 5),
  //     new TemperatureDataClass(new DateTime(2017, 11, 15), 5),
  //     new TemperatureDataClass(new DateTime(2017, 11, 17), 6),
  //     new TemperatureDataClass(new DateTime(2017, 11, 19), 7),
  //     new TemperatureDataClass(new DateTime(2017, 11, 21), 8),
  //     new TemperatureDataClass(new DateTime(2017, 11, 23), 9),
  //     new TemperatureDataClass(new DateTime(2017, 11, 25), 11),
  //     new TemperatureDataClass(new DateTime(2017, 11, 27), 10),
  //     new TemperatureDataClass(new DateTime(2017, 11, 29), 11),
  //     new TemperatureDataClass(new DateTime(2017, 11, 31), 12),
  //     new TemperatureDataClass(new DateTime(2017, 12, 1), 13),
  //     new TemperatureDataClass(new DateTime(2017, 12, 3), 14),
  //     new TemperatureDataClass(new DateTime(2017, 12, 4), 15),
  //     new TemperatureDataClass(new DateTime(2017, 12, 5), 16),
  //     new TemperatureDataClass(new DateTime(2017, 12, 7), 17),
  //     new TemperatureDataClass(new DateTime(2017, 12, 9), 18),
  //     new TemperatureDataClass(new DateTime(2017, 12, 11), 19),
  //     new TemperatureDataClass(new DateTime(2017, 12, 14), 20),
  //     new TemperatureDataClass(new DateTime(2017, 12, 16), 21),
  //     new TemperatureDataClass(new DateTime(2017, 12, 19), 22),
  //     new TemperatureDataClass(new DateTime(2017, 12, 21), 23),
  //     new TemperatureDataClass(new DateTime(2017, 12, 24), 23),
  //   ];

  //   return [
  //     new charts.Series<TemperatureDataClass, DateTime>(
  //       id: 'Temprature MAX',
  //       colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffFAA45F)),
  //       domainFn: (TemperatureDataClass obj, _) => obj.time,
  //       measureFn: (TemperatureDataClass obj, _) => obj.temp,
  //       data: tempraturedata1,
  //     ),
  //     new charts.Series<TemperatureDataClass, DateTime>(
  //       id: 'Temprature Normal',
  //       colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff41AFF4)),
  //       domainFn: (TemperatureDataClass obj, _) => obj.time,
  //       measureFn: (TemperatureDataClass obj, _) => obj.temp,
  //       data: tempraturedata2,
  //     )
  //   ];
  // }
}

class _TemperatureGraphState extends State<TemperatureGraph> {
  DateTime _time;
  Map<String, num> _measures;
  List<charts.Series> seriesList;

  @override
  void initState() {
    super.initState();
    print("************************Graph State Calll *************");
    //_createSampleData();
    //getList();
  }

  // getList() async {
  //   var logsList = await DbServices().getListData(Strings.hiveLogName);

  //   if (logsList != null && logsList.length > 0) {
  //     seriesList = _createSampleData(logsList);

  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final labels = charts.BasicNumericTickFormatterSpec((num value) {
      var index = value.floor();

      // return (index < globals.tempertureList.length)
      //     ? '${globals.tempertureList[index]}'
      //     : 'overflow ${globals.tempertureList.length} $index';

      return (index < globals.tempertureList.length)
          ? '${globals.tempertureList[index]}'
          : '${globals.tempertureList[index - 10]}';
    });

    final children = <Widget>[
      new SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: new charts.TimeSeriesChart(
            widget.seriesList != null && widget.seriesList.length > 0
                ? widget.seriesList
                : seriesList,
            primaryMeasureAxis: new charts.NumericAxisSpec(
              tickFormatterSpec: labels,
              tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                zeroBound: false,
                dataIsInWholeNumbers: false,
                desiredTickCount: 12,
              ),
            ),
            domainAxis: new charts.DateTimeAxisSpec(
              renderSpec: charts.GridlineRendererSpec(
                labelStyle: new charts.TextStyleSpec(
                  fontSize: 10,
                  color: charts.MaterialPalette.black,
                ),
              ),
              tickProviderSpec: charts.DayTickProviderSpec(increments: [1]),
            ),
            animate: false,
            selectionModels: [
              new charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
              )
            ],
          )),
    ];

    // if (_time != null) {
    //   children.add(new Padding(
    //       padding: new EdgeInsets.only(top: 5.0),
    //       child: new Text(_time.toString())));
    // }
    // _measures?.forEach((String series, num value) {

    //   children.add(new Text('${series}: ${value}'));
    // });

    return new Column(children: children);
  }
}

// class _SelectionCallbackState extends State<TemperatureGraph> {
//   //DateTime _time;
//   //Map<String, num> _measures;

//   // _onSelectionChanged(charts.SelectionModel model) {
//   //   final selectedDatum = model.selectedDatum;

//   //   DateTime time;
//   //   final measures = <String, num>{};

//   //   if (selectedDatum.isNotEmpty) {
//   //     time = selectedDatum.first.datum.time;
//   //     selectedDatum.forEach((charts.SeriesDatum datumPair) {
//   //       measures[datumPair.series.displayName] = datumPair.datum.sales;
//   //     });
//   //   }

//   //   setState(() {
//   //     _time = time;
//   //     _measures = measures;
//   //   });
//   // }

//   // List<charts.TickSpec<num>> _createTickSpec() {
//   //   List<charts.TickSpec<num>> _tickProvidSpecs =
//   //       new List<charts.TickSpec<num>>();
//   //   double d = 90.0;
//   //   while (d <= 95.0) {
//   //     _tickProvidSpecs.add(new charts.TickSpec(d,
//   //         label: '$d%', style: charts.TextStyleSpec(fontSize: 8)));
//   //     d += 0.5;
//   //   }
//   //   return _tickProvidSpecs;
//   // }

//   // final staticTicks = <charts.TickSpec<String>>[
//   //   new charts.TickSpec(
//   //       // Value must match the domain value.
//   //       '2014',
//   //       // Optional label for this tick, defaults to domain value if not set.
//   //       label: 'Year 2014',
//   //       // The styling for this tick.
//   //       style: new charts.TextStyleSpec(
//   //           color: new charts.Color(r: 0x4C, g: 0xAF, b: 0x50))),
//   //   // If no text style is specified - the style from renderSpec will be used
//   //   // if one is specified.
//   //   new charts.TickSpec('99.0'),
//   //   new charts.TickSpec('100.0'),
//   //   new charts.TickSpec('102.0'),
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     final List<dynamic> string = [
//       97.1,
//       97.2,
//       97.3,
//       97.4,
//       97.5,
//       97.6,
//       97.8,
//       97.9,
//       98.0,
//       98.1,
//       98.2,
//       98.3,
//       98.4,
//       98.5,
//       98.6,
//       98.7,
//       98.8,
//       98.9,
//       99.0,
//       99.1,
//       99.2,
//       99.3,
//       99.4,
//       99.5,
//       99.6,
//       99.7,
//       99.8,
//       99.9,
//       100.0,
//       100.1,
//       100.2,
//       100.3,
//       100.4,
//       100.5,
//       100.6,
//       100.7,
//       100.8,
//       100.9,
//       101.0,
//       101.1,
//       101.2,
//       101.3,
//       101.4,
//       101.5,
//       101.6,
//       101.7,
//       101.8,
//       101.9,
//       102.0
//     ];

//     final labels = charts.BasicNumericTickFormatterSpec((num value) {
//       var index = value.floor();

//       return (index < string.length)
//           ? '${string[index]}'
//           : 'overflow ${string.length} $index';
//     });

//     final children = <Widget>[
//       new SizedBox(
//           height: 225.0,
//           child: new charts.TimeSeriesChart(
//             widget.seriesList,
//             // UNCOMMENT   MAKE Y AXIS  POINT  DOUBLE (0.0)
//             // primaryMeasureAxis: new charts.NumericAxisSpec(
//             //   tickProviderSpec: new charts.StaticNumericTickProviderSpec(
//             //     _createTickSpec(),
//             //   ),
//             // ),

//             primaryMeasureAxis: new charts.NumericAxisSpec(
//               tickFormatterSpec: labels,
//               tickProviderSpec: new charts.BasicNumericTickProviderSpec(
//                 zeroBound: false,
//                 dataIsInWholeNumbers: false,
//                 desiredTickCount: 12,
//               ),
//             ),

//             // primaryMeasureAxis: new charts.NumericAxisSpec(
//             //     // viewport: new charts.NumericExtents(2017, 2021),
//             //     tickProviderSpec: new charts.BasicNumericTickProviderSpec(
//             //       zeroBound: false,
//             //       dataIsInWholeNumbers: false,
//             //       desiredTickCount: 11,
//             //     ),
//             //     // tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
//             //     //   _formaterYear,
//             //     // ),
//             //     renderSpec: charts.GridlineRendererSpec(
//             //       tickLengthPx: 0,
//             //       labelOffsetFromAxisPx: 12,
//             //     )),
//             domainAxis: new charts.DateTimeAxisSpec(
//               renderSpec: charts.GridlineRendererSpec(
//                 labelStyle: new charts.TextStyleSpec(
//                   fontSize: 10,
//                   color: charts.MaterialPalette.white,
//                 ),
//               ),
//             ),
//             animate: widget.animate,
//             selectionModels: [
//               new charts.SelectionModelConfig(
//                 type: charts.SelectionModelType.info,
//               )
//             ],
//           )),
//     ];

//     if (_time != null) {
//       children.add(new Padding(
//           padding: new EdgeInsets.only(top: 5.0),
//           child: new Text(_time.toString())));
//     }
//     _measures?.forEach((String series, num value) {

//       children.add(new Text('${series}: ${value}'));
//     });

//     return new Column(children: children);
//   }
// }
