import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studo/model/classModel.dart';

import 'package:studo/model/subjectModel.dart';
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
    final classData = Provider.of<Classes>(context);
    final subjectData = Provider.of<Subjects>(context);
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
              leading: Text(type),
              title: Text(
                subjectData.findById(subjectID).name,
                textAlign: TextAlign.center,
              ),
              subtitle: Text('Class time: ' + startTime + ' - ' + endTime),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Text('Teacher: ' + teacherData.items[teacherID].name),
                  Text('Room: ' + room),
                ],
              ),
              onTap: () {})
        ],
      ),
    );
  }
}
