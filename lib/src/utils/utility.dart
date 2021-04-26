import 'dart:async';

import 'package:flutter/material.dart';

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
}
