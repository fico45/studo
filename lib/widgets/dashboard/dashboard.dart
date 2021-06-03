import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'package:studo/util/dbhelper.dart';

import 'package:studo/widgets/dashboard/Items/active_class_item.dart';

import 'package:studo/model/classModel.dart';
import 'package:studo/model/subjectModel.dart';
import 'package:studo/widgets/dashboard/empty_dash.dart';

import 'Items/next_class_item.dart';

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
      Provider.of<Classes>(context, listen: false);

      Provider.of<Subjects>(context, listen: false)
          .getItems()
          .then((_) => _isLoading = false);
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

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : classData.todayItems.isNotEmpty
                ? Column(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.2,
                        width: size.width,
                        child: Stack(
                          children: <Widget>[
                            ActiveClassItem(
                                classData.todayItems[0].id,
                                subjectData
                                    .findById(classData.todayItems[0].subjectID)
                                    .name,
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
                          itemCount: classData.upcomingClasses.length,
                          itemBuilder: (context, i) {
                            return Column(
                              children: [
                                if (classData.upcomingClasses.length == i + 1)
                                  Column(
                                    children: [
                                      NextClassItem(
                                          classData
                                              .upcomingClasses[classData
                                                      .upcomingClasses.length -
                                                  1]
                                              .id,
                                          classData
                                              .upcomingClasses[classData
                                                      .upcomingClasses.length -
                                                  1]
                                              .subjectID,
                                          classData
                                              .upcomingClasses[classData
                                                      .upcomingClasses.length -
                                                  1]
                                              .type,
                                          classData
                                              .upcomingClasses[classData
                                                      .upcomingClasses.length -
                                                  1]
                                              .room,
                                          classData
                                              .upcomingClasses[classData
                                                      .upcomingClasses.length -
                                                  1]
                                              .teacherID,
                                          classData
                                              .upcomingClasses[classData
                                                      .upcomingClasses.length -
                                                  1]
                                              .daysOfWeek,
                                          classData
                                              .upcomingClasses[
                                                  classData.upcomingClasses.length -
                                                      1]
                                              .startTime,
                                          classData
                                              .upcomingClasses[classData.upcomingClasses.length - 1]
                                              .endTime,
                                          subjectData.findById(classData.upcomingClasses[classData.upcomingClasses.length - 1].subjectID).color),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    classData
                                                        .upcomingClasses[classData
                                                                .upcomingClasses
                                                                .length -
                                                            1]
                                                        .endTime,
                                                    textScaleFactor: 1.5,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                else if (i >= 0)
                                  Column(
                                    children: [
                                      NextClassItem(
                                          classData.upcomingClasses[i].id,
                                          classData
                                              .upcomingClasses[i].subjectID,
                                          classData.upcomingClasses[i].type,
                                          classData.upcomingClasses[i].room,
                                          classData
                                              .upcomingClasses[i].teacherID,
                                          classData
                                              .upcomingClasses[i].daysOfWeek,
                                          classData
                                              .upcomingClasses[i].startTime,
                                          classData.upcomingClasses[i].endTime,
                                          subjectData
                                              .findById(classData
                                                  .upcomingClasses[i].subjectID)
                                              .color),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        classData
                                                            .upcomingClasses[i]
                                                            .endTime,
                                                        textScaleFactor: 1.5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            classData
                                                                .upcomingClasses[
                                                                    i + 1]
                                                                .startTime,
                                                            textScaleFactor:
                                                                1.5,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Material(
                                                  color: Colors.black,
                                                  child: InkWell(
                                                    child: SizedBox(
                                                      width: 5,
                                                      height: 40,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                else if (i == classData.upcomingClasses.length)
                                  Text("Ovo mora biti na kraju")
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : EmptyDash());
  }
}
