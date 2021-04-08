import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studo/model/teacherModel.dart';
import 'package:studo/widgets/teacher/newTeacher.dart';

class TeacherItem extends StatelessWidget {
  final String id;
  final String name;

  TeacherItem(this.id, this.name);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      leading: CircleAvatar(),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  NewTeacher.routeName,
                  arguments: id,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<Teachers>(
                  context,
                  listen: false,
                ).deleteTeacher(id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
