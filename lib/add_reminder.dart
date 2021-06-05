import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo/NotificactionServices.dart';
import 'package:todo/main.dart';

class AddReminder extends StatefulWidget {
  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final _fireStore = FirebaseFirestore.instance;
  final reminder = TextEditingController();
  String dateTime;
  bool reminderValidator = false;
  bool dateTimeValidator = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationServices notificationServices;

  @override
  void initState() {
    super.initState();
    notificationServices = NotificationServices();
    flutterLocalNotificationsPlugin.initialize(notificationServices.init(),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return MyApp();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reminder'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: reminder,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add reminder',
                errorText: reminderValidator ? 'Reminder cant be empty' : null,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            DateTimePicker(
                type: DateTimePickerType.dateTime,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select date and time',
                  errorText:
                      dateTimeValidator ? 'Date and time cant be empty' : null,
                ),
                initialValue: '',
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Date',
                onChanged: (val) {
                  setState(() {
                    dateTime = val;
                  });
                },
                validator: (val) {
                  return null;
                },
                onSaved: (val) {
                  dateTime = val;
                }),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                setState(() {
                  reminder.text == ''
                      ? reminderValidator = true
                      : reminderValidator = false;
                  dateTime == null
                      ? dateTimeValidator = true
                      : dateTimeValidator = false;
                });

                if (!reminderValidator && !dateTimeValidator) {
                  _fireStore.collection('todo').add({
                    'title': reminder.text,
                    'dateTime': dateTime,
                    'completed': false
                  });
                  await notificationServices.scheduleNotification(
                      reminder.text, dateTime);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
