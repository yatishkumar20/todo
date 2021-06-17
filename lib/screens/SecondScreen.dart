import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/util/constants.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top * 3;
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      body: Container(
        margin: EdgeInsets.only(
            top: topPadding, left: kSidePadding, right: kSidePadding),
        child: Center(
          child: Column(
            children: <Widget>[
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Clear sort items by ',
                  style: TextStyle(fontSize: kScreenTitleFont, color: Colors.black),
                  children: const <TextSpan>[
                    TextSpan(
                        text: 'priority.',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: kScreenTitleSeparator,
              ),
              Text(
                'Important items are highlighted at the top....',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: kScreenTitleFont),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.all(kImagePadding),
                  child: Image.asset('images/img.png')),
            ],
          ),
        ),
      ),
    );
  }
}
