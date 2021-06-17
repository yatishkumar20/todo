import 'package:flutter/material.dart';
import 'package:todo/util/constants.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({Key key}) : super(key: key);

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
            Text(
              'There are three navigation levels...',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: kScreenTitleFont),
            ),
            SizedBox(
              height: 90,
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
