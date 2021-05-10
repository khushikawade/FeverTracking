import 'package:flutter/material.dart';
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';

class MenuScreen extends StatefulWidget {
  int selectedIndex;

  MenuScreen(this.selectedIndex);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int selectedIndex = 0;
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
            // color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        // backgroundColor: backGroundColor,
        elevation: 0,
        titleSpacing: 0.0,
      ),
      key: _scaffoldKey,
      body: menuWidget(),
    );
  }

  Widget menuWidget() {
    return Container(
      color: Theme.of(context).primaryColor,
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
                      color: AppTheme.titleColor,
                      fontFamily: "SF UI Display Bold",
                      fontSize: 22),
                ),
                Icon(
                  Icons.arrow_drop_down_sharp,
                  color: AppTheme.dropIconColor,
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
                      color: widget.selectedIndex == 0
                          ? AppTheme.titleColor
                          : AppTheme.titleColor.withOpacity(0.61),
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
                          AppTheme.menuScreendividerColor1.withOpacity(0),
                          AppTheme.menuScreendividerColor2.withOpacity(0.51),
                          AppTheme.menuScreendividerColor2.withOpacity(0.51),
                          AppTheme.menuScreendividerColor1.withOpacity(1),
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
                      color: widget.selectedIndex == 1
                          ? AppTheme.titleColor
                          : AppTheme.titleColor.withOpacity(0.61),
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
                          AppTheme.menuScreendividerColor1.withOpacity(0),
                          AppTheme.menuScreendividerColor2.withOpacity(0.51),
                          AppTheme.menuScreendividerColor2.withOpacity(0.51),
                          AppTheme.menuScreendividerColor1.withOpacity(1),
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
                      color: widget.selectedIndex == 2
                          ? AppTheme.titleColor
                          : AppTheme.titleColor.withOpacity(0.61),
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
                          AppTheme.menuScreendividerColor1.withOpacity(0),
                          // Colors.black,
                          AppTheme.menuScreendividerColor2.withOpacity(0.51),
                          // AppTheme.menuScreendividerColor2.withOpacity(0.51),
                          AppTheme.menuScreendividerColor2.withOpacity(0.51),
                          AppTheme.menuScreendividerColor1.withOpacity(1),
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
                      color: widget.selectedIndex == 3
                          ? AppTheme.titleColor
                          : AppTheme.titleColor.withOpacity(0.61),
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
