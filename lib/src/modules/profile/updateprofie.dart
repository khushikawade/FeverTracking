import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/db/db_services.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/profile/Model/profilemodel.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfielPage extends StatefulWidget {
  @override
  _UpdateProfielPageState createState() => _UpdateProfielPageState();
}

class _UpdateProfielPageState extends State<UpdateProfielPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  String fileName;
  String _username;
  String address;
  int _phone;
  int age;
  var _image;
  String selectedImage;

  String _genderRadioBtnVal = 'Male';

  void _handleGenderChange(String value) {
    setState(() {
      _genderRadioBtnVal = value;
    });
  }

  final TextEditingController _Namecontroller = new TextEditingController();
  final TextEditingController _Adresscontroller = new TextEditingController();
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
    bool isSuccess;
    print("inside add*******");
    isSuccess = await DbServices().addData(log, Strings.updateProile);

    if (isSuccess != null && isSuccess) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("ISPROFILE_UPDATED", true);

      Utility.showSnackBar(_scaffold, 'Data Added Successfully', context);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop(log.path);
      });
    }
  }

  void updateLog(ProfileModel log) async {
    bool isSuccess = await DbServices().updateListData(
      Strings.updateProile,
      0,
      log,
    );

    if (isSuccess != null && isSuccess) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("ISPROFILE_UPDATED", true);
      Utility.showSnackBar(_scaffold, 'Profile Update Successfully', context);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop(log.path);
      });
    }
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      _getitem();
    }
  }

  Future openCamera() async {
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _getitem() {
    final item = ProfileModel(
        _username,
        address,
        _phone,
        age,
        _genderRadioBtnVal,
        _image != null
            ? _image.path.split('/').last
            : globals.userObj != null && globals.userObj.length > 0
                ? globals.userObj[0].imageName
                : null,
        _image != null
            ? _image.path
            : globals.userObj != null && globals.userObj.length > 0
                ? globals.userObj[0].path
                : null);
    _isprofileUpdate(item);
  }

  void _isprofileUpdate(ProfileModel log) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool result = pref.getBool("ISPROFILE_UPDATED");
    if (result != null && result) {
      updateLog(log);
    } else {
      addLog(log);
    }
  }

  Future _imgFromGallery() async {
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();

    selectedImage = globals.userObj != null && globals.userObj.length > 0
        ? globals.userObj[0].path
        : null;
    _Namecontroller.text = globals.userObj != null && globals.userObj.length > 0
        ? globals.userObj[0].name
        : '';
    _Adresscontroller.text =
        globals.userObj != null && globals.userObj.length > 0
            ? globals.userObj[0].address
            : '';
    _Phonecontroller.text =
        globals.userObj != null && globals.userObj.length > 0
            ? globals.userObj[0].phonenumber.toString()
            : '';
    _agecontroller.text = globals.userObj != null && globals.userObj.length > 0
        ? globals.userObj[0].age.toString()
        : '';

    _genderRadioBtnVal = globals.userObj != null && globals.userObj.length > 0
        ? globals.userObj[0].gender.toString()
        : 'Male';
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
            'Update Profile',
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
              Navigator.pop(context, "pop");
            },
            child: Icon(
              Icons.close,
              size: 30.0,
              color: AppTheme.iconColor,
            ),
          ),
        ),
        backgroundColor: AppTheme.screenbackGroundColor,
        body: Container(
          margin: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                ClipPath(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 100,
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        _image == null && selectedImage == null
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(47.06),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.2),
                                      spreadRadius: 0,
                                      blurRadius: 1,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 47.06,
                                  // backgroundColor: Colors.red.withOpacity(0),

                                  backgroundImage: ExactAssetImage(
                                      'assets/images/profileimage.png'),
                                ),
                              )
                            : InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(47.06),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 47.06,
                                    child: CircleAvatar(
                                      radius: 47.06,
                                      backgroundImage: new FileImage(File(
                                          _image != null
                                              ? _image.path
                                              : selectedImage)),
                                    ),
                                  ),
                                ),
                              ),
                        GestureDetector(
                            onTap: () {
                              bottomsheet();
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 10, right: 10, bottom: 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.0,
                                ),
                                color: AppTheme.textColor2,
                                borderRadius: BorderRadius.all(Radius.circular(
                                        00.0) //                 <--- border radius here
                                    ),
                              ),
                              child: Icon(
                                const IconData(0xe800,
                                    fontFamily: "FeverTrackingIcons"),
                                // color:AppTheme.iconColor,
                                size: 24,
                                color: AppTheme.iconColor,
                              ),
                            )),
                      ],
                    ),
                  ),
                  clipper: BottomWaveClipper(),
                ),
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
                                  } else if (val.length > 0 && val.length < 4) {
                                    return 'Please Enter a Valid Name ';
                                  }

                                  return null;
                                },
                                onSaved: (val) => _username = val,
                                style: TextStyle(
                                  color: AppTheme.textColor1,
                                  fontFamily: 'SF UI Display Bold',
                                  fontSize:
                                      globals.deviceType == "phone" ? 14.0 : 22,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'NAME',
                                  labelStyle: TextStyle(
                                    fontSize: globals.deviceType == "phone"
                                        ? 14.0
                                        : 22,
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
                                controller: _Adresscontroller,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'This field is required   ';
                                  } else if (val.length > 0 &&
                                      val.length < 10) {
                                    return 'Please Enter a Valid Address ';
                                  }

                                  return null;
                                },
                                onSaved: (val) => address = val,
                                style: TextStyle(
                                  color: AppTheme.textColor1,
                                  fontFamily: 'SF UI Display Bold',
                                  fontSize:
                                      globals.deviceType == "phone" ? 14.0 : 22,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'ADDRESS',
                                  labelStyle: TextStyle(
                                    fontSize: globals.deviceType == "phone"
                                        ? 14.0
                                        : 22,
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
                                controller: _Phonecontroller,
                                keyboardType: TextInputType.phone,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'This field is required ';
                                  } else if (val.length != 10) {
                                    return 'Enter a 10 Digit vaild Number';
                                  }

                                  return null;
                                },
                                onSaved: (val) => _phone = num.tryParse(val),
                                style: TextStyle(
                                  color: AppTheme.textColor1,
                                  fontFamily: 'SF UI Display Bold',
                                  fontSize:
                                      globals.deviceType == "phone" ? 14.0 : 22,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'PHONE NUMBER ',
                                  labelStyle: TextStyle(
                                    fontSize: globals.deviceType == 'phone'
                                        ? 14.0
                                        : 22,
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
                                fontSize:
                                    globals.deviceType == 'phone' ? 14.0 : 22,
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
                                  fontSize:
                                      globals.deviceType == "phone" ? 14.0 : 22,
                                  fontFamily: 'SF UI Display Bold',
                                  color: AppTheme.textColor1,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // FormBuilderRadio(
                        //   decoration:
                        //       InputDecoration(labelText: 'My chosen language'),
                        //   attribute: "best_language",
                        //   leadingInput: true,
                        //   onChanged: _onChanged,
                        //   validators: [FormBuilderValidators.required()],
                        //   options:
                        //       ["Dart", "Kotlin", "Java", "Swift", "Objective-C"]
                        //           .map((lang) => FormBuilderFieldOption(
                        //                 value: lang,
                        //                 child: Text('$lang'),
                        //               ))
                        //           .toList(growable: false),
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       top: 10, left: 20, right: 20, bottom: 0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     // mainAxisSize: MainAxisSize.max,
                        //     children: <Widget>[
                        //       Text(
                        //         'Gender',
                        //         style: new TextStyle(
                        //             fontSize: globals.deviceType == "phone"
                        //                 ? 16.0
                        //                 : 24),
                        //       ),
                        //       new Radio<String>(
                        //         value: "Male",
                        //         groupValue: _genderRadioBtnVal,
                        //         onChanged: _handleGenderChange,
                        //       ),
                        //       new Text(
                        //         'Male',
                        //         style: new TextStyle(
                        //             fontSize: globals.deviceType == "phone"
                        //                 ? 16.0
                        //                 : 24),
                        //       ),
                        //       new Radio<String>(
                        //         value: "Female",
                        //         groupValue: _genderRadioBtnVal,
                        //         onChanged: _handleGenderChange,
                        //       ),
                        //       new Text(
                        //         'Female',
                        //         style: new TextStyle(
                        //           fontSize:
                        //               globals.deviceType == "phone" ? 16 : 24,
                        //         ),
                        //       ),
                        //       new Radio<String>(
                        //         value: "Other",
                        //         groupValue: _genderRadioBtnVal,
                        //         onChanged: _handleGenderChange,
                        //       ),
                        //       new Text(
                        //         'Other',
                        //         style: new TextStyle(
                        //             fontSize: globals.deviceType == "phone"
                        //                 ? 16.0
                        //                 : 24),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          height: 0.7,
                          margin: EdgeInsets.only(left: 20, right: 20),
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
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: new Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .09,
                                      alignment: Alignment.center,
                                      color: Theme.of(context).primaryColor,
                                      child: new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            new Text(
                                              "Update Profile",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "SF UI Display",
                                                color: Colors.white,
                                                fontSize: globals.deviceType ==
                                                        "phone"
                                                    ? 17
                                                    : 25,
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
              ])),
        ));
  }

  bottomsheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          bottom: true,
          child: SingleChildScrollView(
              child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 5, right: 10, bottom: 5, top: 5),
                    child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border:
                                Border.all(width: 0.0, color: Colors.white54),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    14.0) //                 <--- border radius here
                                ),
                          ),
                          child: Icon(
                            const IconData(0xe800,
                                fontFamily: "FeverTrackingIcons"),
                            // color:AppTheme.iconColor,
                            size: 22,
                            color: AppTheme.iconColor,
                          ),
                        ),
                        title: Text(
                          "Camera",
                          style: TextStyle(
                              fontFamily: 'SF UI Display Bold',
                              fontWeight: FontWeight.w900,
                              color: AppTheme.buttomSheetTextColor,
                              fontSize:
                                  globals.deviceType == "phone" ? 17 : 25),
                        ),
                        selected: true,
                        onTap: () {
                          Navigator.pop(context);
                          openCamera();
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 5, right: 10, bottom: 0, top: 0),
                    child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border:
                                Border.all(width: 0.0, color: Colors.white54),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    14.0) //                 <--- border radius here
                                ),
                          ),
                          child: Icon(
                            Icons.photo,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        title: Text(
                          "Gallery ",
                          style: TextStyle(
                              fontFamily: 'SF UI Display Bold',
                              fontWeight: FontWeight.w900,
                              color: AppTheme.buttomSheetTextColor,
                              fontSize:
                                  globals.deviceType == "phone" ? 17 : 25),
                        ),
                        selected: true,
                        onTap: () {
                          Navigator.pop(context);
                          _imgFromGallery();
                        }),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     print("upper");
                  //     Navigator.pop(context);
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 20, right: 30, top: 0),
                  //     child: new Container(
                  //       height: 60,
                  //       alignment: Alignment.center,
                  //       color: Theme.of(context).primaryColor,
                  //       child: new Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             new Text(
                  //               "Cancel",
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontFamily: "SF UI Display",
                  //                 color: Colors.white,
                  //                 fontSize: 17,
                  //               ),
                  //             )
                  //           ]),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 3, size.height);
    var firstEndPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.75), size.height + 120);
    var secondEndPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0.0);
    path.close();

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
