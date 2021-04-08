import 'package:flutter/material.dart';
import 'package:studo/view/examView.dart';
import 'package:studo/view/teacherView.dart';
import 'package:studo/view/subjectView.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          title: Text('Hello Friend!'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.dashboard),
          title: Text('Dashboard'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.people),
          title: Text('Teachers'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(TeacherView.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.school),
          title: Text('Subjects'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(SubjectView.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.book),
          title: Text('Exams'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(ExamView.routeName);
          },
        ),
        Divider(),
      ],
    ));
  }
}
