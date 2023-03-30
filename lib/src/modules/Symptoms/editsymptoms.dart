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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      Utility.showSnackBar(
          _scaffoldKey, 'Symptoms updated successfully', context);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop(1);
      });
    }
  }

  String selectedUnit = "";
  String selectedFrequency = "";

  bool fromHomePage;
  var distinctIds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: AppTheme.textColor2,
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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: IconButton(
        //       onPressed: () {
        //         if ((symptomsController != null) &&
        //                 (symptomsController.text.isNotEmpty)
        //             // &&
        //             // (symptomsController.text != widget.sysmptomsItem)

        //             ) {
        //           String item = symptomsController.text;

        //           final updateItem = SymptomsModel(item);
        //           updateSysmptomsList(widget.index, updateItem);
        //         }
        //       },
        //       icon: Icon(
        //         const IconData(59809, fontFamily: "MaterialIcons"),
        //         color: AppTheme.iconColor,
        //         size: 24,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Container(
        color: AppTheme.subHeadingbackgroundcolor,
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
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 30, top: 20),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  cursorColor: AppTheme.textColor2,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: symptomsController,
                  decoration: InputDecoration(
                    hintText: 'Enter Symptoms Name',
                    // border: InputBorder.none,
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    // errorBorder: InputBorder.none,
                    // disabledBorder: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppTheme.textColor2, width: 1.5),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppTheme.subHeadingTextColor, width: 1.5),
                    ),
                    contentPadding:
                        EdgeInsets.only(left: 0, bottom: 8, top: 8, right: 0),
                    hintStyle: TextStyle(
                        color: AppTheme.subHeadingTextColor,
                        fontFamily: "SF UI Display Regular",
                        fontSize: globals.deviceType == "phone" ? 16 : 24),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter symptoms   ';
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                      color: AppTheme.contentColor1,
                      fontFamily: "SF UI Display Regular",
                      fontSize: globals.deviceType == "phone" ? 16 : 24),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _submit();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
              child: new Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                color: Theme.of(context).primaryColor,
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Text(
                        "Update Symptoms",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "SF UI Display",
                          color: Colors.white,
                          fontSize: globals.deviceType == "phone" ? 17 : 25,
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      if ((symptomsController != null) && (symptomsController.text.isNotEmpty)
          // &&
          // (symptomsController.text != widget.sysmptomsItem)

          ) {
        String item = symptomsController.text;

        final updateItem = SymptomsModel(item);
        updateSysmptomsList(widget.index, updateItem);
      }

      form.save();
    }
  }
}
