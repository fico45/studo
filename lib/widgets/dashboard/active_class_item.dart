import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studo/model/subjectModel.dart';
import 'package:studo/model/teacherModel.dart';

class ActiveClassItem extends StatelessWidget {
  final String id;
  final String subjectName;
  final String type;
  final String room;
  final String teacherID;
  final String daysOfWeek;
  final String startTime;
  final String endTime;
  final String subjectColor;
  ActiveClassItem(
      this.id,
      this.subjectName,
      this.type,
      this.room,
      this.teacherID,
      this.daysOfWeek,
      this.startTime,
      this.endTime,
      this.subjectColor);

  @override
  Widget build(BuildContext context) {
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
                          subjectName,
                          textScaleFactor: 1.6,
                        ),
                        Text(
                          type,
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
                          right: 20,
                          left: size.width * 0.35,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 30,
                            ),
                            Text(
                              room,
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
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer),
                            Text(
                              startTime + ' -- ',
                              textAlign: TextAlign.start,
                            ),

                            /*  SizedBox(
                              width: size.width * 0.7,
                              child: LinearProgressIndicator(
                                value: controller.value,
                                backgroundColor: Colors.cyanAccent,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                                minHeight: 6,
                              ),
                            ), */
                            Text(
                              endTime,
                              textAlign: TextAlign.start,
                            ),
                            Icon(Icons.timer_off),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 25, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people),
                    Text(
                      teacherData.findById(teacherID).name,
                      textScaleFactor: 1.6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
