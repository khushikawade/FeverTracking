import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/modules/Symptoms/model/symptomsmodel.dart';
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';

class EditSymptomsPage extends StatefulWidget {
  final int index;
  final String sysmptomsItem;

  EditSymptomsPage(
      {Key key, @required this.index, @required this.sysmptomsItem})
      : super(key: key);
  @override
  _EditSymptomsPageState createState() => _EditSymptomsPageState();
}

class _EditSymptomsPageState extends State<EditSymptomsPage> {
  TextEditingController symptomsController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    symptomsController = new TextEditingController(text: widget.sysmptomsItem);
  }

  var logsList;
  getList() async {
    logsList = await DbServices().getListData(Strings.createSymptoms);

    setState(() {});
  }

  updateSysmptomsList(index, value) async {
    bool isSuccess = await DbServices().updateListData(
      Strings.createSymptoms,
      index,
      value,
    );

    if (isSuccess != null && isSuccess) {
      Utility.showSnackBar(_scaffoldKey, 'Data Updated Successfully', context);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop(1);
      });
    }

    //       //   }
    // Hive.box('products').putAt(i,product);
    // await _personBox.then((item) {
    //   if (!item.isEmpty) {
    //     print('empty');
    //     item.putAt(0, SymptomsModel(this.symptomsController.text));
    //   }
    // }
  }

  String selectedUnit = "";
  String selectedFrequency = "";

  bool fromHomePage;
  var distinctIds;

  // void addLog(SymptomsModel log) async {
  //   bool isSuccess = await DbServices().addData(log, Strings.createSymptoms);

  //   if (isSuccess != null && isSuccess) {
  //     Utility.showSnackBar(_scaffoldKey, 'Data Added Successfully', context);
  //     Future.delayed(const Duration(seconds: 1), () {
  //       Navigator.of(context).pop();
  //       //   if (widget.fromHomePage != null && widget.fromHomePage) {
  //       //     Navigator.of(context).pop(1);
  //       //   } else {
  //       //     Navigator.of(context).pop(true);
  //       //   }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              'Edit Symptoms',
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
            Navigator.pop(context, 1);
          },
          child: Icon(
            Icons.close,
            size: 30.0,
            color: AppTheme.iconColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                if ((symptomsController != null) &&
                        (symptomsController.text.isNotEmpty)
                    // &&
                    // (symptomsController.text != widget.sysmptomsItem)

                    ) {
                  String item = symptomsController.text;

                  final updateItem = SymptomsModel(item);
                  updateSysmptomsList(widget.index, updateItem);
                  // addLog(log);
                } else {
                  Utility.showSnackBar(
                      _scaffoldKey, 'Please Update  Field ', context);
                }
              },
              icon: Icon(
                const IconData(59809, fontFamily: "MaterialIcons"),
                color: AppTheme.iconColor,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 2, bottom: 2),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppTheme.subHeadingbackgroundcolor,
              boxShadow: [
                const BoxShadow(
                  color: AppTheme.subHeadingbackgroundcolor2,
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(0, -0.5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: symptomsController,
                decoration: InputDecoration(
                  hintText: 'Enter Symptoms Name',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 0, bottom: 8, top: 8, right: 0),
                  hintStyle: TextStyle(
                      color: AppTheme.subHeadingTextColor,
                      fontFamily: "SF UI Display Regular",
                      fontSize: globals.deviceType == "phone" ? 16 : 24),
                ),
                style: TextStyle(
                    color: AppTheme.contentColor1,
                    fontFamily: "SF UI Display Regular",
                    fontSize: globals.deviceType == "phone" ? 16 : 24),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
