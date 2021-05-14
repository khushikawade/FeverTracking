import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/modules/home/createPDF.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';
import 'package:pdf/pdf.dart';

import 'package:flutter/cupertino.dart';

import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/globals.dart' as globals;

// List<dynamic> _generatePDFData() {
//   return [
//     {"userId": 1, "name": "John Doe", "email": "john@john.com"},
//     {"userId": 2, "name": "John Doe", "email": "john@john.com"},
//     {"userId": 3, "name": "John Doe", "email": "john@john.com"},
//     {"userId": 4, "name": "John Doe", "email": "john@john.com"},
//     {"userId": 5, "name": "John Doe", "email": "john@john.com"},
//     {"userId": 6, "name": "John Doe", "email": "john@john.com"},
//     {"userId": 7, "name": "John Doe", "email": "john@john.com"},
//     {"userId": 8, "name": "John Doe", "email": "john@john.com"},
//     {"userId": 9, "name": "John Doe", "email": "john@john.com"},
//     {"userId": 10, "name": "John Doe", "email": "john@john.com"}
//   ];
// }

class PdfViewerPage extends StatefulWidget {
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  var logsList;
  @override
  void initState() {
    getLogs();
    super.initState();
  }

  // get Logs List
  getLogs() async {
    logsList = await DbServices().getListData(Strings.hiveLogName);
    print("Lenght : ${logsList.length}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        // backgroundColor: Color(0xff463DC7),
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'PDF Viewer',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.title,
                  letterSpacing: 0,
                  fontSize: globals.deviceType == 'phone' ? 20 : 28,
                  fontFamily: 'SF UI Display Semibold',
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            size: 30.0,
            color: AppTheme.iconColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                var columns = [
                  "Temperature",
                  "Symptoms",
                  "Position",
                  "Date",
                  "Dosage",
                  "Description"
                ];
                generatePDF(columns, _generateTableData()).then((value) {
                  if (value != null)
                    print("Success -----------");
                  else
                    print("Fail -----------");
                });
              },
              icon: Icon(
                const IconData(0xe809, fontFamily: "FeverTrackingIcons"),
                // color:AppTheme.iconColor,
                size: 24,
              ),
            ),
          )
        ],
      ),
      body: makePDF(),
    );
  }

  // make PDF Widget View
  Widget makePDF() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            headingRowHeight: 30,
            columnSpacing: MediaQuery.of(context).size.width / 4,
            dataRowHeight: 35,
            sortAscending: true,
            columns: tableColumns(),
            rows: List.generate(
              logsList != null && logsList.length > 0 ? logsList.length : 0,
              (index) => _getDataRow(logsList != null && logsList.length > 0
                  ? logsList[index]
                  : null),
            ),
          ),
        ));
  }

  //_dataRow function will populate the table rows
  DataRow _getDataRow(dynamic data) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          data.temprature != null && data.temprature.isNotEmpty
              ? data.temprature.toString()
              : '',
          style: TextStyle(fontSize: 14),
        )),
        DataCell(Text(
          data.symptoms != null && data.symptoms.isNotEmpty
              ? data.symptoms.toString()
              : "",
          style: TextStyle(fontSize: 14),
        )),
        DataCell(Text(
          data.position != null && data.position.isNotEmpty
              ? data.position.toString()
              : '',
          style: TextStyle(fontSize: 14),
        )),
        DataCell(Text(
          data.dateTime != null
              ? DateFormat('dd-MM-yyyy')
                  .format(DateTime.parse(data.dateTime.toString()))
                  .toString()
              : '',
          style: TextStyle(fontSize: 14),
        )),
        DataCell(Text(
          data.addMedinceLog != null
              ? data.addMedinceLog.medicineName != null &&
                      data.addMedinceLog.medicineName.isNotEmpty &&
                      data.addMedinceLog.dosage != null &&
                      data.addMedinceLog.dosage.isNotEmpty
                  ? '${data.addMedinceLog.medicineName}, ${data.addMedinceLog.dosage}'
                  : data.addMedinceLog.medicineName != null &&
                          data.addMedinceLog.medicineName.isNotEmpty
                      ? '${data.addMedinceLog.medicineName}'
                      : data.addMedinceLog.dosage != null &&
                              data.addMedinceLog.dosage.isNotEmpty
                          ? '${data.addMedinceLog.dosage}'
                          : ''
              : "",
          style: TextStyle(fontSize: 14),
        )),
        DataCell(Text(
          data.addNotehere != null && data.addNotehere.isNotEmpty
              ? data.addNotehere.toString()
              : '',
          style: TextStyle(fontSize: 14),
        )),
      ],
    );
  }

  //function to populate table columns
  List<DataColumn> tableColumns() {
    return [
      DataColumn(
        label: Padding(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: Text(
            "Temperature",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Padding(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: Text(
            "Symptoms",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Padding(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: Text(
            "Position",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Padding(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: Text(
            "Date",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Padding(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: Text(
            "Dosage",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Padding(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: Text(
            "Description",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ];
  }

  _generateTableData() {
    List<List<String>> data = new List();
    for (dynamic d in logsList != null && logsList.length > 0 ? logsList : null)
      data.add(<String>[
        d.temprature != null && d.temprature.isNotEmpty
            ? d.temprature.toString()
            : '',
        d.symptoms != null && d.symptoms.isNotEmpty
            ? d.symptoms.toString()
            : "",
        d.position != null && d.position.isNotEmpty
            ? d.position.toString()
            : '',
        d.dateTime != null
            ? DateFormat('dd-MM-yyyy')
                .format(DateTime.parse(d.dateTime.toString()))
                .toString()
            : '',
        d.addMedinceLog != null
            ? d.addMedinceLog.medicineName != null &&
                    d.addMedinceLog.medicineName.isNotEmpty &&
                    d.addMedinceLog.dosage != null &&
                    d.addMedinceLog.dosage.isNotEmpty
                ? '${d.addMedinceLog.medicineName}, ${d.addMedinceLog.dosage}'
                : d.addMedinceLog.medicineName != null &&
                        d.addMedinceLog.medicineName.isNotEmpty
                    ? '${d.addMedinceLog.medicineName}'
                    : d.addMedinceLog.dosage != null &&
                            d.addMedinceLog.dosage.isNotEmpty
                        ? '${d.addMedinceLog.dosage}'
                        : ''
            : "",
        d.addNotehere != null && d.addNotehere.isNotEmpty
            ? d.addNotehere.toString()
            : '',
      ]);
    return data;
  }
}
