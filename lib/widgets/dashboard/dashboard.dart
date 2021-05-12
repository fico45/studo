import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:studo/util/dbhelper.dart';

import 'package:studo/widgets/dashboard/active_class_item.dart';

import 'package:studo/model/classModel.dart';
import 'package:studo/model/subjectModel.dart';

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

  @override
  Widget build(BuildContext context) {
    final classData = Provider.of<Classes>(context);
    final subjectData = Provider.of<Subjects>(context);

    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.2,
          width: size.width,
          child: Stack(
            children: <Widget>[
              ActiveClassItem(),
            ],
          ),
        ),
        Container(
          height: size.height * 0.7,
          child: ListView.builder(
              itemCount: classData.items.length,
              itemBuilder: (_, i) => Column(
                    children: [
                      NextClassItem(
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
                      Divider(),
                    ],
                  )),
        ),
      ],
    );
  }
}