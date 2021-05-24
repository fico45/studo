import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studo/model/teacherModel.dart';
//import 'package:studo/util/dbhelper.dart';

import 'package:studo/widgets/dashboard/active_class_item.dart';

import 'package:studo/model/classModel.dart';
import 'package:studo/model/subjectModel.dart';

import '../fab.dart';
import 'next_class_item.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State {
  // DbHelper helper = DbHelper();
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Classes>(context).getItems();

      Provider.of<Teachers>(context).fetchTeachers().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final classData = Provider.of<Classes>(context);
    final subjectData = Provider.of<Subjects>(context);

    // DateTime date = DateTime.now();
    //List<Class> todayItems = Provider.of<Classes>(context).todayItems.toList();

    /* where((cl) {
      if (date.day == 7) {
        return json.decode(cl.daysOfWeek)[0];
      } else {
        return json.decode(cl.daysOfWeek)[date.day];
      }
    }).toList(); */
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: ExpandableFab(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Container(
                  height: size.height * 0.2,
                  width: size.width,
                  child: Stack(
                    children: <Widget>[
                      ActiveClassItem(
                          classData.todayItems[0].id,
                          classData.todayItems[0].subjectID,
                          classData.todayItems[0].type,
                          classData.todayItems[0].room,
                          classData.todayItems[0].teacherID,
                          classData.todayItems[0].daysOfWeek,
                          classData.todayItems[0].startTime,
                          classData.todayItems[0].endTime,
                          subjectData
                              .findById(classData.todayItems[0].subjectID)
                              .color),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.7,
                  child: ListView.builder(
                      itemCount: classData.todayItems.length,
                      itemBuilder: (context, i) => Column(
                            children: [
                              NextClassItem(
                                  classData.todayItems[i].id,
                                  classData.todayItems[i].subjectID,
                                  classData.todayItems[i].type,
                                  classData.todayItems[i].room,
                                  classData.todayItems[i].teacherID,
                                  classData.todayItems[i].daysOfWeek,
                                  classData.todayItems[i].startTime,
                                  classData.todayItems[i].endTime,
                                  subjectData
                                      .findById(
                                          classData.todayItems[i].subjectID)
                                      .color),
                              Divider(),

                              /*  NextClassItem(
                                  classData.items[i].id,
                                  classData.items[i].subjectID,
                                  classData.items[i].type,
                                  classData.items[i].room,
                                  classData.items[i].teacherID,
                                  classData.items[i].daysOfWeek,
                                  classData.items[i].startTime,
                                  classData.items[i].endTime,
                                  subjectData
                                      .findById(classData.items[i].subjectID)
                                      .color),
                              Divider(), */
                            ],
                          )),
                ),
              ],
            ),
    );
  }
}
