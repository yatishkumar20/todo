import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/PageViewer.dart';
import 'package:todo/util/constants.dart';

class FirstScreen extends StatelessWidget {
  static String id = 'first_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          launchIntroScreen(context);
        },
        onHorizontalDragUpdate: (detail) {
          launchIntroScreen(context);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Welcome to ',
                  style:
                      TextStyle(fontSize: kTitleFontSize, color: Colors.black),
                  children: [
                    TextSpan(
                        text: 'Clear',
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              SizedBox(
                height: kLineSeparatorHeight,
              ),
              RichText(
                text: TextSpan(
                  text: 'Tap or swipe ',
                  style: TextStyle(
                      fontSize: kSubTitleFontSize,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: 'to begin.',
                        style: TextStyle(fontWeight: FontWeight.normal))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// on tap or on swipe launch next screens
  void launchIntroScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, PageViewer.id, (Route<dynamic> route) => false);
  }
}
