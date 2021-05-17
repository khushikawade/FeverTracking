import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<String> _getPathToDownload() async {
    return ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
  }

  Future<Directory> _getDownloadDirectoryIos() async {
    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }

  Future<String> _getDownloadDirectoryAndroid() async {
    return _getPathToDownload();
  }

  Future<bool> takeScreenShot(src) async {
    PermissionStatus status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      return false;
    }

    RenderRepaintBoundary boundary = src.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    Uint8List pngBytes = byteData.buffer.asUint8List();

    // File imgFile = new File('screenshot.png');
    // imgFile.writeAsBytes(pngBytes);
    bool result = await downloadFile(pngBytes, 'screenshot.png');
    // File imgFile = new File('$directory/screenshot.png');
    // imgFile.writeAsBytes(pngBytes);
    return result;
  }

  downloadFile(Uint8List pngBytes, String docname) async {
    PermissionStatus status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      return false;
    }
    String _fileName = docname;
    final downloadsDir = (Platform.isAndroid
        ? await _getDownloadDirectoryAndroid()
        : (await _getDownloadDirectoryIos()).path);

    File imgFile = new File('$downloadsDir/$_fileName');
    imgFile.writeAsBytes(pngBytes);
    //File('$downloadsDir/$_fileName').writeAsBytes(file.readAsBytes());

    return true;
  }
}
