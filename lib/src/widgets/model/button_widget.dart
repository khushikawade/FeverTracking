import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;

Widget buttonWidget(context, text) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
    child: new Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      color: Theme.of(context).primaryColor,
      child: new Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        new Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "SF UI Display",
            color: Colors.white,
            fontSize: globals.deviceType == "phone" ? 17 : 25,
          ),
        )
      ]),
    ),
  );
}
