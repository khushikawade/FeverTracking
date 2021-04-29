import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Color(0xff463DC7),
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(
            onPressed: () async {
              // int index = await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => MenuScreen(selectedIndex)),
              // );
              // if (index != null) {
              //   setState(() {
              //     selectedIndex = index;
              //     print("Selected Index : ${selectedIndex}");
              //   });
              // }
            },
            icon: Icon(
              IconData(0xea14, fontFamily: "FeverTracking"),
              color: Color(0xffFFFFFF),
              size: 24,
            ),
          ),
        ),
        actions: [
          selectedIndex == 3
              ? Container(
                  height: 0,
                  width: 0,
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    onPressed: () async {
                      // if (selectedIndex == 3) {
                      //   updateProfileSuccess = await Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => EditProfileScreen()),
                      //   );
                      //   if (updateProfileSuccess != null && updateProfileSuccess) {
                      //     print("Result : ${updateProfileSuccess}");
                      //     setState(() {});
                      //   }
                      // }
                      //Navigator.pop(context);
                    },
                    icon: Icon(
                      IconData(
                          selectedIndex == 0
                              ? 0xea10
                              : selectedIndex == 1
                                  ? 0xea19
                                  : 0xea12,
                          fontFamily: "FeverTracking"),
                      color: Color(0xffFFFFFF),
                      size: 24,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
