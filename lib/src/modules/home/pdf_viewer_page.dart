import 'package:flutter/material.dart';
import 'package:mobile_app/src/modules/home/createPDF.dart';
import 'package:pdf/pdf.dart';

import 'package:flutter/cupertino.dart';

import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/globals.dart' as globals;

List<dynamic> _generatePDFData() {
  return [
    {"userId": 1, "name": "John Doe", "email": "john@john.com"},
    {"userId": 2, "name": "John Doe", "email": "john@john.com"},
    {"userId": 3, "name": "John Doe", "email": "john@john.com"},
    {"userId": 4, "name": "John Doe", "email": "john@john.com"},
    {"userId": 5, "name": "John Doe", "email": "john@john.com"},
    {"userId": 6, "name": "John Doe", "email": "john@john.com"},
    {"userId": 7, "name": "John Doe", "email": "john@john.com"},
    {"userId": 8, "name": "John Doe", "email": "john@john.com"},
    {"userId": 9, "name": "John Doe", "email": "john@john.com"},
    {"userId": 10, "name": "John Doe", "email": "john@john.com"}
  ];
}

class PdfViewerPage extends StatefulWidget {
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
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
                var columns = ["Id", "Name", "Email"];
                generatePDF(columns, _generateTableData()).then((value) {
                  if (value)
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
              _generatePDFData().length,
              (index) => _getDataRow(_generatePDFData()[index]),
            ),
          ),
        ));
  }

  //_dataRow function will populate the table rows
  DataRow _getDataRow(dynamic data) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          data['userId'].toString(),
          style: TextStyle(fontSize: 14),
        )),
        DataCell(Text(
          data['name'].toString(),
          style: TextStyle(fontSize: 14),
        )),
        DataCell(Text(
          data['email'].toString(),
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
            "Id",
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
            "Name",
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
            "Email",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      )
    ];
  }

  _generateTableData() {
    List<List<String>> data = new List();
    for (dynamic d in _generatePDFData())
      data.add(<String>[d['userId'].toString(), d['name'], d['email']]);
    return data;
  }
}
