import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/PageViewer.dart';
import 'package:todo/screens/FirstScreen.dart';
import 'package:todo/screens/ReminderList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirstScreen.id,
      debugShowCheckedModeBanner: false,
      routes: {
        FirstScreen.id: (context) => FirstScreen(),
        PageViewer.id: (context) => PageViewer(),
        ReminderList.id: (context) => ReminderList(),

      },
    );
  }
}

