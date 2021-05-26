import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:date_util/date_util.dart';

class DateSlider extends StatefulWidget {
  // final int selectedTabIndex;
  // DateSlider({Key key, @required this.selectedTabIndex}) : super(key: key);
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

  int currentDateSelectedIndex = 0; //For Horizontal Date
  //To Track Scroll of ListView

  // int currentMonthSelectedIndex = 0;
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

  List<String> listOfMonths = [
    "January",
    "February",
    "March",
    "April ",
    "May ",
    "June",
    "July",
    "August ",
    "September",
    "October",
    "November",
    "December"
  ];
  DateTime currentDate2 = new DateTime.now();
  DateTime selectedDate2;

  var noOfDaysInCurrentMonth;
  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  TabController _tabController;
  @override
  void initState() {
    super.initState();

    // monthIndex = 0;

    selectedDate2 =
        new DateTime(currentDate2.year, currentDate2.month, currentDate2.day);
    // initialScrollofSetIndex = double.parse("${currentDate2.day}");

    _dateCounter();
  }

  ScrollController scrollController = ScrollController(
    // initialScrollOffset: // or whatever offset you wish
    keepScrollOffset: true,
  );

  @override
  void dispose() {
    super.dispose();
  }

  var dateUtility = DateUtil();
  DateTime getDateTime;
  int currentDate1;
  var date = new DateTime.now().toString();
  var dateParse;
  var currentdate;
  String monthindex;
  int currentmonth;

  DateTime now = new DateTime.now(); // for 5  ->05 format
  void _dateCounter() {
    dateParse = DateTime.parse(date); //current date from date time now

    var startingdate;

    //get the no  days    1....31  in the month
    noOfDaysInCurrentMonth = dateUtility.daysInMonth(
        (globals.selectedMonthIndex + 1), dateParse.year);
    currentYear = "${dateParse.year}";

    // currentMonth = listOfMonths[
    //     globals.selectedMonthIndex]; //set the month which getted from TabBar

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
      startingdate = "$currentYear-$monthindex-01 ";
      getDateTime = new DateFormat("yyyy-MM-dd").parse("$startingdate");

      //if getdatefromslider is null then  initilalize them
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      globals.getdatefromslider == null
          ? globals.getdatefromslider = "$formatted"
          : globals.getdatefromslider = globals.getdatefromslider;

      print("globals.selectedMonthIndex ${globals.getdatefromslider}");
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (globals.selectedMonthIndex == currentmonth ) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     //write or call your logic

    //     //code will run when widget rendering complete

    //     if (scrollController.hasClients) {
    //       Timer(
    //         Duration(seconds: 1),
    //         () => scrollController
    //             .jumpTo(scrollController.position.maxScrollExtent),
    //       );
    //     }
    //   });
    // }
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      SizedBox(height: 15),
      dateSliderWidget(),
      SizedBox(height: 15),
      // To show Calendar Widget
    ])));
  }

  Widget dateSliderWidget() {
    return Container(
        height: 63,
        // width: 60,

        child: Container(
            child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 13);
          },
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

                  String currentdate = (index + 1).toString().padLeft(2, '0');

                  asuumeCurrentDate =
                      "$currentYear-$monthindex-$currentdate"; //SET  THE SELECTED DATE
                  globals.getdatefromslider = asuumeCurrentDate;
                  // print(asuumeCurrentDate);
                });
                print(
                    "  globals.getdatefromslider          ${globals.getdatefromslider}  ");
              },
              child: Container(
                height: 50,
                width: 53,
                padding: EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: currentDateSelectedIndex == index
                        ? Border.all(color: Color(0xffFAA45F), width: 1.5)
                        : Border.all(color: Color(0xffBFBFBF), width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.grey[400],
                    //       offset: Offset(3, 3),
                    //       blurRadius: 5)
                    // ],
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
                      // DATE

                      ((index + 1)).toString(),

                      style: TextStyle(
                          fontSize: 17,
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
                      listOfDays[(getDateTime.weekday + index - 1) % 7]
                          .toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
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
        )));
  }
}
