// import 'package:bubble_showcase/bubble_showcase.dart';
// import 'package:flutter/material.dart';

// import 'package:speech_bubble/speech_bubble.dart';

// // ignore: unused_element
// /// First plugin test method.
// // void main() => runApp(_BubbleShowcaseDemoApp());

// /// The demo material app.
// class BubbleShowcaseDemoApp extends StatefulWidget {
//   @override
//   State<BubbleShowcaseDemoApp> createState() => _BubbleShowcaseDemoAppState();
// }

// class _BubbleShowcaseDemoAppState extends State<BubbleShowcaseDemoApp> {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           body: BubbleShowcaseDemoWidget(),
//         ),
//       );
// }

// /// The main demo widget.
// class BubbleShowcaseDemoWidget extends StatefulWidget {
//   @override
//   State<BubbleShowcaseDemoWidget> createState() =>
//       _BubbleShowcaseDemoWidgetState();
// }

// class _BubbleShowcaseDemoWidgetState extends State<BubbleShowcaseDemoWidget> {
//   final GlobalKey _titleKey = GlobalKey();
//   final GlobalKey _firstButtonKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     TextStyle textStyle = Theme.of(context).textTheme.bodyText2.copyWith(
//           color: Colors.white,
//         );
//     return BubbleShowcase(
//       bubbleShowcaseId: 'my_bubble_showcase',
//       bubbleShowcaseVersion: 1,
//       bubbleSlides: [
//         _fourthSlide(textStyle),
//       ],
//       child: _BubbleShowcaseDemoChild(
//         _titleKey,
//         _firstButtonKey,
//       ),
//     );
//   }

//   /// Creates the fourth slide.
//   BubbleSlide _fourthSlide(TextStyle textStyle) => RelativeBubbleSlide(
//         highlightPadding: 4,
//         passThroughMode: PassthroughMode.INSIDE_WITH_NOTIFICATION,
//         widgetKey: _firstButtonKey,
//         shape: const Oval(
//           spreadRadius: 12,
//         ),
//         child: RelativeBubbleSlideChild(
//           widget: Padding(
//             padding: const EdgeInsets.only(top: 8),
//             child: SpeechBubble(
//               nipLocation: NipLocation.TOP,
//               color: Colors.blue,
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Text(
//                   'Add Log',
//                   style: textStyle.copyWith(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
// }

// class _BubbleShowcaseDemoChild extends StatefulWidget {
//   final GlobalKey _titleKey;
//   final GlobalKey _firstButtonKey;
//   _BubbleShowcaseDemoChild(this._titleKey, this._firstButtonKey);

//   @override
//   State<_BubbleShowcaseDemoChild> createState() =>
//       _BubbleShowcaseDemoChildState();
// }

// class _BubbleShowcaseDemoChildState extends State<_BubbleShowcaseDemoChild> {
//   @override
//   Widget build(BuildContext context) => Padding(
//         padding: const EdgeInsets.symmetric(
//           vertical: 40,
//           horizontal: 20,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             InkWell(
//               onTap: () {
//                 const BubbleShowcaseNotification()..dispatch(context);
//               },
//               child: Container(
//                 key: widget._firstButtonKey,
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).accentColor,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(50),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(250, 164, 95, 60),
//                       spreadRadius: 0,
//                       blurRadius: 10,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   const IconData(0xe806, fontFamily: 'FeverTrackingIcons'),
//                   color: Colors.pink,
//                   size: 25,
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
// }

import 'package:bubble_showcase/bubble_showcase.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/styles/theme.dart';

import 'package:speech_bubble/speech_bubble.dart';

/// First plugin test method.
// void main() => runApp(_BubbleShowcaseDemoApp());

/// The demo material app.
class BubbleShowcaseDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Bubble Showcase Demo',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Bubble Showcase Demo'),
          ),
          body: _BubbleShowcaseDemoWidget(),
        ),
      );
}
/// The main demo widget.
class _BubbleShowcaseDemoWidget extends StatelessWidget {
  final GlobalKey _titleKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          color: Colors.white,
        );
    return BubbleShowcase(
      bubbleShowcaseId: 'my_bubble_showcase',
      bubbleShowcaseVersion: 1,
      bubbleSlides: [
        _firstSlide(textStyle),
      ],
      child: _BubbleShowcaseDemoChild(_titleKey),
    );
  }

  /// Creates the first slide.
  BubbleSlide _firstSlide(TextStyle textStyle) => RelativeBubbleSlide(
        widgetKey: _titleKey,
        shape: const Oval(
          spreadRadius: 15,
        ),
        child: RelativeBubbleSlideChild(
          widget: Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 10,
            child: SpeechBubble(
              // nipLocation: NipLocation.TOP_LEFT,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'That\'s cool !',
                      style: textStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'This is my brand new title !',
                      style: textStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

/// The main demo widget child.
class _BubbleShowcaseDemoChild extends StatelessWidget {
  final GlobalKey _titleKey;

  /// Creates a new bubble showcase demo child instance.
  _BubbleShowcaseDemoChild(this._titleKey);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 20,
          ),
          child: Container(
            width: 60,
            height: 70,
            alignment: Alignment.bottomRight,
            key: _titleKey,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(250, 164, 95, 60),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              const IconData(0xe806, fontFamily: 'FeverTrackingIcons'),
              color: AppTheme.iconColor,
              size: 25,
            ),
          ),
        ),
      );
}
