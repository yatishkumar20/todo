import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({this.title, this.style, this.onPressed});

  final String title;

  final TextStyle style;

  final Object onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          side: BorderSide(color: Colors.black, width: 1),
          padding: EdgeInsets.all(15)),
      onPressed: onPressed,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }
}