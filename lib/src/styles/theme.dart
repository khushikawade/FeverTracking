// import 'package:flutter/material.dart';

// const title_iconColor = Color(0xffFFFFFF);
// ThemeData appTheme() {
//   return ThemeData(
//       primaryColor: const Color(0xff463DC7),
//       // primaryColor: const Color(0xffFAA45F),
//       accentColor: const Color(0xffFAA45F),
//       hintColor: const Color(0xff0FFFFFF),
//       backgroundColor: Colors.white,
//       // textSelectionColor: const Color(0xff0888888),
//       textSelectionHandleColor: const Color(0xff82909F),
//       textSelectionColor: const Color(0xff030303),
//       dividerColor: const Color(0XFF000000),
//       primaryIconTheme:
//           Theme.of(context).primaryIconTheme.copyWith(color: Colors.white),
//       primaryTextTheme:
//           Theme.of(context).primaryTextTheme.apply(bodyColor: Colors.white)

//       // dividerColor: Theme.of(context).backgroundColor,
//       // buttonColor: Theme.of(context).backgroundColor,
//       // scaffoldBackgroundColor: Theme.of(context).backgroundColor,
//       // textcolor: Colors.black,
//       );
// }

import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  //Colors

  static const title = Color(0xffFFFFFF);
  static const iconColor = Color(0xffFFFFFF);

  static const Color textColor1 = Color(0xff030303);
  static const Color textColor2 = Color(0xff463DC7);

  //Font-sizes
  // static const double kButtonFontSize = 18.0;

  //Borders
  static const double kBorderRadius = 6.0;
  static const double kBorderWidth = 1.0;

  //
  //Starting Screen Paragraph Color
  static const Color contentColor1 = Color(0xFF0F0F0F);
  static const Color contentColor2 = Color(0xFF333333);

  // AddLog Color
  static const Color subHeadingTextColor = Color(0xFF6D6D72);
  static const Color subHeadingbackgroundcolor = Color(0xFFEFEFF4);
  static const Color subHeadingbackgroundcolor2 = Color(0XFFC7C7C7);
  static const Color arrowIconsColor = Color(0xFF000000);
  static const Color iconColor1 = Color(0xfffcfcfc);

  //Log Color
  static const Color screenbackGroundColor = Color(0xFFF7F8F9);
  static const Color listbackGroundColor = Color(0xFFFFFFFF);
  static const Color leadingiconsColor = Color(0xFF708090);
  static const Color subtitleTextColor = Color(0xFF666666);

  //Medicine Page Color
  static const Color screenbackGroundColor2 = Color(0xFFF7F7F7);
  static const Color listbackGroundColor2 = Color(0xFFFFFFFF);
  static const Color listSubtitleColor = Color(0xFF8F8E94);
  static const Color tralingIconColor = Color(0xFFe2e2e2);
  static const Color iconsColor = Color(0xFF708090);

  //settingPage Log
  static const Color dropdowniconColor = Color(0xFFB5B1E8);
  static const Color dividerColor1 = Color.fromRGBO(0, 0, 0, 0.25);
  static const Color headingTextColor = Color(0xFF000000);
  static const Color iconBackgroundColor = Color(0xff929292);
  static const Color iconsColor2 = Color(0xFFd6d6d6);
  static const Color iconsColor3 = Color(0xFF536274);
  static const Color toggleSwitchActiveColor = Color(0xFF4CD964);

  //Graph Color
  static const Color graphIndictor1 = Color(0xFFF4B042);
  static const Color graphIndictor2 = Color(0xFF4EB4F4);
  static const Color graphIndictor3 = Color(0xFFDF3F3F);
  static const Color graphTextColor = Color(0xFF666666);
  static const Color graphTextColor2 = Color(0xFF6D6D72);

  //Menuscreen
  static const Color dropIconColor = Color(0xFFB5B1E8);
  static const Color menuScreendividerColor1 = Color(0xff463DC7);
  static const Color menuScreendividerColor2 = Color(0xFFFFFFFF);

  //
  static const Color titleColor = Color(0xFFFFFFFF);
  static const Color dividerColor = Color(0xffC4CADF);

  static final ThemeData lightTheme = ThemeData(
      primaryColor: const Color(0xff463DC7),
      accentColor: const Color(0xffFAA45F),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: iconColor,
      ));
}
