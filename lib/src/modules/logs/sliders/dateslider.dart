import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/modules/logs/log.dart';
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:date_util/date_util.dart';

class DateSlider extends StatefulWidget {
  Function onUpdateWidget;
  bool isdefaultcall;

  DateSlider(
      {Key key, @required this.onUpdateWidget, @required this.isdefaultcall})
      : super(key: key);
  @override
  _DateSliderState createState() => _DateSliderState();
}

class _DateSliderState extends State<DateSlider> {
  DateTime selectedDate = DateTime.now();

  String currentYear;
  String currentMonth;
  String currentDate;
  String asuumeCurrentDate;

  int monthIndex;
  final DateFormat yearMonthDateFormatter = DateFormat('yyyy-MM-dd');
  int currentDateSelectedIndex = 0; //For Horizontal Date
  //To Track Scroll of ListView

  final List<Tab> listOfMonthsTabs = <Tab>[
    Tab(text: "January"),
    Tab(text: "February"),
    Tab(text: "March"),
    Tab(text: "April"),
    Tab(text: "May"),
    Tab(text: "June"),
    Tab(text: "July"),
    Tab(text: "August"),
    Tab(text: "September"),
    Tab(text: "October"),
    Tab(text: "November"),
    Tab(text: "December"),
  ];

  DateTime currentDate2 = new DateTime.now();
  DateTime selectedDate2;

  var noOfDaysInCurrentMonth;
  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  TabController _tabController;
  @override
  void initState() {
    super.initState();

    selectedDate2 =
        new DateTime(currentDate2.year, currentDate2.month, currentDate2.day);

    _dateCounter();
  }

  ScrollController scrollController = ScrollController(
    keepScrollOffset: true,
  );

  @override
  void dispose() {
    super.dispose();
  }

  var dateUtility = DateUtil();
  DateTime startingdate;
  int currentDate1;
  var date = new DateTime.now().toString();
  var dateParse;
  var currentdate;
  String monthindex;
  int currentmonth;

  DateTime now = new DateTime.now(); // for 5  ->05 format
  void _dateCounter() {
    dateParse = DateTime.parse(date); //current date from date time now

    var startingdateString;

    //get the no  days    1....31  in the month
    noOfDaysInCurrentMonth = dateUtility.daysInMonth(
        (globals.selectedMonthIndex + 1), dateParse.year);
    currentYear = "${dateParse.year}";

    setState(() {
      monthIndex = globals.selectedMonthIndex +
          1; //get month index From Tabbar ..... 5->May

      monthindex = monthIndex.toString().padLeft(2, '0'); // 5 -> 05

      currentmonth = int.parse(
          "${(selectedDate2.month - 1)}"); //current month from date.now

      //  in  current month shows current date as selected index   othermonth  starting index is 1
      if (globals.selectedMonthIndex == currentmonth) {
        currentDateSelectedIndex = int.parse("${(selectedDate2.day) - 1}");
      } else {
        currentDateSelectedIndex = 0;
      }

      // Get the days index and helps to show on  UI   (mon ,tue,wed)
      startingdateString = "$currentYear-$monthindex-01 ";
      startingdate = new DateFormat("yyyy-MM-dd").parse("$startingdateString");

      //if getdatefromslider is null then  initilalize them with current date
      final String yearMonthDayForamttedDate =
          yearMonthDateFormatter.format(now);
      globals.getdatefromslider == null
          ? globals.getdatefromslider = "$yearMonthDayForamttedDate"
          : globals.getdatefromslider = globals.getdatefromslider;

      print("globals.selectedMonthIndex ${globals.getdatefromslider}");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (globals.selectedMonthIndex == currentmonth && widget.isdefaultcall) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients && widget.isdefaultcall) {
          Timer(
            Duration(seconds: 1),
            () => scrollController
                .jumpTo(scrollController.position.maxScrollExtent),
          );
          widget.isdefaultcall = false;
        }
      });
    }
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      SizedBox(height: 15),
      dateSliderWidget(),
      SizedBox(height: 15),
    ])));
  }

  Widget dateSliderWidget() {
    return Container(
        height: 63,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 16, right: 16),
          itemCount: globals.selectedMonthIndex == currentmonth
              ? int.parse("${selectedDate2.day}")
              : noOfDaysInCurrentMonth,
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                setState(() {
                  currentDateSelectedIndex = index;

                  String currentdateString =
                      (index + 1).toString().padLeft(2, '0');

                  asuumeCurrentDate =
                      "$currentYear-$monthindex-$currentdateString"; //SET  THE SELECTED DATE
                  globals.getdatefromslider = asuumeCurrentDate;
                  // print(asuumeCurrentDate);
                });

                widget.onUpdateWidget(true);
              },
              child: Container(
                height: 50,
                width: 53,
                margin: EdgeInsets.only(left: index == 0 ? 0 : 13),
                padding: EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: currentDateSelectedIndex == index
                        ? Border.all(color: Color(0xffFAA45F), width: 1.5)
                        : Border.all(color: Color(0xffBFBFBF), width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                    color: currentDateSelectedIndex == index
                        ? Colors.white
                        : Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 3.5,
                    ),
                    Text(
                      ((index + 1)).toString(),
                      style: TextStyle(
                          fontSize: globals.deviceType == 'phone' ? 17 : 25,
                          fontWeight: FontWeight.w500,
                          fontFamily: "SF UI Display Medium",
                          color: currentDateSelectedIndex == index
                              ? AppTheme.textColor1
                              : AppTheme.textColor1),
                    ),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text(
                      // DAYS
                      listOfDays[(startingdate.weekday + index - 1) % 7]
                          .toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: globals.deviceType == 'phone' ? 14 : 22,
                          fontWeight: currentDateSelectedIndex == index
                              ? FontWeight.w500
                              : FontWeight.w400,
                          fontFamily: "SF UI Display Regular",
                          color: currentDateSelectedIndex == index
                              ? AppTheme.subtitleTextColor
                              : AppTheme.subtitleTextColor),
                    ),
                    SizedBox(
                      height: 2.5,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
