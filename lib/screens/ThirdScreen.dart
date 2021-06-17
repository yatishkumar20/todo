import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/util/constants.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top * 3;
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      body: Container(
        margin: EdgeInsets.only(
            top: topPadding, left: kSidePadding, right: kSidePadding),
        child: Column(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style:
                    TextStyle(fontSize: kScreenTitleFont, color: Colors.black),
                children: const <TextSpan>[
                  TextSpan(
                      text: 'Tap and hold ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'to pick an item up.'),
                ],
              ),
            ),
            SizedBox(
              height: kScreenTitleSeparator,
            ),
            Text(
              'Drag it up or down to change its priority.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: kScreenTitleFont),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
                padding: EdgeInsets.all(kImagePadding),
                child: Image.asset('images/img.png')),
          ],
        ),
      ),
    );
  }
}
