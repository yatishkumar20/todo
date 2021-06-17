import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/NotificactionServices.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo/util/constants.dart';

TextStyle _kTextStyle =
    TextStyle(decoration: TextDecoration.lineThrough, color: Colors.white);

class ReminderList extends StatefulWidget {
  static String id = 'task_list';

  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, displayColor: Colors.white)),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _fireStore = FirebaseFirestore.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationServices notificationServices;
  final fireStore = FirebaseFirestore.instance;
  final List<Todo> items = [];
  final reminder = TextEditingController();
  bool showDateTimeField = false;
  String dateTime;

  @override
  void initState() {
    super.initState();
    notificationServices = NotificationServices();
    flutterLocalNotificationsPlugin.initialize(notificationServices.init(),
        onSelectNotification: onSelectNotification);
    todoStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            addReminderWidget(),
            Visibility(
              visible: showDateTimeField,
              child: Container(
                child: buildDateTimePicker(),
              ),
            ),
            Expanded(
                child: ReorderableListView(
              children: getListItems(),
              onReorder: onReorder,
            )),
          ],
        ),
      ),
    );
  }

  /// Add reminder text view
  Widget addReminderWidget() {
    return Column(
      children: [
        Container(
          child: TextField(
            controller: reminder,
            textInputAction: TextInputAction.done,
            style: kReminderTextStyle,
            onSubmitted: (value) {
              if (reminder.text.length > 0) {
                showDateTimeField = true;
                setState(() {});
              }
            },
            cursorHeight: kTextFieldHeight,
            cursorWidth: kTextFieldWidth,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: 'Enter reminder here',
              hintStyle: kReminderTextStyle,
              fillColor: Colors.red.shade800,
              filled: true,
            ),
          ),
        ),
      ],
    );
  }

  /// Date time picker
  DateTimePicker buildDateTimePicker() {
    return DateTimePicker(
        type: DateTimePickerType.dateTime,
        decoration: InputDecoration(
          hintText: 'Select date and time',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: kDateTimeStyle,
          fillColor: Colors.red.shade800,
          filled: true,
        ),
        initialValue: '',
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        dateLabelText: 'Date',
        onChanged: (val) async {
          setState(() {
            dateTime = val;
            showDateTimeField = false;
          });
          _fireStore.collection('todo').add({
            'title': reminder.text,
            'dateTime': dateTime,
            'completed': false
          });
          await notificationServices.scheduleNotification(
              reminder.text, dateTime);
          reminder.clear();
        },
        validator: (val) {
          return null;
        },
        onSaved: (val) {
          dateTime = val;
        });
  }

  List<Widget> getListItems() => items
      .asMap()
      .map((i, item) => MapEntry(i, buildTenableListTile(item, i)))
      .values
      .toList();

  /// get data from firebase
  void todoStream() async {
    await for (var snapshot in fireStore.collection('todo').snapshots()) {
      items.clear();
      for (var message in snapshot.docs) {
        if (message != null &&
            message.get('title') != null &&
            message.get('dateTime') != null) {
          setState(() {
            items.add(Todo(
                id: message.id,
                title: message.get('title'),
                dateTime: message.get('dateTime'),
                completed: message.get('completed')));
          });
          setState(() {
            items.sort((a, b) {
              if (b.completed) {
                return -1;
              }
              return 1;
            });
          });
        }
      }
    }
  }

  /// List view builder
  Widget buildTenableListTile(Todo item, int index) {
    return Dismissible(
      key: UniqueKey(),
      direction: item.completed ? null : DismissDirection.horizontal,
      onDismissed: (direction) {
        setState(() {
          if (direction == DismissDirection.endToStart) {
            items.removeAt(index);
            fireStore.collection('todo').doc(item.id).delete();
          } else {
            fireStore
                .collection('todo')
                .doc(item.id)
                .update({'completed': true});
          }
        });
      },
      background: Container(
        padding: EdgeInsets.all(kListItemPadding),
        alignment: Alignment.centerLeft,
        color: Colors.green,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.all(kListItemPadding),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
      child: Container(
        color: getBackGroundColor(index),
        child: ListTile(
          enabled: !item.completed,
          title: Text(
            item.title,
            style: item.completed
                ? _kTextStyle
                : TextStyle(
                    decoration: TextDecoration.none, color: Colors.white),
          ),
          subtitle: Text(
            item.dateTime,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  /// tap and reorder
  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex == items.length) {
        newIndex = items.length - 1;
      }
      var item = items.removeAt(oldIndex);
      if (newIndex == items.length) {
        fireStore.collection('todo').doc(item.id).update({'completed': true});
      }
      items.insert(newIndex, item);
    });
  }

  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ReminderList();
    }));
  }

  /// get different color shade for list item
  Color getBackGroundColor(int index) {
    if (index < colorShades.length) {
      return colorShades[index];
    } else {
      return colorShades[colorShades.length - 1];
    }
  }
}
