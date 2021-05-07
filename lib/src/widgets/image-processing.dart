// import 'package:flutter/material.dart';
// // import 'package:image_cropper/image_cropper.dart'; UNCOMMENT
// import 'dart:async';
// import 'dart:io';
// import 'dart:io' show Platform;
// import 'package:mobile_app/src/overrides.dart' as overrides;

// class ImageProcessingPage extends StatefulWidget {
//   @override
//   var image;
//   ImageProcessingPage({Key key, @required this.image}) : super(key: key);
//   _ImageProcessingState createState() => new _ImageProcessingState();
// }

// class _ImageProcessingState extends State<ImageProcessingPage> {
//   File _processedImage;
//   Future<Null> _cropImage(File imageFile) async {
//     File croppedFile = await ImageCropper.cropImage(
//       sourcePath: imageFile.path,
//       aspectRatio : CropAspectRatio(ratioX: 8.27, ratioY: 11.7),
//       androidUiSettings: AndroidUiSettings(
        
//           toolbarTitle:  "Edit Scan",
//           toolbarColor: overrides.whiteColor,
//           toolbarWidgetColor: overrides.blackColor,
//           backgroundColor: overrides.whiteColor,
//         cropFrameColor: overrides.font1Color,
//         activeControlsWidgetColor: overrides.whiteColor,
        
//           lockAspectRatio: false),
//     );
//     setState(() {
//        _processedImage = croppedFile;
//     //  _processedImage = croppedFile != null ? croppedFile : imageFile;
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
