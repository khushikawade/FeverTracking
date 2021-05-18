import 'package:charts_flutter/flutter.dart' as charts;

import 'package:mobile_app/src/db/db_services.dart';

import 'package:flutter/material.dart';
import 'package:mobile_app/src/home_tabs/custom_tab.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/home_tabs/day_tab.dart';
import 'package:mobile_app/src/home_tabs/month_tab.dart';
import 'package:mobile_app/src/home_tabs/week_tab.dart';
import 'package:mobile_app/src/styles/theme.dart';

class UserTemperaturePage extends StatefulWidget {
  Function onUpdateWidget;
  UserTemperaturePage({Key key, this.onUpdateWidget}) : super(key: key);
  @override
  _UserTemperaturePageState createState() => _UserTemperaturePageState();
}

class _UserTemperaturePageState extends State<UserTemperaturePage> {
  final List<Tab> tabcontent = <Tab>[
    Tab(text: 'Day'),
    Tab(text: 'Week'),
    Tab(text: 'Month'),
    Tab(text: 'Custom'),
  ];
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: tabcontent.length,
          child: Column(
            children: [
              Container(
                height: 44,
                color: Theme.of(context).primaryColor,
                child: TabBar(
                  onTap: (int index) {
                    setState(() {
                      selectedTabIndex = index;
                    });

                    widget.onUpdateWidget(index);
                  },
                  tabs: tabcontent,
                  indicatorColor: Theme.of(context).accentColor,
                  indicatorWeight: 4,

                  // labelColor: Colors.white,
                  labelStyle: TextStyle(
                      fontSize: globals.deviceType == 'phone' ? 14 : 22,
                      color: AppTheme.titleColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SF UI Display Semibold'),
                  unselectedLabelStyle: TextStyle(
                      fontSize: globals.deviceType == 'phone' ? 14 : 22,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.titleColor.withOpacity(0.50),
                      fontFamily:
                          'SF UI Display Semibold'), //For Un-selected Tabs
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: tabcontent.map((Tab tab) {
                    final String label = tab.text.toLowerCase();
                    return label == "day"
                        ? DayTab(
                            selectedTabIndex: 0,
                          )
                        : label == "week"
                            ? WeekTab(
                                selectedTabIndex: 1,
                              )
                            : label == "month"
                                ? MonthTab(
                                    selectedTabIndex: 2,
                                  )
                                : CustomTab(
                                    selectedTabIndex: 3,
                                  );
                    // return label == "day"
                    //     ? isLoading
                    //         ? CustomLoader()
                    //         : newLogsList != null && newLogsList.length > 0
                    //             ? graphWidget()
                    //             : Center(
                    //                 child: Text(
                    //                   'No Data Found!!',
                    //                   style: TextStyle(
                    //                       fontWeight: FontWeight.w600,
                    //                       color: AppTheme.textColor1,
                    //                       fontFamily: "SF UI Display Regular",
                    //                       fontSize:
                    //                           globals.deviceType == 'phone'
                    //                               ? 17
                    //                               : 25),
                    //                 ),
                    //               )
                    //     : label == "week"
                    //         ? isLoading
                    //             ? CustomLoader()
                    //             : newLogsList != null && newLogsList.length > 0
                    //                 ? graphWidget()
                    //                 : Center(
                    //                     child: Text(
                    //                       'No Data Found!!',
                    //                       style: TextStyle(
                    //                           fontWeight: FontWeight.w600,
                    //                           color: AppTheme.textColor1,
                    //                           fontFamily:
                    //                               "SF UI Display Regular",
                    //                           fontSize:
                    //                               globals.deviceType == 'phone'
                    //                                   ? 17
                    //                                   : 25),
                    //                     ),
                    //                   )
                    //         : label == "month"
                    //             ? isLoading
                    //                 ? CustomLoader()
                    //                 : newLogsList != null &&
                    //                         newLogsList.length > 0
                    //                     ? graphWidget()
                    //                     : Center(
                    //                         child: Text(
                    //                           'No Data Found!!',
                    //                           style: TextStyle(
                    //                               fontWeight: FontWeight.w600,
                    //                               color: AppTheme.textColor1,
                    //                               fontFamily:
                    //                                   "SF UI Display Regular",
                    //                               fontSize:
                    //                                   globals.deviceType ==
                    //                                           'phone'
                    //                                       ? 17
                    //                                       : 25),
                    //                         ),
                    //                       )
                    //             : newLogsList != null && newLogsList.length > 0
                    //                 ? graphWidget()
                    //                 : Center(
                    //                     child: Text(
                    //                       'No Data Found!!',
                    //                       style: TextStyle(
                    //                           fontWeight: FontWeight.w600,
                    //                           color: AppTheme.textColor1,
                    //                           fontFamily:
                    //                               "SF UI Display Regular",
                    //                           fontSize:
                    //                               globals.deviceType == 'phone'
                    //                                   ? 17
                    //                                   : 25),
                    //                     ),
                    //                   );
                  }).toList(),
                ),
              ),
            ],
          )),
    );
  }
}
