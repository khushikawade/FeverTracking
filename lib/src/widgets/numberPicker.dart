import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/modules/logs/model/logsmodel.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';
import 'package:numberpicker/numberpicker.dart';

import '../db/db_services.dart';

class DecimalExample extends StatefulWidget {
  Function onUpdateWidgetForTemp;
  DecimalExample({Key key, this.onUpdateWidgetForTemp}) : super(key: key);
  @override
  DecimalExampleState createState() => DecimalExampleState();
}

class DecimalExampleState extends State<DecimalExample> {
  double _currentDoubleValue = 97.0;
  int minValue = 97;
  int maxValue = 120;
  String newCurrentValue;
  String tempValue = '';

  @override
  void initState() {
    super.initState();
    Utility.getStringValuesSF().then((value) {
      if (value == 'C') {
        getValueOfTemp();
      }
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 35),
        Text('Temperature', style: Theme.of(context).textTheme.headline6),
        SizedBox(height: 10),
        DecimalNumberPicker(
          value: _currentDoubleValue,
          minValue: minValue,
          maxValue: maxValue,
          decimalPlaces: 2,
          // onChanged: (value) => setState(() => _currentDoubleValue = value),
          onChanged: (value) {
            setState(() {
              _currentDoubleValue = value;
            });
            print(_currentDoubleValue);

            widget.onUpdateWidgetForTemp(_currentDoubleValue);
          },
        ),
        // SizedBox(height: 32),
      ],
    );
  }

  getValueOfTemp() async {
    var logsList = await DbServices().getSelectedDateData(Strings.hiveLogName);
    for (int i = 0; i < logsList.length; i++) {
      if (logsList[i].value == 'F') {
        print("here----------------------------------");
        // double num = double.parse(logsList[i].temprature);
        // double fahrenheit = Utility.fahrenheitToCelsius(num);
        // String cel = fahrenheit.toStringAsFixed(2);
        // logsList[i].temprature = cel;
        print(_currentDoubleValue);
        _currentDoubleValue = Utility.CelsiusTofahrenheit(_currentDoubleValue);
        newCurrentValue = _currentDoubleValue.toStringAsFixed(0);
        _currentDoubleValue = double.parse(newCurrentValue);
        _currentDoubleValue = _currentDoubleValue - 1;
        print(_currentDoubleValue);
        minValue = Utility.CelsiusTofahrenheit(minValue.toDouble()).toInt();
        print(minValue);
        maxValue = Utility.CelsiusTofahrenheit(maxValue.toDouble()).toInt();
        print(maxValue);
        logsList[i].value = 'C';
        print(_currentDoubleValue);
        print("here----------------------------------999999999");
      } else {
        print("here----------------------------------77777777");
        print(_currentDoubleValue);
        _currentDoubleValue = Utility.fahrenheitToCelsius(_currentDoubleValue);
        newCurrentValue = _currentDoubleValue.toStringAsFixed(0);
        _currentDoubleValue = double.parse(newCurrentValue);
        _currentDoubleValue = _currentDoubleValue + 1;
        print(_currentDoubleValue);
        minValue = Utility.fahrenheitToCelsius(minValue.toDouble()).toInt();
        print(minValue);
        maxValue = Utility.fahrenheitToCelsius(maxValue.toDouble()).toInt();
        print(maxValue);
        logsList[i].value = 'C';
      }
      final updateItem = LogsModel(
          logsList[i].dateTime,
          logsList[i].position,
          logsList[i].temprature,
          logsList[i].symptoms,
          logsList[i].addMedinceLog,
          logsList[i].addNotehere,
          logsList[i].value);
      bool isSuccess = await DbServices().updateListData(
        Strings.hiveLogName,
        i,
        updateItem,
      );
    }
  }
}
