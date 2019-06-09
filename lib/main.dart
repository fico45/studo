import 'package:flutter/material.dart';
import 'package:studo/view/dashboard.dart';
import 'package:studo/view/examView.dart';
import 'package:studo/view/teacherView.dart';
import 'package:studo/view/classView.dart';
import 'package:studo/view/settingsView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StuDo',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyHomePage(title: 'StuDo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Dashboard(),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(top: 0.0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Filip Novosel'),
              accountEmail: Text('fnovosel@unipu.hr'),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.android
                        ? Colors.white
                        : Colors.blue,
                child: Text(
                  '45',
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text('Exams'),
              trailing: Icon(Icons.assignment),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => ExamView())),
            ),
            ListTile(
              title: Text('Teachers'),
              trailing: Icon(Icons.people),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => TeachersView())),
            ),
            ListTile(
              title: Text('Classes'),
              trailing: Icon(Icons.event),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => ClassView())),
            ),
            ListTile(
              title: Text('Settings'),
              trailing: Icon(Icons.event),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => SettingsView())),
            )
          ],
        ),
      ),
    );
  }
}
