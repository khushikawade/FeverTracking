import 'package:mobile_app/src/widgets/custom-loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

// import 'modules/login/ui/login-page.dart';

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
var link;
bool alreaySetState = false;
bool checkSubscription;
bool checkVerification;
bool isHaveData;
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
