import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studo/model/examModel.dart';
import 'package:studo/widgets/exam/newExam.dart';

class ExamItem extends StatelessWidget {
  final String id;
  final String name;

  ExamItem(this.id, this.name);
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
                  NewExam.routeName,
                  arguments: id,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<Exams>(
                  context,
                  listen: false,
                ).deleteExam(id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
