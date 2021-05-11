import 'package:flutter/material.dart';

class CustomLoader extends StatefulWidget {
  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            alignment: Alignment.center,
            child: Center(
                child: CircularProgressIndicator(
              strokeWidth: 1,
              valueColor: new AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor),
            ))));
  }
}
