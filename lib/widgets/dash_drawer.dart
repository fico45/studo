import 'package:flutter/material.dart';
import 'package:studo/view/examView.dart';
import 'package:studo/view/teacherView.dart';
import 'package:studo/view/subjectView.dart';
import 'package:studo/view/classView.dart';
import 'package:studo/widgets/bouncy_page_route.dart';

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
            Navigator.push(context, BouncyPageRoute(TeacherView()));
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.school),
          title: Text('Kolegiji'),
          onTap: () {
            Navigator.push(context, BouncyPageRoute(SubjectView()));
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.timelapse),
          title: Text('Predavanja'),
          onTap: () {
            Navigator.push(context, BouncyPageRoute(ClassView()));
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.book),
          title: Text('Ispiti'),
          onTap: () {
            Navigator.push(context, BouncyPageRoute(ExamView()));
          },
        ),
        Divider(),
      ],
    ));
  }
}
