import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studo/model/classModel.dart';

import 'package:studo/widgets/dashboard/dashboard.dart';
import 'package:studo/view/examView.dart';
import 'package:studo/view/teacherView.dart';
import 'package:studo/view/classView.dart';
import 'package:studo/view/settingsView.dart';
import 'package:studo/widgets/dash_drawer.dart';
import 'package:studo/widgets/class/newClass.dart';
import 'package:studo/widgets/fab.dart';
import 'package:studo/widgets/teacher/newTeacher.dart';
import './model/teacherModel.dart';
import './widgets/subject/newSubject.dart';
import './view/subjectView.dart';
import './model/subjectModel.dart';
import './view/examView.dart';
import './widgets/exam/newExam.dart';
import './model/examModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Teachers(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Subjects(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Exams(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Classes(),
        ),
      ],
      child: MaterialApp(
        title: 'StuDo',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: MyHomePage(title: 'StuDo'),
        routes: {
          NewTeacher.routeName: (context) => NewTeacher(),
          TeacherView.routeName: (context) => TeacherView(),
          NewSubject.routeName: (context) => NewSubject(),
          SubjectView.routeName: (context) => SubjectView(),
          ExamView.routeName: (context) => ExamView(),
          NewExam.routeName: (context) => NewExam(),
          NewClass.routeName: (context) => NewClass(),
          ClassView.routeName: (context) => ClassView(),
          DashDrawer.routeName: (context) => DashDrawer(),
        },
      ),
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
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Subjects>(context, listen: false).getItems();
      Provider.of<Teachers>(context, listen: false).fetchTeachers();
      Provider.of<Exams>(context, listen: false).getItems();

      Provider.of<Classes>(context, listen: false).getItems().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isInit
        ? Center(
            child: CircularProgressIndicator(),
          )
        : new Scaffold(
            appBar: AppBar(
              title: new Text(widget.title),
            ),
            body: Dashboard(),
            floatingActionButton: ExpandableFab(),
          );
  }
}
