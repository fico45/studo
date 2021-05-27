import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studo/model/classModel.dart';

import 'package:studo/model/subjectModel.dart';
import 'package:studo/model/teacherModel.dart';
import 'package:studo/widgets/class/class_item.dart';

class NextClassItem extends StatelessWidget {
  final String id;
  final String subjectID;
  final String type;
  final String room;
  final String teacherID;
  final String daysOfWeek;
  final String startTime;
  final String endTime;
  final String subjectColor;

  NextClassItem(this.id, this.subjectID, this.type, this.room, this.teacherID,
      this.daysOfWeek, this.startTime, this.endTime, this.subjectColor);
  Color bColor;

  Color _getColorFromHex(String hexColor) {
    hexColor = subjectColor.replaceAll('#', "");
    if (hexColor.length == 6) {
      hexColor = "6F" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final subjectData = Provider.of<Subjects>(context);
    final teacherData = Provider.of<Teachers>(context);

    DateTime date = DateTime.now();
    return Card(
      borderOnForeground: false,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(20),
      ),
      color: _getColorFromHex(subjectColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
              leading: Container(
                constraints: BoxConstraints(
                    minWidth: 100, maxWidth: 100, minHeight: 200),
                child: Column(
                  children: [
                    Icon(Icons.school),
                    Text(
                      subjectData.findById(subjectID).name,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              title: Container(
                constraints: BoxConstraints(minWidth: 80, maxWidth: 80),
                child: Text(
                  type,
                  textAlign: TextAlign.center,
                ),
              ),
              subtitle: Container(
                constraints: BoxConstraints(minWidth: 80, maxWidth: 80),
                child: Text(
                    'Vrijeme predavanja: \n' + startTime + ' - ' + endTime),
              ),
              trailing: Container(
                constraints: BoxConstraints(minWidth: 80, maxWidth: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                        ),
                        Text('Prostorija: ' + room),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.people),
                        Text('Profesor: ' +
                            teacherData.findById(teacherID).name),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {})
        ],
      ),
    );
  }
}
