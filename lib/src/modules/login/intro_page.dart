import 'package:flutter/material.dart';
import 'package:mobile_app/src/modules/home/home_screen.dart';
import 'package:mobile_app/src/modules/login/pageview_screen/screen1.dart';
import 'package:mobile_app/src/modules/login/pageview_screen/screen2.dart';
import 'package:mobile_app/src/modules/login/pageview_screen/screen3.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/modules/login/pageview_screen/screen4.dart';
import 'package:mobile_app/src/overrides.dart' as overrides;
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/utils/utility.dart';
import 'package:mobile_app/src/widgets/skip_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  @override
  IntroPageState createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {
  PageController controller;
  int currentPageValue = 0;
  final List<Widget> introWidgetsList = <Widget>[
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4()
  ];

  @override
  void initState() {
    super.initState();
    controller =
        new PageController(initialPage: currentPageValue, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: introSliderView(),
    );
  }

  // make view for intro slider
  Widget introSliderView() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        PageView.builder(
          physics: ClampingScrollPhysics(),
          itemCount: introWidgetsList.length,
          onPageChanged: (int page) {
            getChangedPageAndMoveBar(page);
          },
          controller: controller,
          itemBuilder: (context, index) {
            return introWidgetsList[index];
          },
        ),
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: <Widget>[
            currentPageValue == 3
                ? Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: getStartedButton())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              for (int i = 0; i < introWidgetsList.length; i++)
                                if (i == currentPageValue) ...[
                                  circleBar(true, i)
                                ] else
                                  circleBar(false, i),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 3 +
                                      50),
                              SkipButton()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        )
      ],
    );
  }

  // get Started Button
  Widget getStartedButton() {
    return InkWell(
      onTap: () {
        Utility.navigateToScreen(context);
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 25, right: 25),
        height: 50,
        padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2), blurRadius: 4)
          ],
          /*boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(9,116,221,0.2),
                blurRadius: 15.0,
                offset: Offset(0.4,0.0)
            )
          ],*/
          borderRadius: BorderRadius.circular(3),
          color: Theme.of(context).accentColor,
        ),
        child:
            /*state is Loading
            ? Center(
                child: Container(
                  //margin: EdgeInsets.only(right: 15),
                  height: 25,
                  width: 25,
                  padding: EdgeInsets.all(1),
                  child: CircularProgressIndicator(
                      strokeWidth: 1,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Color(0xffFFFFFF))),
                ),
              )
            :*/
            Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Get Started',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: globals.deviceType == 'phone' ? 16 : 24,
                    color: AppTheme.titleColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SF UI Display Bold'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget circleBar(bool isActive, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 10 : 10,
      width: isActive ? 10 : 10,
      decoration: BoxDecoration(
          color: index <= currentPageValue
              ? Theme.of(context).accentColor
              : Color(0xffCCCCCC),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  // get Current Page Value
  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  // // navigate to screen
  // navigateToScreen() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setBool("INTRODUCTION_WATCHED", true);

  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => HomeScreen()));
  // }
}
