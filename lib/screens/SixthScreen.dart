import 'package:flutter/material.dart';
import 'package:todo/util/constants.dart';

class SixthScreen extends StatelessWidget {
  const SixthScreen({Key key}) : super(key: key);

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
                      text: 'Tap on a list ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'to see its content.'),
                ],
              ),
            ),
            SizedBox(
              height: kScreenTitleSeparator,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style:
                    TextStyle(fontSize: kScreenTitleFont, color: Colors.black),
                children: const <TextSpan>[
                  TextSpan(
                      text: 'Tap on a list title ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'to edit it....'),
                ],
              ),
            ),
            SizedBox(
              height: 50,
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
