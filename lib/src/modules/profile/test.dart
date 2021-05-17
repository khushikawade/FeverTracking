// import 'package:flutter/material.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:regexpattern/regexpattern.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';

// void main() {
//   runApp(MaterialApp(debugShowCheckedModeBanner: false, home: UsereditPage()));
// }

// class UsereditPage extends StatefulWidget {
//   UsereditPage({Key key}) : super(key: key);

//   @override
//   _UsereditPageState createState() => _UsereditPageState();
// }

// class _UsereditPageState extends State<UsereditPage> {
//   bool padd = true;
//   var _image;
//   final picker = ImagePicker();
//   String mobile;

//   var isLoading = false;

//   final scaffoldKey = new GlobalKey<ScaffoldState>();
//   final formKey = new GlobalKey<FormState>();

//   String _email;
//   String _username;
//   int _phone;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }

//   Future openCamera() async {
//     var image = await ImagePicker.platform
//         .pickImage(source: ImageSource.camera, imageQuality: 50);

//     setState(() {
//       _image = image;
//     });
//   }

//   Future _imgFromGallery() async {
//     var image = await ImagePicker.platform
//         .pickImage(source: ImageSource.gallery, imageQuality: 50);

//     setState(() {
//       _image = image;
//     });
//   }

//   void _submit() {
//     final form = formKey.currentState;

//     if (form.validate()) {
//       form.save();

//       performLogin();
//     }
//   }

//   void performLogin() {
//     final snackbar = new SnackBar(
//       content:
//           new Text("Email : $_email, USERNAME : $_username ,phone : $_phone"),
//     );
//     scaffoldKey.currentState.showSnackBar(snackbar);
//   }

//   String validateMobile(String value) {
//     String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
//     RegExp regExp = new RegExp(patttern);
//     if (value.length == 0) {
//       return 'Please enter mobile number';
//     } else if (!regExp.hasMatch(value)) {
//       return 'Please enter valid mobile number';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: scaffoldKey,
//         backgroundColor: Color(0XFF1D252F),
//         appBar: AppBar(
//           backgroundColor: Color(0xFFFA6F48),
//           automaticallyImplyLeading: false,
//           elevation: 0,
//           titleSpacing: 0.0,
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(
//                 Icons.close,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 print("close button pressed ");
//               },
//             ),
//           ],
//         ),
//         body: Container(
//             margin: const EdgeInsets.all(0.0),
//             child: SingleChildScrollView(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                   ClipPath(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 100,
//                       color: Color(0xFFFA6F48),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           _image == null
//                               ? CircleAvatar(
//                                   radius: 50,
//                                   backgroundColor: Colors.red.withOpacity(0),
//                                   child: CircleAvatar(
//                                     radius: 45,
//                                     backgroundImage: NetworkImage(
//                                         'https://picsum.photos/250?image=9'),
//                                   ),
//                                 )
//                               : InkWell(
//                                   child: CircleAvatar(
//                                     backgroundColor: Colors.redAccent,
//                                     radius: 39.0,
//                                     child: CircleAvatar(
//                                       radius: 38.0,
//                                       backgroundImage:
//                                           new FileImage(File(_image.path)),
//                                     ),
//                                   ),
//                                 ),
//                           GestureDetector(
//                               onTap: () {
//                                 print('Pressed');

//                                 return showModalBottomSheet<void>(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return Container(
//                                       height: 200,
//                                       child: Center(
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Container(
//                                               padding: const EdgeInsets.only(
//                                                   left: 5,
//                                                   right: 10,
//                                                   bottom: 5,
//                                                   top: 5),
//                                               child: ListTile(
//                                                   leading: Container(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             10.0),
//                                                     decoration: BoxDecoration(
//                                                       color: Color(0xffFA6F48),
//                                                       border: Border.all(
//                                                           width: 0.0,
//                                                           color:
//                                                               Colors.white54),
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                               Radius.circular(
//                                                                   14.0) //                 <--- border radius here
//                                                               ),
//                                                     ),
//                                                     child: Icon(
//                                                       Icons.camera,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                   title: Text(
//                                                     "Camera",
//                                                     style: TextStyle(
//                                                         fontFamily:
//                                                             'SF UI Display Bold',
//                                                         fontWeight:
//                                                             FontWeight.w900,
//                                                         color:
//                                                             Color(0XFF9DB0C7),
//                                                         fontSize: 17),
//                                                   ),
//                                                   selected: true,
//                                                   onTap: () {
//                                                     debugPrint(
//                                                         "Starred***** Listile 2   2   Me!");
//                                                     openCamera();
//                                                   }),
//                                             ),
//                                             Container(
//                                               padding: const EdgeInsets.only(
//                                                   left: 5,
//                                                   right: 10,
//                                                   bottom: 0,
//                                                   top: 0),
//                                               child: ListTile(
//                                                   leading: Container(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             10.0),
//                                                     decoration: BoxDecoration(
//                                                       color: Color(0xffFA6F48),
//                                                       border: Border.all(
//                                                           width: 0.0,
//                                                           color:
//                                                               Colors.white54),
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                               Radius.circular(
//                                                                   14.0) //                 <--- border radius here
//                                                               ),
//                                                     ),
//                                                     child: Icon(
//                                                       Icons.photo,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                   title: Text(
//                                                     "Gallery ",
//                                                     style: TextStyle(
//                                                         fontFamily:
//                                                             'SF UI Display Bold',
//                                                         fontWeight:
//                                                             FontWeight.w900,
//                                                         color:
//                                                             Color(0XFF9DB0C7),
//                                                         fontSize: 17),
//                                                   ),
//                                                   selected: true,
//                                                   onTap: () {
//                                                     debugPrint(
//                                                         "Starred***** Listile 2   2   Me!");
//                                                     _imgFromGallery();
//                                                   }),
//                                             ),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 print("upper");
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 20,
//                                                     right: 30,
//                                                     top: 0),
//                                                 child: new Container(
//                                                   height: 60,
//                                                   alignment: Alignment.center,
//                                                   color: Color(0xFFFA6F48),
//                                                   child: new Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         new Text(
//                                                           "Cancel",
//                                                           style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontFamily:
//                                                                 "SF UI Display",
//                                                             color: Colors.white,
//                                                             fontSize: 17,
//                                                           ),
//                                                         )
//                                                       ]),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.only(
//                                     top: 0, left: 10, right: 10, bottom: 20),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       width: 0.0, color: Color(0xFFFA6F48)),
//                                   borderRadius: BorderRadius.all(
//                                       Radius.circular(
//                                           20.0) //                 <--- border radius here
//                                       ),
//                                 ),
//                                 child: Icon(
//                                   Icons.add_a_photo,
//                                   color: Color(0xFF1D252F),
//                                 ),
//                               )),
//                         ],
//                       ),
//                     ),
//                     clipper: BottomWaveClipper(),
//                   ),
//                   Form(
//                       key: formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           new Theme(
//                               data: new ThemeData(
//                                 primaryColor: Colors.white,
//                                 primaryColorDark: Colors.white,
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 20, right: 20, top: 10, bottom: 10),
//                                 child: TextFormField(
//                                   validator: (val) {
//                                     if (val.isEmpty) {
//                                       return 'username cannot be  empty  ';
//                                     } else if (val.length > 0 &&
//                                         val.length < 6) {
//                                       return 'username  must is greater 5 character  ';
//                                     }

//                                     return null;
//                                   },
//                                   onSaved: (val) => _username = val,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'SF UI Display Bold',
//                                     fontSize: 24.0,
//                                   ),
//                                   decoration: InputDecoration(
//                                     labelText: 'USERNAME',
//                                     labelStyle: TextStyle(
//                                       fontSize: 18.0,
//                                       fontFamily: 'SF UI Display Bold',
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xff536274),
//                                     ),
//                                   ),
//                                 ),
//                               )),
//                           new Theme(
//                               data: new ThemeData(
//                                 primaryColor: Colors.white,
//                                 primaryColorDark: Colors.white,
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 20, right: 20, top: 10, bottom: 10),
//                                 child: TextFormField(
//                                   keyboardType: TextInputType.phone,
//                                   validator: (val) {
//                                     var pp = validateMobile(val);
//                                     var potentialNumber = int.tryParse(val);
//                                     if (val.isEmpty) {
//                                       return 'Phone Number  Field cannot be  empty  ';
//                                     } else if (potentialNumber < 10) {
//                                       return 'Enter a 10 digit vaild number';
//                                     }

//                                     return null;
//                                   },
//                                   onSaved: (val) => _phone = int.tryParse(val),
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'SF UI Display Bold',
//                                     fontSize: 24.0,
//                                   ),
//                                   decoration: InputDecoration(
//                                     labelText: 'PHONE NUMBER ',
//                                     labelStyle: TextStyle(
//                                       fontSize: 18.0,
//                                       fontFamily: 'SF UI Display Bold',
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xff536274),
//                                     ),
//                                   ),
//                                 ),
//                               )),
//                           new Theme(
//                             data: new ThemeData(
//                               primaryColor: Colors.white,
//                               primaryColorDark: Colors.white,
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 20, right: 20, top: 10, bottom: 10),
//                               child: TextFormField(
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'SF UI Display Bold',
//                                   fontSize: 24.0,
//                                 ),
//                                 keyboardType: TextInputType.emailAddress,
//                                 validator: (val) {
//                                   if (val.isEmpty) {
//                                     return 'Email  field cannot be empty ';
//                                   } else if (!EmailValidator.validate(val)) {
//                                     return 'Please enter a valid email';
//                                   }
//                                   return null;
//                                 },
//                                 onSaved: (val) => _email = val,
//                                 decoration: InputDecoration(
//                                   labelText: 'EMAIL ADDRESS ',
//                                   labelStyle: TextStyle(
//                                     fontSize: 18.0,
//                                     fontFamily: 'SF UI Display Bold',
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xff536274),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               new Align(
//                                   alignment: FractionalOffset.bottomCenter,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       _submit();
//                                       print("upper");
//                                       padd = false;
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 20, right: 30, top: 55),
//                                       child: new Container(
//                                         height: 60,
//                                         alignment: Alignment.center,
//                                         color: Color(0xFFFA6F48),
//                                         child: new Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               new Text(
//                                                 "Update Profile",
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: "SF UI Display",
//                                                   color: Colors.white,
//                                                   fontSize: 17,
//                                                 ),
//                                               )
//                                             ]),
//                                       ),
//                                     ),
//                                   )),
//                             ],
//                           ),
//                         ],
//                       ))
//                 ]))));
//   }
// }

// class BottomWaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();

//     path.lineTo(0.0, size.height - 30);

//     var firstControlPoint = Offset(size.width / 3, size.height);
//     var firstEndPoint = Offset(size.width, size.height);
//     path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
//         firstEndPoint.dx, firstEndPoint.dy);

//     var secondControlPoint =
//         Offset(size.width - (size.width / 3.75), size.height + 120);
//     var secondEndPoint = Offset(size.width, size.height);
//     path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
//         secondEndPoint.dx, secondEndPoint.dy);

//     path.lineTo(size.width, size.height - 60);
//     path.lineTo(size.width, 0.0);
//     path.close();

//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
