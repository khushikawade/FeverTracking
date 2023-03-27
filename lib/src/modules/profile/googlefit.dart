import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleFit extends StatefulWidget {
  @override
  _GoogleFitState createState() => _GoogleFitState();
}

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED
}

class _GoogleFitState extends State<GoogleFit> {
  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_NOT_FETCHED;

  @override
  void initState() {
    super.initState();
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future fetchData() async {
    /// Get everything from midnight until now
    DateTime startDate = DateTime(2020, 11, 07, 0, 0, 0);
    DateTime endDate = DateTime(2025, 11, 07, 23, 59, 59);

    HealthFactory health = HealthFactory();

    /// Define the types to get.
    List<HealthDataType> types = [
      HealthDataType.STEPS,
      HealthDataType.WEIGHT,
      HealthDataType.HEIGHT,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.DISTANCE_WALKING_RUNNING,
    ];

    setState(() => _state = AppState.FETCHING_DATA);

    /// You MUST request access to the data types before reading them
    bool accessWasGranted = await health.requestAuthorization(types);

    int steps = 0;

    if (accessWasGranted) {
      try {
        /// Fetch new data
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(startDate, endDate, types);

        /// Save all the new data points
        _healthDataList.addAll(healthData);
      } catch (e) {
        print("Caught exception in getHealthDataFromTypes: $e");
      }

      /// Filter out duplicates
      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

      /// Print the results
      _healthDataList.forEach((x) {
        print("Data point: $x");
        // steps += x.value.round;
      });

      print("Steps: $steps");

      /// Update the UI to display the results
      setState(() {
        _state =
            _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
      });
    } else {
      print("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Widget _contentFetchingData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              strokeWidth: 10,
            )),
        Text('Fetching data...')
      ],
    );
  }

  Widget _contentDataReady() {
    return ListView.builder(
        itemCount: _healthDataList.length,
        itemBuilder: (_, index) {
          HealthDataPoint p = _healthDataList[index];
          return ListTile(
            title: Text("${p.typeString}: ${p.value}"),
            trailing: Text('${p.unitString}'),
            subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
          );
        });
  }

  Widget _contentNoData() {
    return Text('No Data to show');
  }

  Widget _contentNotFetched() {
    return Text('Press the download button to fetch data');
  }

  Widget _authorizationNotGranted() {
    return Text('''Authorization not given.
        For Android please check your OAUTH2 client ID is correct in Google Developer Console.
         For iOS check your permissions in Apple Health.''');
  }

  Widget _content() {
    if (_state == AppState.DATA_READY)
      return _contentDataReady();
    else if (_state == AppState.NO_DATA)
      return _contentNoData();
    else if (_state == AppState.FETCHING_DATA)
      return _contentFetchingData();
    else if (_state == AppState.AUTH_NOT_GRANTED)
      return _authorizationNotGranted();

    return _contentNotFetched();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.file_download),
                onPressed: () {
                  // _handleSignIn();
                  fetchData();
                },
              )
            ],
          ),
          body: Center(
            child: _content(),
          )),
    );
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:mobile_app/src/styles/theme.dart';
// import 'package:mobile_app/src/globals.dart' as globals;

// class GoogleFit extends StatefulWidget {
//   @override
//   _GoogleFitState createState() => _GoogleFitState();
// }

// class _GoogleFitState extends State<GoogleFit> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           actions: <Widget>[
//             // IconButton(
//             //   icon: Icon(Icons.file_download),
//             //   onPressed: () {
//             //     // _handleSignIn();
//             //   },
//             // )
//           ],
//         ),
//         body: Center(
//             child: Container(
//                 width: MediaQuery.of(context).size.width * .65,
//                 height: MediaQuery.of(context).size.width * .72,
//                 margin: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
//                 padding:
//                     EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
//                 decoration: BoxDecoration(
//                   color: AppTheme.listbackGroundColor,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromRGBO(0, 0, 0, 0.2),
//                       spreadRadius: 0,
//                       blurRadius: 1,
//                       offset: Offset(1, 1),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       "Let's Connect with",
//                       style: TextStyle(
//                           color: AppTheme.textColor1,
//                           fontFamily: "SF UI Display Regular",
//                           fontWeight: FontWeight.w500,
//                           fontSize: globals.deviceType == 'phone' ? 17 : 25),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       "Google Fit App",
//                       style: TextStyle(
//                           color: AppTheme.textColor1,
//                           fontFamily: "SF UI Display Regular",
//                           fontWeight: FontWeight.w500,
//                           fontSize: globals.deviceType == 'phone' ? 17 : 25),
//                     ),
//                     Container(
//                       width: 100,
//                       height: 100,
//                       child: Image.asset(
//                         'assets/images/googleFitLogo.png',
//                       ),
//                     ),
//                     SizedBox(
//                       height: 38,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       margin: const EdgeInsets.all(5),
//                       width: 100,
//                       alignment: Alignment.center,
//                       color: Theme.of(context).accentColor,
//                       child: new Text(
//                         "Sync",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "SF UI Display",
//                           color: Colors.white,
//                           fontSize: globals.deviceType == "phone" ? 17 : 25,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ))));
//   }
// }







// import 'package:fit_kit/fit_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Widget> _list = [];
//   static bool needToShowAllData = false;
//   bool dayToday = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Health Package Demo.'),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             child: NotificationListener<OverscrollIndicatorNotification>(
//               onNotification: (overscroll) {
//                 overscroll.disallowGlow();
//               },
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         'Welcome to the Health Tracker App... ',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 24),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Text('Need to display full data'),
//                         Checkbox(
//                             value: needToShowAllData,
//                             onChanged: (value) {
//                               setState(() {
//                                 needToShowAllData = value;

//                                 _list.clear();
//                               });
//                               readData();
//                             }),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: RaisedButton(
//                             onPressed: () async {
//                               setState(() {
//                                 _list.clear();
//                                 dayToday = false;
//                               });

//                               readData();
//                             },
//                             child: Text(
//                               'Click Me For yesterday\'s Data.',
//                               style: TextStyle(fontSize: 12),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Expanded(
//                           child: RaisedButton(
//                             onPressed: () async {
//                               setState(() {
//                                 _list.clear();
//                                 dayToday = true;
//                               });

//                               readData();
//                             },
//                             child: Text(
//                               'Click Me For Today\'s Data.',
//                               style: TextStyle(fontSize: 12),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     if (_list.length > 0) ..._list
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<bool> readPermissions() async {
//     try {
//       final responses = await FitKit.hasPermissions([
//         DataType.HEART_RATE,
//         DataType.STEP_COUNT,
//         DataType.HEIGHT,
//         DataType.WEIGHT,
//         DataType.DISTANCE,
//         DataType.ENERGY,
//         DataType.WATER,
//         DataType.SLEEP,
//         DataType.STAND_TIME,
//         DataType.EXERCISE_TIME,
//       ]);

//       if (!responses) {
//         final value = await FitKit.requestPermissions([
//           DataType.HEART_RATE,
//           DataType.STEP_COUNT,
//           DataType.HEIGHT,
//           DataType.WEIGHT,
//           DataType.DISTANCE,
//           DataType.ENERGY,
//           DataType.WATER,
//           DataType.SLEEP,
//           DataType.STAND_TIME,
//           DataType.EXERCISE_TIME,
//         ]);

//         return value;
//       } else {
//         return true;
//       }
//     } on UnsupportedException catch (e) {
//       // thrown in case e.dataType is unsupported
//       print(e);
//       return false;
//     }
//   }

//   void readData() async {
//     bool permissionsGiven = await readPermissions();

//     if (permissionsGiven) {
//       DateTime current = DateTime.now();
//       DateTime dateFrom;
//       DateTime dateTo;
//       if (!dayToday) {
//         dateFrom = DateTime.now().subtract(Duration(
//           hours: current.hour + 24,
//           minutes: current.minute,
//           seconds: current.second,
//         ));
//         dateTo = dateFrom.add(Duration(
//           hours: 23,
//           minutes: 59,
//           seconds: 59,
//         ));
//       } else {
//         // 17 Jan 2021 12:53:64 - 12:53:5
//         dateFrom = current.subtract(Duration(
//           hours: current.hour,
//           minutes: current.minute,
//           seconds: current.second,
//         ));
//         dateTo = DateTime.now();
//       }

//       for (DataType type in DataType.values) {
//         try {
//           final results = await FitKit.read(
//             type,
//             dateFrom: dateFrom,
//             dateTo: dateTo,
//           );

//           print(type);
//           print(results);
//           addWidget(type, results);
//         } on Exception catch (ex) {
//           print(ex);
//         }
//       }
//     }
//   }

//   void addWidget(DataType type, List<FitData> data) {
//     int total = 0;

//     for (FitData datasw in data) {
//       total += datasw.value.toInt();
//     }
//     print("-------------------------- $total");

//     Widget widget = Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text('DataType -  $type '),
//                   Text('Total Value - $total ')
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: (data.length > 0)
//                   ? Column(
//                       children: map(
//                           list: data,
//                           handler: (index, FitData datas) {
//                             return Container(
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Expanded(
//                                       child: Text(
//                                         '${DateFormat("dd-MM HH:mm").format(datas.dateFrom).toString()}',
//                                         softWrap: true,
//                                       ),
//                                     ),
//                                     Text('to'),
//                                     Expanded(
//                                       child: Text(
//                                         '${DateFormat("dd-MM HH:mm").format(datas.dateTo).toString()}',
//                                         softWrap: true,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         '${datas.value is double ? datas.value.toStringAsFixed(1) : datas.value} ${getBaseUnit(type)}',
//                                         softWrap: true,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         datas.source.toString(),
//                                         softWrap: true,
//                                       ),
//                                     )
//                                   ]),
//                             );
//                           }),
//                     )
//                   : Text(' No Data Availbale'),
//             ),
//           ],
//         ));

//     setState(() {
//       _list.add(widget);
//     });
//   }

//   static List<T> map<T>({@required List list, @required Function handler}) {
//     List<T> result = [];

//     int lengthToDisplay =
//         list.length > 5 && !needToShowAllData ? 5 : list.length;

//     if (list.length > 0) {
//       for (var i = 0; i < lengthToDisplay; i++) {
//         result.add(handler(i, list[i]));
//       }
//     }

//     return result;
//   }

//   static String getBaseUnit(DataType type) {
//     switch (type) {
//       case DataType.HEART_RATE:
//         return 'count/min';
//       case DataType.STEP_COUNT:
//         return '';
//       case DataType.HEIGHT:
//         return 'meter';
//       case DataType.WEIGHT:
//         return 'kg';
//       case DataType.DISTANCE:
//         return 'meter';
//       case DataType.ENERGY:
//         return 'kilocalorie';
//       case DataType.WATER:
//         return 'litre';
//       case DataType.SLEEP:
//         return 'Sleep';
//       default:
//         return 'UnKnown';
//     }
//   }
// }