import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/utils/utils.dart';

import 'newSubject.dart';
import 'package:studo/model/subjectModel.dart';

class SubjectItem extends StatelessWidget {
  final String id;
  final String name;
  final String color;
  final String year;

  SubjectItem(this.id, this.name, this.color, this.year);
  Color avatarColor;

  Color _getColorFromHex(String hexColor) {
    hexColor = color.replaceAll('#', "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }

    print(avatarColor);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      leading: CircleAvatar(
        backgroundColor: avatarColor = _getColorFromHex(color),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  NewSubject.routeName,
                  arguments: id,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<Subjects>(
                  context,
                  listen: false,
                ).deleteSubject(id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
