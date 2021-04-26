import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: const Color(0xff007AFF),
    accentColor: const Color(0xff0333333),
    hintColor: const Color(0xff0FFFFFF),
    backgroundColor: Colors.white,
    textSelectionColor: const Color(0xff0888888),
    textSelectionHandleColor: const Color(0xff82909F),
    
    // dividerColor: Theme.of(context).backgroundColor,
    // buttonColor: Theme.of(context).backgroundColor,
    // scaffoldBackgroundColor: Theme.of(context).backgroundColor,
    // textcolor: Colors.black,
  );
}
