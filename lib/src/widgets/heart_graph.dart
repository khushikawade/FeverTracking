import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:mobile_app/src/widgets/model/heart_data_model.dart';

class HeartGraphClass extends StatelessWidget {
  List<charts.Series<HeartDataClass, DateTime>> seriesList;

  HeartGraphClass({Key key, this.seriesList}) : super(key: key);
  // final List<charts.Series> seriesList;
  // final bool animate;

  // HeartGraphClass(this.seriesList, {this.animate});

  // factory HeartGraphClass.withSampleData() {
  //   return new HeartGraphClass(
  //     _createSampleData(),
  //     animate: false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> string = ["Min", "Avg", "Max"];

    final labels = charts.BasicNumericTickFormatterSpec((num value) {
      var index = value.floor();

      return (index < string.length)
          ? '${string[index]}'
          : index == 50
              ? 'Avg'
              : "Max";
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
        animate: false,
        primaryMeasureAxis: new charts.NumericAxisSpec(
          tickFormatterSpec: labels,
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
            zeroBound: false,
            dataIsInWholeNumbers: false,
            desiredTickCount: 3,
          ),
        ),

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

  // static List<charts.Series<HeartDataClass, DateTime>> _createSampleData() {
  //   final data = [
  //     new HeartDataClass(new DateTime(2017, 9, 28), 0),
  //     new HeartDataClass(new DateTime(2017, 9, 29), 1),
  //     new HeartDataClass(new DateTime(2017, 9, 30), 1),
  //     new HeartDataClass(new DateTime(2017, 10, 01), 1),
  //     new HeartDataClass(new DateTime(2017, 10, 02), 1),
  //     new HeartDataClass(new DateTime(2017, 10, 03), 1),
  //     new HeartDataClass(new DateTime(2017, 10, 04), 1),
  //     new HeartDataClass(new DateTime(2017, 10, 05), 1),
  //     new HeartDataClass(new DateTime(2017, 10, 06), 1),
  //     new HeartDataClass(new DateTime(2017, 10, 07), 1),
  //     new HeartDataClass(new DateTime(2017, 10, 08), 1),
  //     new HeartDataClass(new DateTime(2017, 10, 09), 1),
  //     new HeartDataClass(new DateTime(2017, 10, 10), 1),
  //     new HeartDataClass(new DateTime(2017, 10, 11), 0),
  //     new HeartDataClass(new DateTime(2017, 10, 11), 2),
  //   ];

  //   return [
  //     new charts.Series<HeartDataClass, DateTime>(
  //       id: ' Heart',
  //       colorFn: (__, _) =>
  //           charts.ColorUtil.fromDartColor(Color.fromRGBO(144, 238, 126, 1)),
  //       domainFn: (HeartDataClass object, _) => object.timeStamp,
  //       measureFn: (HeartDataClass object, _) => object.range,
  //       data: data,
  //     )
  //   ];
  // }
}
