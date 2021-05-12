import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studo/model/classModel.dart';
import 'package:studo/model/subjectModel.dart';
import 'package:studo/model/teacherModel.dart';
import 'package:studo/widgets/daysOfWeekWidget.dart';
import 'package:studo/widgets/subject/newSubject.dart';
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
  Color bColor;

  bool threeLine = false;

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
    final classData = Provider.of<Classes>(
      context,
      listen: false,
    );
    final teacherData = Provider.of<Teachers>(
      context,
      listen: false,
    );

    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Icon(
              Icons.edit,
              color: Colors.grey,
              size: 40,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.668),
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to remove the class?'),
              actions: <Widget>[
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                )
              ],
            ),
          );
        } else
          return Navigator.of(context)
              .pushNamed(NewSubject.routeName, arguments: id);
      },
      onDismissed: (direction) {
        Provider.of<Classes>(context, listen: false).deleteClass(id);
      },
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
                subtitle: Text('Class time: ' + startTime + ' - ' + endTime),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Teacher: ' +
                        teacherData.items[int.parse(teacherID)].name),
                    Text('Room: ' + room),
                  ],
                ),
                isThreeLine: threeLine,
                onTap: () {
                  //threeLine = !threeLine;
                  //(context as Element).markNeedsBuild();
                })
          ],
        ),
      ),
    );

    /* return ListTile(
      title: Text(subjectData.findById(subjectID).name),
      leading: CircleAvatar(),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  NewClass.routeName,
                  arguments: id,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<Classes>(
                  context,
                  listen: false,
                ).deleteClass(id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );*/
  }
}
