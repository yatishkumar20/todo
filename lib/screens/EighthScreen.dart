import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/ReminderList.dart';
import 'package:todo/util/constants.dart';

class EighthScreen extends StatelessWidget {
  const EighthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      body: Container(
        margin: EdgeInsets.only(left: kSidePadding, right: kSidePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'Sign up to the newsletter, and unlock a theme for your lists.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: kScreenTitleFont)),
            SizedBox(
              height: 0,
            ),
            Image.asset('images/email.png'),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(kButtonSidePadding),
              child: Center(
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email address',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: kButtonSidePadding, right: kButtonSidePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonWidget(
                    buttonTitle: 'Skip',
                  ),
                  ButtonWidget(
                    buttonTitle: 'Join',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  ButtonWidget({this.buttonTitle});

  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            side: BorderSide(color: Colors.black, width: 1),
            padding: EdgeInsets.only(
                top: kButtonTopPadding,
                bottom: kButtonTopPadding,
                left: kButtonSidePadding,
                right: kButtonSidePadding)),
        child: Text(
          buttonTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: kScreenTitleFont, fontWeight: FontWeight.normal),
        ),
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              ReminderList.id, (Route<dynamic> route) => false);
        });
  }
}
