import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/add_reminder.dart';
import 'package:todo/todo.dart';

TextStyle _textStyle = TextStyle(decoration: TextDecoration.lineThrough);

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final fireStore = FirebaseFirestore.instance;
  final List<Todo> items = [];

  @override
  void initState() {
    super.initState();
    todoStream();
  }

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

  List<Widget> getListItems() => items
      .asMap()
      .map((i, item) => MapEntry(i, buildTenableListTile(item, i)))
      .values
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
      ),
      body: Center(
        child: ReorderableListView(
          children: getListItems(),
          onReorder: onReorder,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4.0,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddReminder();
          }));
        },
      ),
    );
  }

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
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.centerLeft,
        color: Colors.green,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        enabled: !item.completed,
        title: Text(
          item.title,
          style: item.completed
              ? _textStyle
              : TextStyle(decoration: TextDecoration.none),
        ),
        subtitle: Text(item.dateTime),
      ),
    );
  }

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
}
