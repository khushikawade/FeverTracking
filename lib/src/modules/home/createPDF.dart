import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart' as material;
import 'package:intl/intl.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const PdfColor blue = PdfColor.fromInt(0xff463DC7); //darker background color
const PdfColor lightblue =
    PdfColor.fromInt(0xffFAA45F); //light background color

const _darkColor = PdfColor.fromInt(0xff242424);
const _lightColor = PdfColor.fromInt(0xff9D9D9D);
const PdfColor baseColor = PdfColor.fromInt(0xff463DC7);
const PdfColor _baseTextColor = PdfColor.fromInt(0xffffffff);
const PdfColor accentColor = PdfColor.fromInt(0xff463DC7);

//create pdf file
Future<File> generatePDF(
    List<String> columns, List<List<String>> tableData) async {
  final PageTheme pageTheme = await _myPageTheme(PdfPageFormat.a3);

  Widget headerWidget = pdfHeader();

  final Document pdf = Document();
  pdf.addPage(
    pw.Page(
      //pageFormat: PdfPageFormat.a4,
      // pageTheme: pageTheme,
      build: (pw.Context context) => pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          mainAxisSize: pw.MainAxisSize.max,
          children: [
            pw.Header(
              level: 0,
              child: headerWidget,
            ),
            pw.Table.fromTextArray(
              context: context,
              border: null,
              headerAlignment: Alignment.centerLeft,
              cellAlignment: Alignment.centerLeft,
              headerDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: baseColor,
              ),
              headerHeight: 25,
              cellHeight: 30,
              headerStyle: TextStyle(
                color: _baseTextColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              cellStyle: const TextStyle(
                color: _darkColor,
                fontSize: 10,
              ),
              rowDecoration: BoxDecoration(
                border: Border.all(
                  //bottom: true,
                  color: accentColor,
                  width: .5,
                ),
              ),
              headers: List<String>.generate(
                columns.length,
                (col) {
                  return columns[col];
                },
              ),
              data: List<List<String>>.generate(
                tableData.length,
                (row) => List<String>.generate(
                  columns.length,
                  (col) {
                    return tableData[row][col];
                  },
                ),
              ),
            ),
          ]),
    ),

    // MultiPage(
    //     pageTheme: pageTheme,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     header: (Context context) {
    //       if (context.pageNumber == 1) {
    //         return null;
    //       }
    //       return Container();
    //     },
    //     footer: (Context context) {
    //       return Container(
    //           alignment: Alignment.centerRight,
    //           margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
    //           child: Text(
    //               'Page ${context.pageNumber} of ${context.pagesCount}',
    //               style: Theme.of(context)
    //                   .defaultTextStyle
    //                   .copyWith(color: PdfColors.grey)));
    //     },
    //     build: (Context context) => <Widget>[
    //           Header(
    //             level: 0,
    //             child: headerWidget,
    //           ),
    //           Table.fromTextArray(
    //             context: context,
    //             border: null,
    //             headerAlignment: Alignment.centerLeft,
    //             cellAlignment: Alignment.centerLeft,
    //             headerDecoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(2),
    //               color: baseColor,
    //             ),
    //             headerHeight: 25,
    //             cellHeight: 30,
    //             headerStyle: TextStyle(
    //               color: _baseTextColor,
    //               fontSize: 10,
    //               fontWeight: FontWeight.bold,
    //             ),
    //             cellStyle: const TextStyle(
    //               color: _darkColor,
    //               fontSize: 10,
    //             ),
    //             rowDecoration: BoxDecoration(
    //               border: Border.all(
    //                 //bottom: true,
    //                 color: accentColor,
    //                 width: .5,
    //               ),
    //             ),
    //             headers: List<String>.generate(
    //               columns.length,
    //               (col) {
    //                 return columns[col];
    //               },
    //             ),
    //             data: List<List<String>>.generate(
    //               tableData.length,
    //               (row) => List<String>.generate(
    //                 columns.length,
    //                 (col) {
    //                   return tableData[row][col];
    //                 },
    //               ),
    //             ),
    //           ),
    //         ])
  );

  File result = await downloadPDfFile(
      'medicine_log_${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}',
      pdf);
  return result;
}

downloadPDfFile(String docname, Document pdf) async {
  PermissionStatus status = await Permission.storage.request();
  if (status != PermissionStatus.granted) {
    return false;
  }
  String _fileName = docname;
  final downloadsDir = (Platform.isAndroid
      ? await _getDownloadDirectoryAndroid()
      : (await _getDownloadDirectoryIos()).path);

  //File('$downloadsDir/$_fileName.pdf').writeAsBytesSync();

  File file =
      await File('$downloadsDir/$_fileName.pdf').writeAsBytes(await pdf.save());

  //await File('$downloadsDir/$_fileName.pdf').writeAsBytes(await pdf.save());

  return file;
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

//pdf document theme
Future<PageTheme> _myPageTheme(PdfPageFormat format) async {
  return PageTheme(
    pageFormat: format.applyMargin(
        left: 2.0 * PdfPageFormat.cm,
        top: 4.0 * PdfPageFormat.cm,
        right: 2.0 * PdfPageFormat.cm,
        bottom: 2.0 * PdfPageFormat.cm),
    theme: ThemeData.withFont(
//      base: pw.Font.ttf(await rootBundle.load('assets/fonts/nexa_bold.otf')),
//      bold:
//          pw.Font.ttf(await rootBundle.load('assets/fonts/raleway_medium.ttf')),
        ),
    buildBackground: (Context context) {
      return FullPage(
        ignoreMargins: true,
        child: CustomPaint(
          size: PdfPoint(format.width, format.height),
          painter: (PdfGraphics canvas, PdfPoint size) {
            context.canvas
              ..setColor(lightblue)
              ..moveTo(0, size.y)
              ..lineTo(0, size.y - 230)
              ..lineTo(60, size.y)
              ..fillPath()
              ..setColor(blue)
              ..moveTo(0, size.y)
              ..lineTo(0, size.y - 100)
              ..lineTo(100, size.y)
              ..fillPath()
              ..setColor(lightblue)
              ..moveTo(30, size.y)
              ..lineTo(110, size.y - 50)
              ..lineTo(150, size.y)
              ..fillPath()
              ..moveTo(size.x, 0)
              ..lineTo(size.x, 230)
              ..lineTo(size.x - 60, 0)
              ..fillPath()
              ..setColor(blue)
              ..moveTo(size.x, 0)
              ..lineTo(size.x, 100)
              ..lineTo(size.x - 100, 0)
              ..fillPath()
              ..setColor(lightblue)
              ..moveTo(size.x - 30, 0)
              ..lineTo(size.x - 110, 50)
              ..lineTo(size.x - 150, 0)
              ..fillPath();
          },
        ),
      );
    },
  );
}

//pdf header body
Widget pdfHeader() {
  return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          color: PdfColors.white, borderRadius: BorderRadius.circular(6)),
      margin: EdgeInsets.only(bottom: 10, top: 10),
      padding: EdgeInsets.fromLTRB(10, 7, 10, 4),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Text("Patient Name : ",
                  style: TextStyle(fontSize: 14, color: _darkColor)),
              Text(
                "${globals.userObj[0].name}",
                style: TextStyle(
                    fontSize: 16,
                    color: _darkColor,
                    fontWeight: FontWeight.bold),
              )
            ]),
            Text("Contact No. : ${globals.userObj[0].phonenumber}",
                style: TextStyle(fontSize: 14, color: _darkColor)),
            Text("Address : ${globals.userObj[0].address}",
                style: TextStyle(fontSize: 14, color: _darkColor)),
            Divider(color: accentColor),
          ]));
}
