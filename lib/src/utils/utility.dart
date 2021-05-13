import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utility {
  static Size displaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double displayHeight(BuildContext context) {
    return displaySize(context).height;
  }

  static double displayWidth(BuildContext context) {
    return displaySize(context).width;
  }

  // // convert Date
  // static String convertDate(String date) {
  //   String dateFormat =
  //       DateFormat("MMMM dd, yyyy").format(DateTime.parse(date));
  //   return dateFormat;
  // }

  static bool compareArrays(List array1, List array2) {
    if (array1.length == array2.length) {
      return array1.every((value) => array2.contains(value));
    } else {
      return false;
    }
  }

  static upliftPage(context, _scrollController) {
    var d = MediaQuery.of(context).viewInsets.bottom;
    if (d > 0) {
      Timer(
          Duration(milliseconds: 50),
          () => _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent));
    }
  }

  static String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  static void showSnackBar(_scaffoldKey, msg, context) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("$msg"),
      duration: Duration(seconds: 3),
    ));
  }

  static String timeAgoSinceDate(DateTime date, {bool numericDates = true}) {
    final date2 = DateTime.now();
    var today = DateTime(date2.year, date2.month, date2.day);
    var upcomming = DateTime(date.year, date.month, date.day);
    final difference = today.difference(upcomming);
    var dateTime;
    // if (preferenceInfo['time_format'] == "am_pm") {
    //   dateTime = DateFormat().add_jms().format(date);
    // } else {
    //   dateTime = DateFormat().add_Hms().format(date);
    // }
    if ((difference.inDays / 7).floor() >= 1) {
      return DateFormat('MMM d, yyyy').format(date).toString();
    } else if (difference.inDays >= 2) {
      return DateFormat('EEE').format(date).toString();
    } else if (difference.inDays >= 1) {
      return 'Yesterday at ' + DateFormat.jm().format(date);
    } else if (today == upcomming) {
      return DateFormat('HH:mm').format(date) ==
              DateFormat('HH:mm').format(DateTime.now())
          ? 'Just Now'
          : DateFormat.jm().format(date);
    } else {
      return DateFormat('MMM d, yyyy').format(date).toString();
    }
  }
}
