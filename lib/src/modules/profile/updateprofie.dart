import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/Symptoms/symptom.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mobile_app/src/modules/profile/Model/profilemodel.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';

class UpdateProfielPage extends StatefulWidget {
  @override
  _UpdateProfielPageState createState() => _UpdateProfielPageState();
}

class _UpdateProfielPageState extends State<UpdateProfielPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  String _username;
  int _phone;
  int age;

  String _genderRadioBtnVal = 'Male';

  void _handleGenderChange(String value) {
    setState(() {
      _genderRadioBtnVal = value;
    });
  }

  final TextEditingController _Namecontroller = new TextEditingController();
  final TextEditingController _Phonecontroller = new TextEditingController();
  final TextEditingController _agecontroller = new TextEditingController();
  final TextEditingController _gendercontroller = new TextEditingController();

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  void addLog(ProfileModel log) async {
    print(log);
    bool isSuccess = await DbServices().addData(log, Strings.updateProile);

    if (isSuccess != null && isSuccess) {
      globals.isProfileset = true;
      Utility.showSnackBar(_scaffold, 'Data Added Successfully', context);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop();
        //   if (widget.fromHomePage != null && widget.fromHomePage) {
        //     Navigator.of(context).pop(1);
        //   } else {
        //     Navigator.of(context).pop(true);
        //   }
      });
    }
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      _getitem();
      // addLog(log);
    }
  }

  void _getitem() {
    print(_username);
    print(_phone);
    print(age);
    print(_genderRadioBtnVal);
    final item = ProfileModel(_username, _phone, age, _genderRadioBtnVal);

    addLog(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffold,
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text(
            'Update Profile Page',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppTheme.titleColor,
                letterSpacing: 0,
                fontSize: globals.deviceType == 'phone' ? 20 : 28,
                fontFamily: 'SF UI Display Semibold',
                fontWeight: FontWeight.w600),
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
        ),
        backgroundColor: AppTheme.screenbackGroundColor,
        body: ListView(children: [
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Theme(
                      data: new ThemeData(
                        primaryColor: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: TextFormField(
                          controller: _Namecontroller,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'This field is required   ';
                            } else if (val.length > 0 && val.length < 6) {
                              return 'Please Enter a Valid Name ';
                            }

                            return null;
                          },
                          onSaved: (val) => _username = val,
                          style: TextStyle(
                            color: AppTheme.textColor1,
                            fontFamily: 'SF UI Display Bold',
                            fontSize: 14.0,
                          ),
                          decoration: InputDecoration(
                            labelText: 'NAME',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'SF UI Display Bold',
                              color: AppTheme.textColor1,
                            ),
                          ),
                        ),
                      )),
                  new Theme(
                      data: new ThemeData(
                        primaryColor: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'This field is required ';
                            } else if (val.length > 0 && val.length < 10) {
                              return 'Enter a 10 Digit vaild Number';
                            }

                            return null;
                          },
                          onSaved: (val) => _phone = num.tryParse(val),
                          style: TextStyle(
                            color: AppTheme.textColor1,
                            fontFamily: 'SF UI Display Bold',
                            fontSize: 14.0,
                          ),
                          decoration: InputDecoration(
                            labelText: 'PHONE NUMBER ',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'SF UI Display Bold',
                              color: AppTheme.textColor1,
                            ),
                          ),
                        ),
                      )),
                  new Theme(
                    data: new ThemeData(
                      primaryColor: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: TextFormField(
                        controller: _agecontroller,
                        style: TextStyle(
                          color: AppTheme.textColor1,
                          fontFamily: 'SF UI Display Bold',
                          fontSize: 14.0,
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (val) => age = num.tryParse(val),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'This field is required ';
                          } else if (int.parse(val) < 0 ||
                              int.parse(val) > 100) {
                            return 'Please Enter a Valid Age';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Age ',
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'SF UI Display Bold',
                            color: AppTheme.textColor1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          'Gender',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio<String>(
                          value: "Male",
                          groupValue: _genderRadioBtnVal,
                          onChanged: _handleGenderChange,
                        ),
                        new Text(
                          'Male',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio<String>(
                          value: "Female",
                          groupValue: _genderRadioBtnVal,
                          onChanged: _handleGenderChange,
                        ),
                        new Text(
                          'Female',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        new Radio<String>(
                          value: "Other",
                          groupValue: _genderRadioBtnVal,
                          onChanged: _handleGenderChange,
                        ),
                        new Text(
                          'Other',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.7,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    // width: MediaQuery.of(context).size.width * 60,
                    decoration: BoxDecoration(
                      color: AppTheme.dividerColor,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      new Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              _submit();
                              print("upper");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 50),
                              child: new Container(
                                height: 60,
                                alignment: Alignment.center,
                                color: Theme.of(context).accentColor,
                                child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Text(
                                        "Update Profile",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "SF UI Display",
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              )),
        ]));
  }
}
