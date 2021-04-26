import 'package:flutter/material.dart';

class CustomDividerPage extends StatefulWidget {
  String text;
  CustomDividerPage({
    Key key,
    this.text,
  }) : super(key: key);
  @override
  _CustomDividerPageState createState() => _CustomDividerPageState();
}

class _CustomDividerPageState extends State<CustomDividerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: Divider(
                color: Color(0xffE2E2E2),
                height: 36,
              )),
        ),
        Text(
          "${widget.text}",
          style: TextStyle(
            color: Color(0xff666666),
            fontSize: 10,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 8.0),
              child: Divider(
                color: Color(0xffE2E2E2),
                height: 36,
              )),
        ),
      ]),
    );
  }
}
