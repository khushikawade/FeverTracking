import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/modules/logs/sliders/dateslider.dart';
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/utils/utility.dart';

class MonthSlider extends StatefulWidget {
  Function onUpdateWidget;
  bool isdefaultcall;
  // final int selectedTabIndex;
  MonthSlider(
      {Key key, @required this.onUpdateWidget, @required this.isdefaultcall})
      : super(key: key);

  @override
  _MonthSliderState createState() => _MonthSliderState();
}

class _MonthSliderState extends State<MonthSlider>
    with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now(); // TO tracking date
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController tabController;
  int currentMonthSelectedIndex = 0;
  int isfutureIndex;
  currentIndex() {
    var now = new DateTime.now();
    var monthformatter = new DateFormat('M');
    String formattedDate = monthformatter.format(now);
    currentMonthSelectedIndex = int.parse(formattedDate);
    isfutureIndex = currentMonthSelectedIndex;
    globals.selectedMonthIndex = currentMonthSelectedIndex - 1;
    // print(globals.selectedMonthIndex);
  }

  List<bool> _isDisabled = [false, true];
  onTap() {
    if (_isDisabled[tabController.index]) {
      int index = tabController.previousIndex;
      setState(() {
        tabController.index = index;
      });
    }
  }

  ScrollController scrollController =
      ScrollController(); //To Track Scroll of ListView

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

  // List<String> listOfMonths = [
  //   "January",
  //   "February",
  //   "March",
  //   "April ",
  //   "May ",
  //   "June",
  //   "July",
  //   "August ",
  //   "September",
  //   "October",
  //   "November",
  //   "December"
  // ];
  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  bool isfutureMonthIndex = false;
  @override
  void initState() {
    super.initState();
    currentIndex();
    print("month init call");
    tabController = TabController(
      length: listOfMonthsTabs.length,
      vsync: this,
      initialIndex: currentMonthSelectedIndex - 1,
    );

    tabController.addListener(() {
      setState(() {
        if (tabController.indexIsChanging) {
          this._handleTabSelection();
        }
      });
    });
  }

  _handleTabSelection() async {
    int index = tabController.previousIndex;
    setState(() {
      if ((tabController.index) < isfutureIndex) {
        // currentMonthSelectedIndex = tabController.index;
        globals.selectedMonthIndex = tabController.index;
        isfutureMonthIndex = false;
        // print("inside if block index is            ${tabController.index}");
        // print("INSIDE THETABBAR LiSNtner  $currentMonthSelectedIndex");
      } else {
        isfutureMonthIndex = true;
        setState(() {
          tabController.index = index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
            length: listOfMonthsTabs.length,
            // initialIndex: 2,
            // child: Builder(builder: (BuildContext context) {
            //   tabController = DefaultTabController.of(context);
            //   tabController.addListener(() {
            //     if (!tabController.indexIsChanging) {
            //       this._handleTabSelection();

            //       // print(
            //       //     "index  MonthSliderPAGE  IN BULIDER  : *      $currentMonthSelectedIndex");
            //     } else {
            //       //tab is finished animating you get the current index
            //       //here you can get your index or run some method once.
            //       print("");
            //       // print(tabController.index);
            //     }
            //   });

            // return

            child: Column(
              children: [
                Container(
                  height: 52,
                  color: Theme.of(context).primaryColor,
                  child: TabBar(
                    onTap: (int index) {},
                    controller: tabController,
                    tabs: listOfMonthsTabs,
                    // indicatorColor: Theme.of(context).accentColor,
                    indicatorWeight: 4,
                    isScrollable: true,

                    labelPadding: EdgeInsets.symmetric(horizontal: 22.0),

                    // labelColor: Colors.red,
                    labelStyle: TextStyle(
                        fontSize: globals.deviceType == 'phone' ? 14 : 22,
                        // color: AppTheme.titleColor,
                        // color: Color(0xffFAA45F),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SF UI Display Semibold'),

                    labelColor: Theme.of(context).accentColor,
                    unselectedLabelColor: AppTheme.titleColor,
                    // automaticIndicatorColorAdjustment: true,

                    unselectedLabelStyle: TextStyle(
                        fontSize: globals.deviceType == 'phone' ? 14 : 22,
                        fontWeight: FontWeight.w600,
                        // color: AppTheme.titleColor1,
                        color: AppTheme.titleColor.withOpacity(0.50),
                        fontFamily:
                            'SF UI Display Semibold'), //For Un-selected Tabs
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: listOfMonthsTabs.map((Tab tab) {
                      final String selectedMonthlabel = tab.text.toLowerCase();
                      // final index = DefaultTabController.of(context).index;
                      return selectedMonthlabel != null &&
                              isfutureMonthIndex == false
                          ? DateSlider(
                              onUpdateWidget: (bool result) {
                                widget.onUpdateWidget(result);
                              },
                              isdefaultcall: widget.isdefaultcall)
                          : Container(
                              child: Center(
                                child: Text(""),
                              ),
                            );
                    }).toList(),
                  ),
                ),
              ],
            )));
  }
}
