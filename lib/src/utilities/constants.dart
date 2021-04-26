import 'package:flutter/material.dart';
import 'package:mobile_app/src/overrides.dart' as overrides;

final kHintTextStyle = TextStyle(
  // color: overrides.whiteColor,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Color(0xffFFFFFF),
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  // color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      // color: overrides.blackColor,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
