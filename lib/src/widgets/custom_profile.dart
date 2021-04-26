import 'package:flutter/material.dart';
import 'package:mobile_app/src/globals.dart' as globals;

class CustomProfilePage extends StatefulWidget {
  final String userName;
  final double radius;
  final double fontSize;

  CustomProfilePage({Key key, this.userName, this.radius, this.fontSize})
      : super(key: key);

  @override
  _CustomProfilePageState createState() => _CustomProfilePageState();
}

class _CustomProfilePageState extends State<CustomProfilePage> {
  @override
  Widget build(BuildContext context) {
    List<String> nameList = new List();

    if (widget.userName != null && widget.userName.contains(" ")) {
      nameList = widget.userName.split(" ");
    }
    return Center(
        child: CircleAvatar(
      radius: widget.radius + 1,
      backgroundColor: Color(0xffE2EBF4),
      child: CircleAvatar(
        backgroundColor: Color(0xffA2B6CE).withOpacity(0.5),
        radius: widget.radius,
        child: Text(
          nameList != null && nameList.length > 0
              ? "${nameList[0][0].toUpperCase()}${nameList[1][0].toUpperCase()}"
              : "",
          style: TextStyle(
              letterSpacing: 1.5,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
    ));
  }
}
