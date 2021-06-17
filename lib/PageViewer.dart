import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:todo/screens/EighthScreen.dart';
import 'package:todo/screens/FifthScreen.dart';
import 'package:todo/screens/FourthScreen.dart';
import 'package:todo/screens/SecondScreen.dart';
import 'package:todo/screens/SeventhScreen.dart';
import 'package:todo/screens/SixthScreen.dart';
import 'package:todo/screens/ThirdScreen.dart';
import 'package:todo/util/constants.dart';

class PageViewer extends StatefulWidget {
  static String id = 'page_viewer';

  @override
  _PageViewerState createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {
  int currentScreenValue = 0;
  PageController controller;

  /// List of screens
  final List<Widget> screens = [
    SecondScreen(),
    ThirdScreen(),
    FourthScreen(),
    FifthScreen(),
    SixthScreen(),
    SeventhScreen(),
    EighthScreen()
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentScreenValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: PageIndicatorContainer(
            padding: EdgeInsets.only(bottom: kDotBottomPadding),
            indicatorColor: Colors.grey,
            indicatorSelectorColor: Colors.black,
            child: PageView(
              children: screens,
              controller: controller,
            ),
            length: screens.length,
            align: IndicatorAlign.bottom,
          ),
        ));
  }
}
