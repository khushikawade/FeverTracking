import 'package:mobile_app/src/modules/logs/model/checkboxmodel.dart';
import 'package:mobile_app/src/widgets/custom-loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

// import 'modules/login/ui/login-page.dart';

var notetittleText = '';
var noteText = '';
var context;
var username;
var password;
var editData;
String registractionToken;
String token;
String pushNotification;
var userObj;
var patient; // TO store patient and provider info both
var client; // To sotre client info
var provider; // for chat lobby
var userData;
var symptomsListobj;
var link;

bool alreaySetState = false;
bool checkSubscription;
bool checkVerification;
bool isHaveData;
bool isProfileset = false;
List sEncIds = [];
var location;
bool isShowingInstruction = false;

///TEMP
var encounterProvider;

var showSwipeDemo;

String sortKey = "asc";

String deviceType;

var PharmacyHistory;

String currentRoute = "chatlobby";

void printWrapped(String text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

// logout() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   pref.setString("username", null);
//   pref.setString("first_name", null);
//   pref.setString("refresh_token", null);
//   pref.setString("access_token", null);
//   pref.setString("last_name", null);
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => LoginPage()),
//   );
// }

showSpiner(size, color) {
  return Center(
      child: SpinKitThreeBounce(
    color: color,
    size: size,
  ));
}

String date(DateTime tm) {
  DateTime today = new DateTime.now();
  Duration oneDay = new Duration(days: 1);
  Duration twoDay = new Duration(days: 2);
  Duration oneWeek = new Duration(days: 7);
  String month;

  switch (tm.month) {
    case 1:
      month = "january";
      break;
    case 2:
      month = "february";
      break;
    case 3:
      month = "march";
      break;
    case 4:
      month = "april";
      break;
    case 5:
      month = "may";
      break;
    case 6:
      month = "june";
      break;
    case 7:
      month = "july";
      break;
    case 8:
      month = "august";
      break;
    case 9:
      month = "september";
      break;
    case 10:
      month = "october";
      break;
    case 11:
      month = "november";
      break;
    case 12:
      month = "december";
      break;
  }

  Duration difference = today.difference(tm);

  if (difference.compareTo(oneDay) < 1) {
    return "today";
  } else if (difference.compareTo(twoDay) < 1) {
    return "yesterday";
  } else if (difference.compareTo(oneWeek) < 1) {
    switch (tm.weekday) {
      case 1:
        return "monday";
      case 2:
        return "tuesday";
      case 3:
        return "wednesday";
      case 4:
        return "thurdsday";
      case 5:
        return "friday";
      case 6:
        return "saturday";
      case 7:
        return "sunday";
    }
  } else if (tm.year == today.year) {
    return '$month ${tm.day}, ${tm.year}';
  } else {
    return '$month ${tm.day}, ${tm.year}';
  }
  return "";
}

String capitalize(str) {
  return "${str[0].toUpperCase()}${str.substring(1)}";
}

calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

String getUSADateFormat(picked) {
  return new DateFormat.jm().format(picked.toLocal()).toString();
}

final List<String> tempertureList = [
  "97.1",
  "97.2",
  "97.3",
  "97.4",
  "97.5",
  "97.6",
  "97.8",
  "97.9",
  "98.0",
  "98.1",
  "98.2",
  "98.3",
  "98.4",
  "98.5",
  "98.6",
  "98.7",
  "98.8",
  "98.9",
  "99.0",
  "99.1",
  "99.2",
  "99.3",
  "99.4",
  "99.5",
  "99.6",
  "99.7",
  "99.8",
  "99.9",
  "100.0",
  "100.1",
  "100.2",
  "100.3",
  "100.4",
  "100.5",
  "100.6",
  "100.7",
  "100.8",
  "100.9",
  "101.0",
  "101.1",
  "101.2",
  "101.3",
  "101.4",
  "101.5",
  "101.6",
  "101.7",
  "101.8",
  "101.9",
  "102.0",
  "102.1",
  "102.2",
  "102.3",
  "102.4",
  "102.5",
  "102.6",
  "102.7",
  "102.8",
  "102.9",
  "103.0",
  "103.1",
  "103.2",
  "103.3",
  "103.4",
  "103.5",
  "103.6",
  "103.7",
  "103.8",
  "103.9",
  "104.0",
  "104.1",
  "104.2",
  "104.3",
  "104.4",
  "104.5",
  "104.6",
  "104.7",
  "104.8",
  "104.9",
  "105.0",
  "105.1",
  "105.2",
  "105.3",
  "105.4",
  "105.5",
  "105.6",
  "105.7",
  "105.8",
  "105.9",
];

List<String> postionList = [
  " Ear ",
  " ForeHead ",
  " Underarm ",
  " Mouth ",
  " Neck ",
  " Rectum "
];

// List<CheckBoxModel> checkBoxModelList = [
//   new CheckBoxModel(id: '1', displayId: 'Sweating', checked: false),
//   new CheckBoxModel(id: '2', displayId: 'Chills and Shivering', checked: false),
//   new CheckBoxModel(id: '3', displayId: 'Headache', checked: false),
//   new CheckBoxModel(id: '4', displayId: 'Muscle Aches', checked: false),
//   new CheckBoxModel(id: '5', displayId: 'Loss of Appetite', checked: false),
//   new CheckBoxModel(id: '6', displayId: 'Irritability', checked: false),
//   new CheckBoxModel(id: '7', displayId: 'Dehydration', checked: false),
//   new CheckBoxModel(id: '8', displayId: 'General Weakness', checked: false),
//   new CheckBoxModel(
//       id: '9', displayId: 'Loss of Taste or Smell', checked: false),
//   new CheckBoxModel(id: '10', displayId: 'Cough ', checked: false),
//   new CheckBoxModel(id: '11', displayId: 'Short of Breath ', checked: false),
//   new CheckBoxModel(id: '12', displayId: 'Runny Noise ', checked: false),
//   new CheckBoxModel(id: '13', displayId: 'Sore Throat ', checked: false),
// ];

