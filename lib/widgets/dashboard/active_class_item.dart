import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studo/model/classModel.dart';
import 'package:studo/model/subjectModel.dart';
import 'package:studo/model/teacherModel.dart';

class ActiveClassItem extends StatefulWidget {
  final String id;
  final String subjectID;
  final String type;
  final String room;
  final String teacherID;
  final String daysOfWeek;
  final String startTime;
  final String endTime;
  final String subjectColor;
  ActiveClassItem(this.id, this.subjectID, this.type, this.room, this.teacherID,
      this.daysOfWeek, this.startTime, this.endTime, this.subjectColor);
  @override
  _ActiveClassItemState createState() => _ActiveClassItemState();
}

ActiveClassItem active;
int startHours = int.parse(active.startTime[0] + active.startTime[1]);
int startMinutes = int.parse(active.startTime[3] + active.startTime[4]);
int endHours = int.parse(active.endTime[0] + active.endTime[1]);
int endMinutes = int.parse(active.endTime[3] + active.endTime[4]);

class _ActiveClassItemState extends State<ActiveClassItem>
    with TickerProviderStateMixin {
  AnimationController controller;

  int getDuration() {
    DateTime time = DateTime.now();
    int startHours = time.hour;
    int startMinutes = time.minute;
    int endHours = int.parse(active.endTime[0] + active.endTime[1]);
    int endMinutes = int.parse(active.endTime[3] + active.endTime[4]);

    if (endMinutes - startMinutes < 0) {
      return (endMinutes + startMinutes) * (endHours - startHours) + 1;
    } else
      return (endMinutes + startMinutes) * (endHours - startHours);
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final classData = Provider.of<Classes>(context);
    final subjectData = Provider.of<Subjects>(context);
    final teacherData = Provider.of<Teachers>(context);

    DateTime date = DateTime.now();

    Size size = MediaQuery.of(context).size;
    return Card(
      color: Colors.orangeAccent,
      borderOnForeground: false,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(140),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      top: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.school),
                        Text(
                          subjectData
                              .items[
                                  int.parse(classData.todayItems[0].subjectID)]
                              .name,
                          textScaleFactor: 1.6,
                        ),
                        Text(
                          classData.todayItems[0].type,
                          textScaleFactor: 1.4,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 30,
                          left: size.width * 0.35,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 30,
                            ),
                            Text(
                              classData.todayItems[0].room,
                              textScaleFactor: 1.7,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              classData.todayItems[0].startTime,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              width: size.width * 0.7,
                              child: LinearProgressIndicator(
                                value: controller.value,
                                backgroundColor: Colors.cyanAccent,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                                minHeight: 6,
                              ),
                            ),
                            Text(
                              classData.todayItems[0].endTime,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 15, bottom: 10),
                child: Row(children: [
                  Icon(Icons.people),
                  Text(
                    teacherData
                        .items[int.parse(classData.todayItems[0].teacherID)]
                        .name,
                    textScaleFactor: 1.6,
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
