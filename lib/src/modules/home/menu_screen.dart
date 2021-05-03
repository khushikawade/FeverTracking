import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  int selectedIndex;

  MenuScreen(this.selectedIndex);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color backGroundColor = Color(0xff463DC7);
  int selectedIndex = 0;
  Color dividerColor1 = Color(0xff463DC7);
  Color dividerColor2 = Color(0xFFFFFFFF);
  Color textColor = Color(0xFFFFFFFF);
  Color dropIconColor = Color(0XFFB5B1E8);
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            size: 30.0,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: backGroundColor,
        elevation: 0,
        titleSpacing: 0.0,
      ),
      key: _scaffoldKey,
      body: menuWidget(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget menuWidget() {
    return Container(
      color: backGroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              radius: 56.47,
              backgroundImage:
                  NetworkImage('https://picsum.photos/250?image=9'),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Default Profile",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: textColor,
                      fontFamily: "SF UI Display Bold",
                      fontSize: 22),
                ),
                Icon(
                  Icons.arrow_drop_down_sharp,
                  color: dropIconColor,
                  size: 30.0,
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop(0);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 29),
                child: Text(
                  "Home",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: textColor,
                      fontFamily: "SF UI Display",
                      fontSize: 20),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(width: 20),
              SizedBox(
                  width: 146,
                  height: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          dividerColor1.withOpacity(0),
                          dividerColor2.withOpacity(0.51),
                          dividerColor2.withOpacity(0.51),
                          dividerColor1.withOpacity(1),
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                width: 30,
              )
            ]),
            InkWell(
              onTap: () {
                Navigator.of(context).pop(1);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 29, bottom: 29),
                child: Text(
                  "Logs",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: textColor.withOpacity(0.61),
                      fontFamily: "SF UI Display",
                      fontSize: 20),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(width: 20),
              SizedBox(
                  width: 146,
                  height: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          dividerColor1.withOpacity(0),
                          dividerColor2.withOpacity(0.51),
                          dividerColor2.withOpacity(0.51),
                          dividerColor1.withOpacity(1),
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                width: 30,
              )
            ]),
            InkWell(
              onTap: () {
                Navigator.of(context).pop(2);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 29, bottom: 29),
                child: Text(
                  "Meds",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: textColor.withOpacity(0.61),
                      fontFamily: "SF UI Display",
                      fontSize: 20),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(width: 20),
              SizedBox(
                  width: 146,
                  height: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          dividerColor1.withOpacity(0),
                          // Colors.black,
                          dividerColor2.withOpacity(0.51),
                          dividerColor2.withOpacity(0.51),
                          dividerColor2.withOpacity(0.51),
                          dividerColor1.withOpacity(1),
                          // Colors.orange,
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                width: 30,
              )
            ]),
            InkWell(
              onTap: () {
                Navigator.of(context).pop(3);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 29, bottom: 29),
                child: Text(
                  "Settings",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: textColor.withOpacity(0.61),
                      fontFamily: "SF UI Display",
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
