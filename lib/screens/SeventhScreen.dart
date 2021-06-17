import 'package:flutter/material.dart';
import 'package:todo/Widget/ButtonWidget.dart';
import 'package:todo/util/constants.dart';

class SeventhScreen extends StatelessWidget {
  const SeventhScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      body: Container(
        margin: EdgeInsets.only(
            top: topPadding, left: kSidePadding, right: kSidePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/cloud.png'),
            SizedBox(
              height: 50,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: 40, color: Colors.black),
                children: const <TextSpan>[
                  TextSpan(text: 'Use '),
                  TextSpan(
                      text: 'iCloud',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '?'),
                ],
              ),
            ),
            SizedBox(
              height: kScreenTitleSeparator,
            ),
            Text(
                'Storing your lists in iCloud allows you to keep your data in sync across your iPhone, iPad and Mac.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: kScreenTitleFont)),
            SizedBox(
              height: kScreenTitleSeparator * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  title: 'Not Now',
                  style: TextStyle(
                      fontSize: kScreenTitleFont,
                      fontWeight: FontWeight.normal),
                  onPressed: () {},
                ),
                ButtonWidget(
                    title: 'Use iCloud',
                    style: TextStyle(
                        fontSize: kScreenTitleFont,
                        fontWeight: FontWeight.bold),
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
