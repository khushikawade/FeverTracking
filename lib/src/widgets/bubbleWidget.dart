// import 'package:bubble_showcase/bubble_showcase.dart';
// import 'package:flutter/material.dart';

// import 'package:mobile_app/src/styles/theme.dart';

// import 'package:speech_bubble/speech_bubble.dart';

// Widget bubble(context, _titleKey) {
//   TextStyle textStyle = Theme.of(context).textTheme.bodyText2.copyWith(
//         color: Colors.white,
//       );
//   return BubbleShowcase(
//     bubbleShowcaseId: 'my_bubble_showcase',
//     bubbleShowcaseVersion: 1,
//     bubbleSlides: [
//       _firstSlide(textStyle, _titleKey),
//     ],
//     child: _BubbleShowcaseDemoChild(_titleKey),
//   );
// }

// /// Creates the first slide.
// BubbleSlide _firstSlide(TextStyle textStyle, _titleKey) => RelativeBubbleSlide(
//       widgetKey: _titleKey,
//       shape: const Oval(
//         spreadRadius: 15,
//       ),
//       child: RelativeBubbleSlideChild(
//         direction: AxisDirection.down,
//         widget: Positioned(
//           top: 600,
//           right: 40,
//           left: 80,
//           bottom: 70,
//           // height: 10,R
//           // width: 60,
//           // key: _titleKey,
//           child: Stack(
//             children: [
//               SpeechBubble(
//                 // padding: EdgeInsets.all(value),
//                 // height: ,
//                 nipHeight: 50,
//                 // nipLocation: NipLocation.TOP_LEFT,
//                 color: AppTheme.textColor2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     children: [
//                       Text(
//                         'Add log !',
//                         style: textStyle.copyWith(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'Click here the log button !',
//                         style: textStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

// class _BubbleShowcaseDemoChild extends StatelessWidget {
//   final GlobalKey _titleKey;

//   /// Creates a new bubble showcase demo child instance.
//   _BubbleShowcaseDemoChild(this._titleKey);

//   @override
//   Widget build(BuildContext context) => Align(
//         alignment: Alignment.bottomRight,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: 40,
//             horizontal: 20,
//           ),
//           child: Container(
//             width: 60,
//             height: 60,
//             alignment: Alignment.bottomRight,
//             key: _titleKey,
//             padding: EdgeInsets.all(15),
//             decoration: BoxDecoration(
//               color: Theme.of(context).accentColor,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(100),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color.fromARGB(250, 164, 95, 60),
//                   spreadRadius: 0,
//                   blurRadius: 10,
//                   offset: Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Align(
//               alignment: Alignment.center,
//               child: Icon(
//                 const IconData(0xe806, fontFamily: 'FeverTrackingIcons'),
//                 color: AppTheme.iconColor,
//                 size: 25,
//               ),
//             ),
//           ),
//         ),
//       );
// }
