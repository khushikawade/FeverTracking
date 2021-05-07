// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'dart:async';
// import 'dart:io';
// import 'dart:io' show Platform;
// import 'package:mobile_app/src/overrides.dart' as overrides;

// class ProfileImageProcessingPage extends StatefulWidget {
//   @override
//   var image;
//   ProfileImageProcessingPage({Key key, @required this.image}) : super(key: key);
//   _ImageProcessingState createState() => new _ImageProcessingState();
// }

// class _ImageProcessingState extends State<ProfileImageProcessingPage> {
//   File _processedImage;
//   Future<Null> _cropImage(File imageFile) async {
//     File croppedFile = await ImageCropper.cropImage(
//       sourcePath: imageFile.path,
//       aspectRatio : CropAspectRatio(ratioX: 8.27, ratioY: 11.7),
//       androidUiSettings: AndroidUiSettings(
//           toolbarTitle:  "",
//           toolbarColor: overrides.whiteColor,
//           toolbarWidgetColor: overrides.iconsColor,
//           backgroundColor: overrides.whiteColor,
//         cropFrameColor: overrides.font1Color,
//         activeControlsWidgetColor: overrides.whiteColor,
        
//           lockAspectRatio: false),
//     );
//     setState(() {
//      _processedImage = croppedFile;
//     });
//     Navigator.pop(context, _processedImage);
//   }

//   @override
//   void initState() {
//     // if (Platform.isAndroid) {
      
//     // } else if (Platform.isIOS) {
    
//     // }
//     super.initState();
   
//     setState(() {
//       _processedImage = widget.image;
//     });

//     Timer timer = new Timer(new Duration(seconds: 1), () {
//         _cropImage(widget.image);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Center(
//         child: CircularProgressIndicator(  valueColor:
//                       new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
//       ),
//     );
//   }
// }
