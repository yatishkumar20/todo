import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  InitializationSettings init() {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    return InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOs,
        macOS: null);
  }


  Future<void> scheduleNotification(String title, String dateTime) async {
    DateTime parseDate = DateTime.parse(dateTime);
    print(parseDate);
    var scheduledNotificationDateTime = parseDate;
    DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android : androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics, macOS: null);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        title,
        'you have a reminder set',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
}