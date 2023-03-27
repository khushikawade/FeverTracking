// //import 'package:mobile_app/src/modules/login/bloc/login_bloc.dart';
// import 'dart:io';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:mobile_app/src/locale/app_translations.dart';
// import 'package:mobile_app/src/locale/app_translations_delegate.dart';
// import 'package:mobile_app/src/locale/application.dart';
// import 'package:mobile_app/src/model/language.dart';
// import 'package:mobile_app/src/modules/dashboard/ui/dashboard.dart';
// import 'package:mobile_app/src/modules/login/ui/login-page.dart';
// import 'package:mobile_app/src/modules/profile/bloc/profile_bloc.dart';
// import 'package:mobile_app/src/utils/shared_preference.dart';

// import 'package:mobile_app/src/utils/utility.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_app/src/globals.dart' as globals;
// import 'package:flutter_bloc/flutter_bloc.dart';
// //import 'package:flutter_switch/flutter_switch.dart';
// import 'package:flutter_masked_text/flutter_masked_text.dart';
// import 'package:mobile_app/src/modules/profile/ui/edit_profile.dart';
// import 'package:mobile_app/src/modules/profile/ui/change_password.dart';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:mobile_app/src/overrides.dart' as overrides;
// import 'package:onesignal_flutter/onesignal_flutter.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// class Account1 extends StatefulWidget {
//   // Account({Key key, this.msg}) : super(key: key);
//   @override
//   _Account1State createState() => _Account1State();
// }

// class Global {
//   static final shared = Global();
//   bool isInstructionView = true;
// }

// class _Account1State extends State<Account1> {
//   static const _kFontFam = 'HBXapp';
//   static const _kFontPkg = null;

//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   var controller = new MaskedTextController(mask: '(000) 000 0000');
//   ProfileBloc _bloc = ProfileBloc();

//   //LoginBloc _loginbloc = LoginBloc();
//   String mobileNumber;
//   bool _hideNavBar = true;
//   bool isInstructionView = true;
//   bool switchControl = true;
//   var textHolder = 'Switch is OFF';
//   AppTranslationsDelegate _newLocaleDelegate;

//   bool pushEnabled = true;
//   String languageCode = '';

//   String _selectedLanguage;
//   List<DropdownMenuItem<LanguageData>> _dropdownMenuItems;
//   List<LanguageData> languageList = new List();
//   //List languageList = ["English", "हिन्दी"];

//   void toggleSwitch(bool value) {
//     if (switchControl == false) {
//       setState(() {
//         switchControl = true;
//       });
//       // Put your code here which you want to execute on Switch ON event.
//     } else {
//       setState(() {
//         switchControl = false;
//       });
//       // Put your code here which you want to execute on Switch OFF event.
//     }
//   }

//   navigate() async {
//     bool flag = await Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => EditAccount()));

//     if (flag != null) {
//       if (flag) {
//         _bloc.add(GetUserData());

//         _scaffoldKey.currentState.showSnackBar(SnackBar(
//           content: Text(
//             AppTranslations.of(context)
//                 .text("profile_pic_updated_successfully"),
//           ),
//           duration: Duration(seconds: 3),
//         ));
//       } else {
//         _bloc.add(GetUserData());
//         _scaffoldKey.currentState.showSnackBar(SnackBar(
//           content: Text(
//             AppTranslations.of(context).text("profile_updated_successfully"),
//           ),
//           duration: Duration(seconds: 3),
//         ));
//       }
//     }
//   }

//   void initState() {
//     getCurrentLanguage();

//     languageList.add(LanguageData(languageName: 'English', languageCode: "en"));
//     languageList.add(LanguageData(languageName: 'हिन्दी', languageCode: "hi"));
//     languageList.add(LanguageData(languageName: 'বাংলা', languageCode: "bn"));
//     languageList.add(LanguageData(languageName: 'मराठी', languageCode: "mr"));
//     languageList.add(LanguageData(languageName: 'తెలుగు', languageCode: "te"));
//     languageList.add(LanguageData(languageName: 'தமிழ்', languageCode: "ta"));
//     languageList.add(LanguageData(languageName: 'ગુજરાતી', languageCode: "gu"));
//     languageList.add(LanguageData(languageName: 'اردو', languageCode: "ur"));
//     languageList.add(LanguageData(languageName: 'ಕನ್ನಡ', languageCode: "kn"));
//     languageList.add(LanguageData(languageName: 'ଓଡିଆ', languageCode: "or"));
//     languageList.add(LanguageData(languageName: 'മലയാളം', languageCode: "ml"));
//     languageList.add(LanguageData(languageName: 'ਪੰਜਾਬੀ', languageCode: "pa"));

//     _dropdownMenuItems = buildDropDownMenuItems(languageList);
//     _selectedLanguage = _dropdownMenuItems[0].value.languageName;

//     isInstructionView = Global.shared.isInstructionView;
//     super.initState();

//     getPushSettings();
//     _bloc.add(GetUserData());
//   }

//   // get Current Language
//   getCurrentLanguage() async {
//     SharedPreferencesTest preferences = new SharedPreferencesTest();
//     languageCode = await preferences.getString('LANGUAGE_CODE');
//   }

//   List<DropdownMenuItem<LanguageData>> buildDropDownMenuItems(List listItems) {
//     List<DropdownMenuItem<LanguageData>> items = List();
//     for (LanguageData listItem in listItems) {
//       items.add(
//         DropdownMenuItem(
//           child: Text(listItem.languageName),
//           value: listItem,
//         ),
//       );
//     }
//     return items;
//   }

//   switchPushSettings(value) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setBool("enablePushNotifications", value);
//       OneSignal.shared.setSubscription(value);
//       setState(() {
//         pushEnabled = value;
//       });
//     } catch (e) {}
//   }

//   getPushSettings() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       bool _flag = prefs.getBool("enablePushNotifications");
//       setState(() {
//         pushEnabled = _flag != null ? _flag : true;
//       });
//     } catch (e) {}
//   }

//   _navigateToEditProfile() async {
//     await Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => EditAccount()));

//     //Will run once EditAccount is getting disposed (or Poped)
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         child: Container(
//             child: Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//           preferredSize: Size.fromHeight(Utility.displayWidth(context) * 0.18),
//           child: AppBar(
//             brightness: Brightness.light,
//             title: Padding(
//               padding: const EdgeInsets.only(top: 18.0),
//               child: GestureDetector(
//                 onTap: () {
//                   //Navigator.of(context).pop(true);
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (context) => DashboardPage()));
//                 },
//                 child: new Image.asset(
//                   'assets/images/logo.png',
//                   width: 160.0,
//                   height: 160.0,
//                   // fit: BoxFit.cover,
//                 ),
//               ),
//               // Text(
//               //   "WEGOV",
//               //   style: TextStyle(
//               //       color: overrides.fontColor,
//               //       fontSize: 35,
//               //       fontWeight: FontWeight.bold),
//               // ),
//             ),
//             backgroundColor: overrides.whiteColor,
//             centerTitle: true,
//             titleSpacing: 1,
//             elevation: 1,
//             iconTheme: IconThemeData(color: overrides.fontColor, size: 30),
//             leading: Builder(
//               builder: (context) => GestureDetector(
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                       top: Utility.displayWidth(context) * 0.03,
//                       left: Utility.displayWidth(context) * 0.05),
//                   child: Icon(
//                     Icons.arrow_back,
//                     color: overrides.fontColor,
//                     size: 30.0,
//                   ),
//                 ),
//                 onTap: () => Navigator.of(context).pop(true),
//                 // iconSize: 40,
//                 // color: globals.headerIconsColor,
//               ),
//             ),
//             actions: <Widget>[
//               GestureDetector(
//                 onTap: () {
//                   _navigateToEditProfile();
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(right: 13.0),
//                   child: new Icon(
//                     //Icons.edit,
//                     const IconData(0xe80a,
//                         fontFamily: _kFontFam, fontPackage: _kFontPkg),
//                     size: 30.0,
//                     color: overrides.fontColor,
//                   ),
//                 ),
//               )
//             ],
//           )),
//       body: ListView(
//         children: <Widget>[
//           Column(children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(top: 30.0, left: 30),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       color: overrides.whiteColor,
//                       child: BlocBuilder(
//                           bloc: _bloc,
//                           // ignore: missing_return
//                           builder: (BuildContext context, ProfileState state) {
//                             if (state is GetData) {
//                               return CircleAvatar(
//                                 radius: 46,
//                                 backgroundColor: Color.fromRGBO(0, 0, 0, 0.2),
//                                 child: globals.userData != null &&
//                                         globals.userData["avatar"] != null &&
//                                         globals.userData["avatar"] != ""
//                                     ? CircleAvatar(
//                                         radius: 46,
//                                         backgroundColor:
//                                             Color.fromRGBO(0, 0, 0, 0.2),
//                                         backgroundImage:
//                                             CachedNetworkImageProvider(
//                                           "${overrides.apiURL_IN}${globals.userData["avatar"]}",
//                                         ),
//                                       )
//                                     : CircleAvatar(
//                                         backgroundColor:
//                                             Color.fromRGBO(0, 0, 0, 0.2),
//                                         radius: 46,
//                                         child: Center(
//                                           child: Text(
//                                             //"Hello",
//                                             "${globals.userData["name"] != null ? globals.userData["name"] : ""}",
//                                             //"${globals.userData["firstname"] != null ? globals.userData["firstname"][0].toUpperCase() : ""}${globals.userData["lastname"] != null ? globals.userData["lastname"][0].toUpperCase() : ""}",
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 color: overrides.whiteColor,
//                                                 //letterSpacing: 1.5,
//                                                 fontSize: 14,
//                                                 fontFamily: 'Quicksand',
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                               );
//                             } else if (state is OnLoading) {
//                               return Container(
//                                   // padding: EdgeInsets.only(top: 75.0),
//                                   child: Padding(
//                                 padding: const EdgeInsets.all(18.0),
//                                 child: Center(
//                                     child: globals.showSpiner(
//                                         40.0, overrides.appColor)),
//                               ));
//                             } else {
//                               return Container();
//                             }
//                           }),
//                     ),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Container(
//                                 alignment: Alignment.centerLeft,
//                                 // margin: EdgeInsets.only(top: 5),
//                                 child: RichText(
//                                   text: TextSpan(children: [
//                                     TextSpan(
//                                         text:
//                                             "${globals.userData["name"] != null ? globals.userData["name"] : ""}",
//                                         //"${globals.userData["username"] != null ? globals.userData["username"] : ""}",
//                                         style: TextStyle(
//                                             color: overrides
//                                                 .fontColor, //overrides.whiteColor,
//                                             fontFamily: 'Quicksand',
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold)),
//                                     TextSpan(
//                                       text: " ",
//                                     ),
//                                     TextSpan(
//                                         text:
//                                             "${globals.userData["last_name"] != null ? globals.userData["last_name"] : ""}",
//                                         //"${globals.userData["username"] != null ? globals.userData["username"] : ""}",
//                                         style: TextStyle(
//                                             color: overrides
//                                                 .fontColor, //overrides.whiteColor,
//                                             fontFamily: 'Quicksand',
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold))
//                                   ]),
//                                 )),
//                           ),
//                           Container(
//                               //alignment: Alignment.centerLeft,
//                               margin: EdgeInsets.only(top: 5),
//                               child: Text(
//                                   "${globals.userData["email"] != null ? globals.userData["email"] : ""}",

//                                   //  "${globals.userData["email"] != null ? globals.userData["email"] : "--"}",
//                                   style: TextStyle(
//                                       color: overrides
//                                           .messageColor, //overrides.whiteColor,
//                                       fontFamily: 'Quicksand',
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500))),
//                         ],
//                       ),
//                     ),
//                   ]),
//             ),
//           ]),
//           SizedBox(
//             height: Utility.displayWidth(context) * 0.10,
//           ),
//           Container(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10.0),
//               child: _buildCards(),
//             ),
//           ),
//           BlocListener<ProfileBloc, ProfileState>(
//             bloc: _bloc,
//             listener: (context, state) {
//               setState(() {
//                 globals.userData = globals.userData;
//               });

//               if (state is GotError) {
//                 if (state.err != null && state.err != "") {
//                   _scaffoldKey.currentState.showSnackBar(SnackBar(
//                     content: Text(
//                       state.err,
//                     ),
//                     duration: Duration(seconds: 4),
//                   ));
//                 }
//               }
//               if (state is LoggedOut) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => LoginPage(
//                             msg: AppTranslations.of(context)
//                                 .text("logout_successfully"),
//                           )),
//                 );
//               }

//               if (state is Error1) {
//                 _scaffoldKey.currentState.showSnackBar(SnackBar(
//                   content: Text(
//                     // "state.err"
//                     AppTranslations.of(context).text("something_went_wrong"),
//                   ),
//                   duration: Duration(seconds: 3),
//                 ));
//               }
//             },
//             child: Container(),
//           ),
//           BlocListener<ProfileBloc, ProfileState>(
//             bloc: _bloc,
//             listener: (context, state) {
//               setState(() {
//                 globals.userData = globals.userData;
//               });

//               if (state is GotError) {
//                 if (state.err != null && state.err != "") {
//                   Fluttertoast.showToast(
//                       msg: "${state.err}",
//                       toastLength: Toast.LENGTH_SHORT,
//                       gravity: ToastGravity.SNACKBAR,
//                       timeInSecForIosWeb: 1,
//                       backgroundColor: overrides.font1Color,
//                       textColor: Colors.white,
//                       fontSize: 16.0);
//                   // _scaffoldKey.currentState.showSnackBar(SnackBar(
//                   //   content: Text(
//                   //     state.err,
//                   //   ),
//                   //   duration: Duration(seconds: 4),
//                   // ));
//                 }
//               }

//               if (state is Error1) {
//                 Fluttertoast.showToast(
//                     msg: AppTranslations.of(context)
//                         .text("something_went_wrong"),
//                     toastLength: Toast.LENGTH_SHORT,
//                     gravity: ToastGravity.SNACKBAR,
//                     timeInSecForIosWeb: 1,
//                     backgroundColor: overrides.font1Color,
//                     textColor: Colors.white,
//                     fontSize: 16.0);
//                 // _scaffoldKey.currentState.showSnackBar(SnackBar(
//                 //   content: Text(
//                 //     // "state.err"
//                 //     "Something went wrong",
//                 //   ),
//                 //   duration: Duration(seconds: 3),
//                 // ));
//               }
//             },
//             child: Container(),
//           )
//         ],
//       ),
//     )));
//   }

//   Widget _buildCards() {
//     return Column(
//       children: <Widget>[
//         _languageDropDown(),
//         Padding(
//           padding: const EdgeInsets.only(left: 15.0),
//           child: new Divider(
//             height: 5.0,
//             color: Color.fromRGBO(0, 0, 0, 0.25),
//           ),
//         ),
//         ListTile(
//           onTap: () async {
//             bool result = await Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => ChangePasswordPage()));
//             if (result != null && result) {
//               Navigator.of(context).pop(true);
//             }
//           },
//           title: Text(
//             AppTranslations.of(context).text("change_password_txt"),
//             style: TextStyle(
//               color: overrides.fontColor,
//               fontSize: 17.0,
//               fontFamily: 'Quicksand',
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           trailing: Icon(
//             Icons.keyboard_arrow_right,
//             color: Color.fromRGBO(0, 0, 0, 0.25),
//           ),
//         ),
//         // Padding(
//         //   padding: const EdgeInsets.only(left: 15.0),
//         //   child: new Divider(
//         //     height: 5.0,
//         //     color: Color.fromRGBO(0, 0, 0, 0.25),
//         //   ),
//         // ),
//         Padding(
//           padding: const EdgeInsets.only(left: 15.0),
//           child: new Divider(
//             height: 5.0,
//             color: Color.fromRGBO(0, 0, 0, 0.25),
//           ),
//         ),
//         BlocBuilder(
//           bloc: _bloc,
//           builder: (BuildContext context, ProfileState state) {
//             return ListTile(
//               onTap: () {
//                 if (state is Loading) {
//                 } else {
//                   _bloc.add(LogOut());
//                 }
//               },
//               title: Row(
//                 children: <Widget>[
//                   state is Loading
//                       ? Padding(
//                           padding: EdgeInsets.only(right: 7, left: 1),
//                           child: Container(
//                             height: 15,
//                             width: 15,
//                             child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: new AlwaysStoppedAnimation<Color>(
//                                     overrides.fontColor)),
//                           ),
//                         )
//                       : Container(),
//                   Text(
//                     AppTranslations.of(context).text("logout_txt"),
//                     style: TextStyle(
//                       color: overrides.fontColor,
//                       fontSize: 17.0,
//                       fontFamily: 'Quicksand',
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//               trailing: Icon(
//                 Icons.keyboard_arrow_right,
//                 color: Color.fromRGBO(0, 0, 0, 0.25),
//               ),
//             );
//           },
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 15.0),
//           child: new Divider(
//             height: 5.0,
//             color: Color.fromRGBO(0, 0, 0, 0.25),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _languageDropDown() {
//     return ListTile(
//       onTap: () {
//         _settingModalBottomSheet(context, languageList);
//       },
//       title: Text(
//         AppTranslations.of(context).text("change_language_txt"),
//         style: TextStyle(
//           color: overrides.fontColor,
//           fontSize: 17.0,
//           fontFamily: 'Quicksand',
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       trailing: Icon(
//         Icons.keyboard_arrow_right,
//         color: Color.fromRGBO(0, 0, 0, 0.25),
//       ),
//     );
//     // return Padding(
//     //   padding: const EdgeInsets.only(left: 15, bottom: 10),
//     //   child: Row(
//     //       mainAxisSize: MainAxisSize.max,
//     //       mainAxisAlignment: MainAxisAlignment.start,
//     //       crossAxisAlignment: CrossAxisAlignment.center,
//     //       children: [
//     //         Expanded(
//     //           child: Text(
//     //             AppTranslations.of(context).text('change_language_txt'),
//     //             style: TextStyle(
//     //               color: overrides.fontColor,
//     //               fontSize: 17.0,
//     //               fontFamily: 'Quicksand',
//     //               fontWeight: FontWeight.w600,
//     //             ),
//     //           ),
//     //         ),
//     //         Container(
//     //           padding: EdgeInsets.only(left: 20, right: 20),
//     //           child: DropdownButton(
//     //               value: _selectedLanguage,
//     //               items: _dropdownMenuItems,
//     //               dropdownColor: Color(0xffffffff),
//     //               style: TextStyle(
//     //                 color: Color(0xff000000),
//     //                 fontSize: 17.0,
//     //                 fontFamily: 'Quicksand',
//     //                 fontWeight: FontWeight.w600,
//     //               ),
//     //               onChanged: (value) {
//     //                 setState(() {
//     //                   _selectedLanguage = value;
//     //                 });
//     //               }),
//     //         )
//     //       ]),
//     // );
//   }

//   _settingModalBottomSheet(
//     context,
//     obj,
//   ) {
//     //final List _arr = obj.keys.toList();
//     showModalBottomSheet(
//         context: context,
//         isDismissible: true,
//         enableDrag: true,
//         backgroundColor: Color(0xffffffff),
//         builder: (BuildContext bc) {
//           return SingleChildScrollView(
//             child: new Wrap(
//                 children: obj
//                     .map<Widget>((i) => new ListTile(
//                         // leading: new Icon(Icons.music_note),
//                         title: new Text(
//                           '${i.languageName}',
//                           style: TextStyle(
//                             color: overrides.fontColor,
//                             fontSize: 16.0,
//                             fontFamily: 'Quicksand',
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         trailing: languageCode == i.languageCode
//                             ? Icon(
//                                 Icons.check,
//                                 color: overrides.fontColor,
//                                 size: 20,
//                               )
//                             : Container(
//                                 height: 0,
//                                 width: 0,
//                               ),
//                         onTap: () {
//                           Navigator.pop(context);

//                           Locale locale = new Locale(i.languageCode);
//                           application.onLocaleChanged(locale);
//                           SharedPreferencesTest preferences =
//                               new SharedPreferencesTest();
//                           preferences.setString(
//                               'LANGUAGE_CODE', i.languageCode);
//                           getCurrentLanguage();
//                           //application.onLocaleChanged = onLocaleChange;
//                           //onLocaleChange(locale);
//                         }))
//                     .toList()),
//           );
//         });
//   }

//   // void onLocaleChange(Locale locale) {

//   //   setState(() {
//   //     //_newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
//   //     application.onLocaleChanged = onLocaleChange;

//   //   });
//   // }
// }

// // import 'package:flutter/material.dart';

// // class Buttomsheet extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: ButtomSheetPage(),
// //     );
// //   }
// // }

// // class ButtomSheetPage extends StatefulWidget {
// //   _ButtomSheetPageState createState() => _ButtomSheetPageState();
// // }

// // class _ButtomSheetPageState extends State<ButtomSheetPage> {
// //   String _selectedItem = '';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             RaisedButton(
// //               child: Text('Show'),
// //               onPressed: () => _onButtonPressed(),
// //             ),
// //             Text(
// //               _selectedItem,
// //               style: TextStyle(fontSize: 30),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   void _onButtonPressed() {
// //     showModalBottomSheet(
// //         context: context,
// //         builder: (context) {
// //           return Container(
// //             color: Color(0xFF737373),
// //             height: 180,
// //             child: Container(
// //               child: _buildBottomNavigationMenu(),
// //               decoration: BoxDecoration(
// //                 color: Theme.of(context).canvasColor,
// //                 borderRadius: BorderRadius.only(
// //                   topLeft: const Radius.circular(10),
// //                   topRight: const Radius.circular(10),
// //                 ),
// //               ),
// //             ),
// //           );
// //         });
// //   }

// //   Column _buildBottomNavigationMenu() {
// //     return Column(
// //       children: <Widget>[
// //         ListTile(
// //           leading: Icon(Icons.ac_unit),
// //           title: Text('forehead'),
// //           onTap: () => _selectItem('forehead'),
// //         ),
// //         ListTile(
// //           leading: Icon(Icons.accessibility_new),
// //           title: Text('Ear'),
// //           onTap: () => _selectItem('Ear'),
// //         ),
// //         ListTile(
// //           leading: Icon(Icons.assessment),
// //           title: Text('Mouth'),
// //           onTap: () => _selectItem('Mouth'),
// //         ),
// //       ],
// //     );
// //   }

// //   void _selectItem(String name) {
// //     Navigator.pop(context);
// //     setState(() {
// //       _selectedItem = name;
// //     });
// //   }
// // }

import 'package:flutter/material.dart';

class Buttomsheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ButtomSheetPage(),
    );
  }
}

class ButtomSheetPage extends StatefulWidget {
  _ButtomSheetPageState createState() => _ButtomSheetPageState();
}

class _ButtomSheetPageState extends State<ButtomSheetPage> {
  String _selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // RaisedButton(
            //   child: Text('Show'),
            //   onPressed: () => _showModalSheet(),
            // ),
            Text(
              _selectedItem,
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }

  List<CheckBoxData> checkboxDataList = [
    new CheckBoxData(id: '1', displayId: 'check1', checked: true),
    new CheckBoxData(id: '2', displayId: 'check2', checked: false),
    new CheckBoxData(id: '3', displayId: 'check3', checked: true),
  ];

  void _showModalSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter state2) {
            return SingleChildScrollView(
              child: LimitedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: checkboxDataList.map<Widget>(
                    (data) {
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CheckboxListTile(
                              value: true,
                              title: Text(data.displayId),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool val) {
                                state2(() {
                                  data.checked = !data.checked;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CheckBoxData {
  String id;
  String displayId;
  bool checked;

  CheckBoxData({
    this.id,
    this.displayId,
    this.checked,
  });

  factory CheckBoxData.fromJson(Map<String, dynamic> json) => CheckBoxData(
        id: json["id"] == null ? null : json["id"],
        displayId: json["displayId"] == null ? null : json["displayId"],
        checked: json["checked"] == null ? null : json["checked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "displayId": displayId == null ? null : displayId,
        "checked": checked == null ? null : checked,
      };
}
