import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studo/model/classModel.dart';
import 'package:studo/model/subjectModel.dart';
import 'package:studo/model/teacherModel.dart';
import 'package:studo/widgets/class/newClass.dart';
import 'package:studo/widgets/daysOfWeekWidget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ClassItem extends StatelessWidget {
  final String id;
  final String subjectID;
  final String type;
  final String room;
  final String teacherID;
  final String daysOfWeek;
  final String startTime;
  final String endTime;
  final String subjectColor;

  ClassItem(this.id, this.subjectID, this.type, this.room, this.teacherID,
      this.daysOfWeek, this.startTime, this.endTime, this.subjectColor);
  static Color bColor;

  Color _getColorFromHex(String hexColor) {
    hexColor = subjectColor.replaceAll('#', "");
    if (hexColor.length == 6) {
      hexColor = "6F" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  Color _getShadowColor(String hexColor) {
    hexColor = subjectColor.replaceAll('#', "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final subjectData = Provider.of<Subjects>(
      context,
      listen: false,
    );

    final teacherData = Provider.of<Teachers>(
      context,
    );

    return Slidable(
      actionPane: SlidableStrechActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Uredi',
          color: Colors.grey,
          icon: Icons.edit,
          onTap: () {
            Navigator.of(context).pushNamed(NewClass.routeName, arguments: id);
          },
        ),
        IconSlideAction(
          caption: 'Obriši',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Jeste li sigurni?'),
                content: Text('Da li zaista želite obrisati predavanje?'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ne'),
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                  ),
                  TextButton(
                    child: Text('Da'),
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                      Provider.of<Classes>(context, listen: false)
                          .deleteClass(id);
                    },
                  )
                ],
              ),
            );
          },
        ),
      ],
      child: Card(
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
              subtitle: Text('Vrijeme: ' + startTime + ' - ' + endTime),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Profesor: ' + teacherData.findById(teacherID).name),
                  Text('Prostorija: ' + room),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
