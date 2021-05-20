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

  _TemperatureGraphState createState() => _TemperatureGraphState();
}

class _TemperatureGraphState extends State<TemperatureGraph> {
  List<charts.Series> seriesList;

  @override
  void initState() {
    super.initState();
  }

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
                  color: charts.MaterialPalette.white,
                ),
              ),
            ),
            animate: false,
            selectionModels: [
              new charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
              )
            ],
          )),
    ];

    return new Column(children: children);
  }
}
