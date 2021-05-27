import 'package:flutter/material.dart';
import 'package:studo/view/examView.dart';
import 'package:studo/view/teacherView.dart';
import 'package:studo/view/subjectView.dart';
import 'package:studo/view/classView.dart';

class DashDrawer extends StatelessWidget {
  static const routeName = '/drawer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        AppBar(
          title: Text('Pregled kategorija'),
          automaticallyImplyLeading: false,
        ),
        ListTile(
          leading: Icon(Icons.people),
          title: Text('Profesori'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(TeacherView.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.school),
          title: Text('Kolegiji'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(SubjectView.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.timelapse),
          title: Text('Predavanja'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(ClassView.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.book),
          title: Text('Ispiti'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(ExamView.routeName);
          },
        ),
        Divider(),
      ],
    ));
  }
}
